# 入场动画组件设计文档

## 概述

创建一个通用的入场动画组件 `FadeInAnimation.qml`，用于为 QML Demo 组件提供淡入动画效果。

## 设计目标

1. **通用性**：可包装任意 QML 组件，无需修改原有代码
2. **简洁性**：符合 QML 属性动画哲学，代码简洁
3. **可配置**：支持自定义动画参数
4. **性能**：使用轻量级的 Behavior 动画

## 组件设计

### 文件位置
`qml_text/FadeInAnimation.qml`

### 核心属性

| 属性名 | 类型 | 默认值 | 说明 |
|--------|------|--------|------|
| fadeInDuration | int | 500 | 动画持续时间（毫秒） |
| fadeInEasingType | easing | Easing.OutQuad | 缓动类型 |

### 核心实现

```qml
import QtQuick

Item {
    id: root

    // 可配置属性
    property int fadeInDuration: 500
    property var fadeInEasingType: Easing.OutQuad

    // 初始透明度为 0
    opacity: 0

    // 透明度变化动画
    Behavior on opacity {
        NumberAnimation {
            duration: root.fadeInDuration
            easing.type: root.fadeInEasingType
        }
    }

    // 组件加载完成后触发淡入
    Component.onCompleted: {
        root.opacity = 1
    }

    // 用于包装子组件的容器
    default property alias content: contentContainer.data
    Item {
        id: contentContainer
        anchors.fill: parent
    }
}
```

### 使用方式

#### 基本用法

```qml
FadeInAnimation {
    anchors.fill: parent

    Column {
        anchors.fill: parent
        // ... 原有内容
    }
}
```

#### 自定义动画参数

```qml
FadeInAnimation {
    anchors.fill: parent
    fadeInDuration: 800
    fadeInEasingType: Easing.OutCubic

    // ... 子组件
}
```

## 应用范围

### 第一阶段：Demo_TextBasic
- 将 `Demo_TextBasic.qml` 的最外层 `Item` 替换为 `FadeInAnimation`
- 验证动画效果正常

### 第二阶段：推广所有 Demo
以下组件需要应用入场动画：
1. Demo_TextBasic
2. Demo_TextFont
3. Demo_TextStyle
4. Demo_TextAlignment
5. Demo_TextWrap
6. Demo_TextElide
7. Demo_TextRich
8. Demo_TextMarkdown
9. Demo_TextLink
10. Demo_TextFit
11. Demo_TextSelectable
12. Demo_TextClickable
13. Demo_LabelBasic
14. Demo_LabelBackground
15. Demo_LabelPadding
16. Demo_TextVsLabel

### 应用方式

将每个 Demo 组件的最外层 `Item` 替换为 `FadeInAnimation`：

**修改前：**
```qml
Item {
    Column {
        // ... 内容
    }
}
```

**修改后：**
```qml
FadeInAnimation {
    Column {
        // ... 内容
    }
}
```

## 技术细节

### 动画原理
- 使用 QML 的 `Behavior` 属性动画
- `opacity` 初始值为 0
- `Component.onCompleted` 触发时设置 `opacity = 1`
- `Behavior` 自动执行从 0 到 1 的平滑过渡

### 缓动类型说明
- `Easing.OutQuad`：减速运动，开始快结束慢（推荐）
- `Easing.OutCubic`：更平滑的减速
- `Easing.OutBack`：带回弹效果

### 性能考虑
- Behavior 动画比 SequentialAnimation 更轻量
- 不会创建额外的动画对象
- 符合 QML 的属性绑定哲学

## 测试计划

1. **功能测试**
   - 验证 Demo_TextBasic 入场动画正常
   - 验证所有 Demo 组件入场动画正常
   - 验证动画参数可自定义

2. **性能测试**
   - 验证动画不影响渲染性能
   - 验证多个动画同时播放时的性能

3. **兼容性测试**
   - 验证在不同 Qt 版本下正常工作
   - 验证在不同平台下正常工作

## 后续扩展

1. **支持其他动画类型**
   - 滑入动画
   - 缩放动画
   - 旋转动画

2. **支持动画队列**
   - 多个组件按顺序播放动画
   - 支持延迟播放

3. **支持动画重复**
   - 循环播放动画
   - 支持无限循环
