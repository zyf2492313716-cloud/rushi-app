# 如释 (Rushi App)

一款帮助膀胱害羞症（Paruresis / Shy Bladder）患者的 Android 辅助工具。

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

- **Flutter** — 跨平台 UI 框架
- **Provider** — 状态管理
- **高德地图 SDK** — 地图与定位服务
- **audioplayers** — 音频播放
- **shared_preferences** — 本地数据存储

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

### 方式二：直接下载 APK（推荐用户）

**最新版本**: [v1.0.0](https://github.com/zyf2492313716-cloud/rushi-app/releases/tag/v1.0.0)

| 版本 | 下载链接 | 大小 | 日期 |
|------|---------|------|------|
| v1.0.0 | [rushi-app-v1.0.0.apk](https://github.com/zyf2492313716-cloud/rushi-app/releases/download/v1.0.0/rushi-app-v1.0.0.apk) | 48MB | 2026-06-02 |

**安装步骤**:
1. 下载 APK 文件到手机
2. 开启「允许安装未知来源应用」（设置 → 安全 → 未知来源）
3. 点击 APK 文件安装

## 开发环境要求

| 工具 | 版本要求 |
|------|---------|
| Flutter SDK | >= 3.0.0 |
| Dart SDK | >= 3.0.0 |
| Android SDK | >= API 35 |
| Android Studio | 最新稳定版 |
| JDK | >= 17 |

### 高德地图 API Key 配置

本项目使用高德地图 SDK，需要配置 API Key：

1. 访问 [高德开放平台](https://lbs.amap.com/) 注册账号
2. 创建应用，获取 Android SDK Key
3. 在 `android/app/src/main/AndroidManifest.xml` 中添加：

```xml
<meta-data
    android:name="com.amap.api.v2.apikey"
    android:value="你的高德Key" />
```

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

## 界面预览

（截图将在后续版本补充）

## 参与贡献

欢迎提交 Issue 和 Pull Request！

### 待办事项

- [ ] 添加数据统计与进度图表
- [ ] 完善地图功能（实时定位、导航）
- [ ] 添加更多白噪音类型
- [ ] GET 训练数据持久化
- [ ] 多语言支持
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
