import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_strings.dart';
import '../../providers/app_settings_provider.dart';
import '../../providers/exposure_provider.dart';
import '../../services/update_service.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettingsProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.settings)),
      body: ListView(
        padding: const EdgeInsets.all(AppDimens.md),
        children: [
          _buildSection(context, '通用', [
            _buildTile(
              context,
              Icons.dark_mode_outlined,
              '深色模式',
              trailing: Switch(
                value: settings.isDarkMode,
                onChanged: (v) => settings.setDarkMode(v),
              ),
            ),
            _buildTile(
              context,
              Icons.notifications_outlined,
              '通知提醒',
              trailing: Switch(
                value: settings.notificationsEnabled,
                onChanged: (v) => settings.setNotifications(v),
              ),
            ),
          ]),
          const SizedBox(height: AppDimens.sm),
          _buildSection(context, '数据', [
            _buildTile(
              context,
              Icons.delete_outline,
              '清除训练记录',
              onTap: () async {
                final ok = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('确认清除'),
                    content: const Text('将清除所有暴露训练记录，此操作不可撤销。'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('取消'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('清除', style: TextStyle(color: AppColors.error)),
                      ),
                    ],
                  ),
                );
                if (ok == true && context.mounted) {
                  context.read<ExposureProvider>().clearAll();
                }
              },
            ),
            _buildTile(
              context,
              Icons.file_download_outlined,
              '导出数据',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('导出功能将在后续版本上线')),
                );
              },
            ),
          ]),
          const SizedBox(height: AppDimens.sm),
          _buildSection(context, '关于', [
            _buildTile(
              context,
              Icons.info_outline,
              AppStrings.about,
              onTap: () => _showAboutDialog(context),
            ),
            _buildTile(
              context,
              Icons.privacy_tip_outlined,
              AppStrings.privacy,
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('隐私政策将在后续版本上线')),
              ),
            ),
            _buildTile(
              context,
              Icons.feedback_outlined,
              AppStrings.feedback,
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('意见反馈功能将在后续版本上线')),
              ),
            ),
            _buildTile(
              context,
              Icons.system_update_outlined,
              '检查更新',
              onTap: () => _checkUpdate(context),
            ),
            _buildTile(
              context,
              Icons.code,
              '${AppStrings.version} ${UpdateService.currentVersion}',
            ),
          ]),
          const SizedBox(height: AppDimens.lg),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.md),
            child: Text(
              AppStrings.disclaimer,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: AppDimens.xxl),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppDimens.md, bottom: AppDimens.sm,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ),
        Card(
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildTile(
    BuildContext context,
    IconData icon,
    String title, {
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 22),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      trailing: trailing ?? (onTap != null ? const Icon(Icons.chevron_right, size: 20) : null),
      onTap: onTap,
    );
  }

  Future<void> _checkUpdate(BuildContext context) async {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      const SnackBar(content: Text('正在检查更新...')),
    );

    final info = await UpdateService().checkForUpdate();

    if (!context.mounted) return;

    if (!info.hasUpdate) {
      scaffold.hideCurrentSnackBar();
      scaffold.showSnackBar(
        SnackBar(content: Text('当前已是最新版本 (${info.latestVersion})')),
      );
      return;
    }

    scaffold.hideCurrentSnackBar();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('发现新版本'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('最新版本: ${info.latestVersion}'),
            if (info.releaseNotes != null && info.releaseNotes!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  info.releaseNotes!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('以后再说'),
          ),
          if (info.downloadUrl != null)
            FilledButton(
              onPressed: () async {
                Navigator.pop(ctx);
                final uri = Uri.parse(info.downloadUrl!);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  scaffold.showSnackBar(
                    const SnackBar(content: Text('无法打开下载链接')),
                  );
                }
              },
              child: const Text('下载更新'),
            ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: AppStrings.appName,
      applicationVersion: UpdateService.currentVersion,
      applicationLegalese: AppStrings.disclaimer,
      children: [
        const SizedBox(height: 16),
        const Text('如释是一款为膀胱害羞症(Paruresis)患者设计的辅助工具。'),
      ],
    );
  }
}
