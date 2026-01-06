#!/bin/bash

# Aurora Browser 构建脚本

set -e

echo "🚀 开始构建 Aurora Browser..."

if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter 未安装"
    exit 1
fi

if [ -z "$1" ]; then
    echo "用法: ./build.sh [android|ios|web|all]"
    exit 1
fi

PLATFORM=$1

echo "📦 安装依赖..."
flutter pub get

echo "🧪 运行测试..."
flutter test

case $PLATFORM in
    android)
        echo "📱 构建 Android APK..."
        flutter build apk --release
        echo "✅ Android 构建完成: build/app/outputs/flutter-apk/app-release.apk"
        ;;
    ios)
        echo "🍎 构建 iOS..."
        flutter build ios --release --no-codesign
        echo "✅ iOS 构建完成: build/ios/iphoneos/Runner.ipa"
        ;;
    web)
        echo "🌐 构建 Web..."
        flutter build web --release
        echo "✅ Web 构建完成: build/web/"
        ;;
    all)
        echo "📱 构建 Android..."
        flutter build apk --release
        
        echo "🍎 构建 iOS..."
        flutter build ios --release --no-codesign
        
        echo "🌐 构建 Web..."
        flutter build web --release
        
        echo "✅ 所有平台构建完成！"
        ;;
    *)
        echo "❌ 未知平台: $PLATFORM"
        echo "支持: android, ios, web, all"
        exit 1
        ;;
esac
