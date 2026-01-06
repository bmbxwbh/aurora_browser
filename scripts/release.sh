#!/bin/bash

# Aurora Browser 发布脚本

set -e

echo "🚀 开始发布 Aurora Browser..."

if [ -z "$1" ]; then
    echo "用法: ./release.sh [version]"
    echo "例如: ./release.sh 1.0.0"
    exit 1
fi

VERSION=$1

echo "📝 创建标签 v$VERSION..."
git tag -a v$VERSION -m "Release v$VERSION"

echo "📤 推送标签..."
git push origin v$VERSION

echo "📦 创建 GitHub Release..."
gh release create v$VERSION \
    --title "Aurora Browser v$VERSION" \
    --notes "自动发布的版本 $VERSION" \
    --draft \
    --prerelease

echo "✅ 发布准备完成！"
echo "请前往 GitHub 查看并发布草稿"
