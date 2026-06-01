import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimens.dart';
import '../../core/constants/app_strings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              trailing: Switch(value: false, onChanged: (_) {}),
            ),
            _buildTile(
              context,
              Icons.notifications_outlined,
              '通知提醒',
              trailing: Switch(value: true, onChanged: (_) {}),
            ),
          ]),
          const SizedBox(height: AppDimens.sm),
          _buildSection(context, '数据', [
            _buildTile(
              context,
              Icons.delete_outline,
              '清除训练记录',
              onTap: () {},
            ),
            _buildTile(
              context,
              Icons.file_download_outlined,
              '导出数据',
              onTap: () {},
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
              onTap: () {},
            ),
            _buildTile(
              context,
              Icons.feedback_outlined,
              AppStrings.feedback,
              onTap: () {},
            ),
            _buildTile(
              context,
              Icons.code,
              '${AppStrings.version} 1.0.0',
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

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: AppStrings.appName,
      applicationVersion: '1.0.0',
      applicationLegalese: AppStrings.disclaimer,
      children: [
        const SizedBox(height: 16),
        const Text('如释是一款为膀胱害羞症(Paruresis)患者设计的辅助工具。'),
      ],
    );
  }
}
