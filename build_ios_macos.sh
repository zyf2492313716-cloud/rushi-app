#!/bin/bash
set -e

echo "========================================"
echo "如释 (Rushi App) iOS/macOS 构建脚本"
echo "========================================"
echo ""

# 检查 Flutter
if ! command -v flutter &> /dev/null; then
    echo "错误: 未找到 Flutter，请先安装 Flutter SDK"
    echo "访问: https://docs.flutter.dev/get-started/install"
    exit 1
fi

echo "Flutter 版本: $(flutter --version | head -1)"
echo ""

# 检查 Xcode
if ! command -v xcodebuild &> /dev/null; then
    echo "错误: 未找到 Xcode，请从 App Store 安装 Xcode"
    exit 1
fi

echo "Xcode 版本: $(xcodebuild -version | head -1)"
echo ""

# 检查 CocoaPods
if ! command -v pod &> /dev/null; then
    echo "正在安装 CocoaPods..."
    sudo gem install cocoapods
else
    echo "CocoaPods 已安装: $(pod --version)"
fi
echo ""

# 获取依赖
echo "正在获取 Flutter 依赖..."
flutter pub get
echo ""

# 构建 iOS
echo "========================================"
echo "正在构建 iOS Release..."
echo "========================================"
cd ios
pod install --repo-update
cd ..
flutter build ios --release --no-codesign

echo ""
echo "iOS 构建完成！"
echo "产物路径: build/ios/iphoneos/Runner.app"
echo "注意: 需要 Apple Developer 账号签名后才能安装到真机"
echo ""

# 构建 macOS
echo "========================================"
echo "正在构建 macOS Release..."
echo "========================================"
flutter build macos --release

echo ""
echo "macOS 构建完成！"
echo "产物路径: build/macos/Build/Products/Release/如释.app"
echo ""

# 打包
echo "========================================"
echo "正在打包..."
echo "========================================"
mkdir -p dist

# 压缩 iOS
cd build/ios/iphoneos
zip -r "../../../dist/rushi-app-ios-v1.0.0.zip" "Runner.app"
cd ../../..

# 压缩 macOS
cd "build/macos/Build/Products/Release"
zip -r "../../../../../../dist/rushi-app-macos-v1.0.0.zip" "如释.app"
cd ../../../../../..

echo ""
echo "========================================"
echo "构建完成！"
echo "========================================"
echo ""
echo "输出文件:"
ls -lh dist/
echo ""
echo "iOS 安装说明:"
echo "1. 需要 Apple Developer 账号 (免费)"
echo "2. 使用 Xcode 打开 ios/Runner.xcworkspace"
echo "3. 配置签名 (Signing & Capabilities)"
echo "4. 连接 iPhone，点击运行"
echo ""
echo "macOS 安装说明:"
echo "1. 打开 dist/rushi-app-macos-v1.0.0.zip"
echo "2. 将'如释.app'拖到'应用程序'文件夹"
echo "3. 首次运行可能需要在'系统设置→隐私与安全性'中允许"
echo ""
