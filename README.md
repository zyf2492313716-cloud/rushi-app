# 如释 (Rushi App)

一款帮助膀胱害羞症（Paruresis / Shy Bladder）患者的跨平台辅助工具，支持 Android、iOS 和 macOS。

> **"如释"** — 取自"如释重负"，寓意帮助用户在如厕时放松身心，摆脱焦虑。

## 项目背景

膀胱害羞症（Paruresis）是一种常见的社交焦虑障碍，患者在公共厕所或他人附近时难以排尿。目前 iOS 平台有较为完善的辅助应用（如 UriBrave），但 Android 平台缺乏高质量的中文辅助工具。

本项目旨在为中文用户提供一个专业、易用的膀胱害羞症辅助工具。

## 功能特性

| 功能模块 | 说明 |
|---------|------|
| **声音辅助** | 提供多种环境白噪音（水流声、雨声、咖啡厅等），帮助放松并掩盖如厕声音 |
| **应急模式** | 全屏呼吸动画引导 + 2分钟倒计时，帮助用户在紧张时快速平复 |
| **厕所地图** | 标记并记录不同厕所的安心程度，帮助找到最适合的如厕环境 |
| **GET 暴露训练** | 基于渐进式暴露疗法的系统化训练方案，从易到难逐步克服焦虑 |
| **深色模式** | 支持浅色/深色主题切换，护眼省电 |

## 技术栈

| 技术 | 用途 | 支持平台 |
|------|------|---------|
| **Flutter** | 跨平台 UI 框架 | Android / iOS / macOS |
| **Provider** | 状态管理 | 全平台 |
| **audioplayers** | 音频播放 | 全平台 |
| **geolocator** | GPS 定位 | 全平台 |
| **shared_preferences** | 本地数据存储 | 全平台 |
| **permission_handler** | 权限管理 | 全平台 |

## 下载与安装

### 方式一：自行编译（推荐开发者）

```bash
# 1. 克隆项目
git clone https://github.com/zyf2492313716-cloud/rushi-app.git
cd rushi-app

# 2. 安装依赖
flutter pub get

# 3. 连接 Android 设备（开启 USB 调试），运行
flutter run
```

### 方式二：直接下载（推荐用户）

**最新版本**: [v1.2.0](https://github.com/zyf2492313716-cloud/rushi-app/releases/tag/v1.2.0)

| 平台 | 下载链接 | 大小 | 日期 |
|------|---------|------|------|
| Android (APK) | [rushi-app-v1.2.0.apk](https://github.com/zyf2492313716-cloud/rushi-app/releases/download/v1.2.0/app-release.apk) | 52MB | 2026-06-02 |
| iOS (需自编译) | 源码编译 | - | 2026-06-02 |
| macOS (需自编译) | 源码编译 | - | 2026-06-02 |

**Android 安装步骤**:
1. 下载 APK 文件到手机
2. 开启「允许安装未知来源应用」（设置 → 安全 → 未知来源）
3. 点击 APK 文件安装

**iOS/macOS 安装步骤**:
1. 在 Mac 上安装 [Xcode](https://developer.apple.com/xcode/)（约 15GB）
2. 克隆项目并进入目录
3. 运行 `flutter build ios --release`（iOS）或 `flutter build macos --release`（macOS）
4. iOS 需要 Apple Developer 账号签名后才能安装到真机
5. macOS 编译后可直接在 `build/macos/Build/Products/Release/` 找到 `.app` 文件

## 开发环境要求

| 工具 | 版本要求 | 必需平台 |
|------|---------|---------|
| Flutter SDK | >= 3.0.0 | 全平台 |
| Dart SDK | >= 3.0.0 | 全平台 |
| Android SDK | >= API 35 | Android |
| Android Studio | 最新稳定版 | Android |
| JDK | >= 17 | Android |
| Xcode | >= 15.0 | iOS / macOS |
| CocoaPods | 最新版 | iOS / macOS |

### iOS / macOS 额外配置

项目已配置好所有必要的权限声明（位置、麦克风等），编译时 CocoaPods 会自动安装依赖。只需确保：

1. macOS 上已安装 Xcode 和 Command Line Tools
2. 运行 `sudo gem install cocoapods` 安装 CocoaPods
3. 首次编译时 CocoaPods 会自动下载 iOS 依赖

## 项目结构

```
lib/
├── core/
│   ├── constants/      # 颜色、字符串、尺寸常量
│   ├── models/         # 数据模型（声音、暴露等级、厕所标记）
│   ├── utils/          # 工具类（音频管理器）
│   └── widgets/        # 通用组件（呼吸动画、功能卡片、安全评分）
├── features/
│   ├── home/           # 首页
│   ├── sound/          # 声音辅助
│   ├── crisis/         # 应急模式
│   ├── map/            # 厕所地图
│   ├── exposure/       # GET 暴露训练
│   └── settings/       # 设置页
├── main.dart           # 应用入口
├── app.dart            # MaterialApp 配置
├── router.dart         # 路由管理
└── theme.dart          # 主题配置
```

## 更新日志

### v1.2.0 (2026-06-02)
- 引入 Provider 状态管理，统一数据流
- 深色模式开关正式生效（设置可记忆）
- 暴露训练进度持久化（SharedPreferences，重启不丢失）
- 厕所数据持久化（JSON 序列化）
- 清除训练记录带确认对话框
- 修复之前版本的所有已知 Bug

### v1.1.0 (2026-06-02)
- 新增声音辅助模块（7种白噪音/自然音效）
- 新增音频循环播放与定时关闭
- 新增 iOS/macOS 平台支持
- 修复暴露训练进度无法推进的严重 Bug
- 修复练习结果页失败/成功 UI 不区分的 Bug
- 修复地图添加厕所对话框不生效的 Bug
- 修复声音切换时的异步竞争问题
- 更新设置页版本号同步

### v1.0.0 (2026-06-01)
- 初始发布：应急模式、厕所地图、GET 暴露训练
- 深色模式支持

## 界面预览

（截图将在后续版本补充）

## 参与贡献

欢迎提交 Issue 和 Pull Request！

### 待办事项

- [ ] GET 训练进度持久化（SQLite / SharedPreferences）
- [ ] 地图功能完善（高德地图 / Apple MapKit 集成）
- [ ] 暴露训练数据统计与进度图表
- [ ] 添加更多白噪音类型
- [ ] 添加 Provider 状态管理统一数据流
- [ ] 多语言支持（英文/日文）
- [ ] App Store / Google Play 上架
- [ ] 用户反馈与社区功能

## 免责声明

本应用仅供参考和辅助使用，不能替代专业医疗建议。如有严重症状，请咨询专业医生或心理治疗师。

## 开源协议

[MIT License](LICENSE)

## 致谢

- UI 设计灵感：[Pause by ustwo](https://www.ustwo.com/work/pause)
- 参考应用：UriBrave (iOS)、Shy Bladder App (Android)

---

**开发者**：周宇峰  
**联系方式**：如有问题请在 GitHub Issues 中留言
