[中文](README.md) | [English](README.en-US.md)

![QML-Minimal-Demos Banner](asserts/doc-images/banner_cn.png)

# QML-Minimal-Demos

一个持续增长的可运行 QML (Qt Quick) 示例集合，涵盖组件、动画、布局、图表和粒子系统。每个示例都力求简洁、经过验证，可在 Qt 6.5+ 上直接运行。边学边做，持续扩展。

---

## 为什么做这个集合

Qt 官方的 QML 文档相对稀疏，初学者容易感到迷茫。

从 2025 年开始，我利用业余时间用 DeepSeek 生成 demo 代码，然后手动调试和修复问题——在修 bug 的过程中学习 QML。最初的 demo 发布在 CSDN 上，后来我逐步迭代优化，收录到这个集合中。

## 环境要求

- 最低 Qt 版本：6.5
- 当前开发环境：Win11 + Qt 6.8.2 / Qt 6.11.1
- 注意：Qt 6 程序无法在 Win7 上运行；Qt 6.12 之后的版本将不再支持 Win10

## 适用人群

### 1. 对 QML 感兴趣的开发者

本集合涵盖了最常用的 QML 组件和模式——从基础 Hello World 到粒子系统、图表和表格。每个示例都是独立可运行的最小案例，比阅读官方文档更直观。

### 2. 用 AI 生成 QML 代码但遇到错误的人

AI 生成的 QML 代码常出现两类问题：
- 使用不存在的属性或信号
- 组件嵌套关系错误

本集合中的每个示例都经过实际编译验证，可以作为"正确参考"。当 AI 生成的代码不工作时，找一个类似的示例对比差异即可。

### 3. QML 初学者

每个示例代码量小（通常 50-200 行），专注于演示单一知识点。没有复杂项目结构干扰——非常适合从 qml_hello 开始，按类别逐步进阶。

## 如何运行示例

1. 下载或克隆仓库到本地
2. 使用 Qt Creator 打开目标示例的 `CMakeLists.txt` 文件
3. 点击运行即可看到效果

---

## qml_hello

一个最小化 QML 示例，演示文字渲染配合两种基础动画：颜色过渡和弹跳效果。"Hello World" 文字从窗口顶部动画移动到中心，同时从白色渐变为深灰色。

![QML Hello Demo](asserts/doc-images/qml-hello.gif)

---

## 基础控件篇

### qml_layout

演示 Qt Quick 中的五种基础布局。包含 Row（水平布局）、Column（垂直布局）、Grid（网格布局）、Stack（堆叠布局）和 Flow（流式布局）示例，展示不同布局管理器的排列规则与适用场景。

![QML Layout Demo](asserts/doc-images/qml-layout.gif)

---

### qml_text

演示 Qt Quick 中的 Text 和 Label 组件。包含基础文本属性、字体设置、文本样式、对齐、换行、省略、富文本(HTML)、Markdown、链接交互、字体自适应和可点击文本等示例。

![QML Text Demo](asserts/doc-images/qml-text.gif)

---

### qml_container

演示 Qt Quick 中的容器组件。包含 Pane、Frame、GroupBox、自定义 GroupBox、ScrollView 和嵌套组合示例，展示基础容器的用法和复杂界面的布局嵌套。

![QML Container Demo](asserts/doc-images/qml-container.gif)

---

### qml_button

演示 Qt Quick 中常用按钮和选择控件。包含 Button、RoundButton、DelayButton、Switch、CheckBox、RadioButton、ToolButton、TabButton、ItemDelegate 以及自定义按钮组件示例。

![QML Button Demo](asserts/doc-images/qml-button.gif)

---

### qml_slider

演示 Qt Quick 中 `Slider` 与 `RangeSlider` 滑块控件的用法。包含基础滑块、自定义手柄/轨道/刻度、RangeSlider 范围选择，以及音量控制和视频进度条等场景化示例。

![QML Slider Demo](asserts/doc-images/qml-slider.gif)

---

### qml_dial

演示 Qt Quick 中 `Dial` 旋钮控件的用法。包含基础旋钮、数值显示、自定义样式、鼠标/滚轮/键盘事件、多 Dial 联动、刻度绘制以及音频均衡器等示例。

![QML Dial Demo](asserts/doc-images/qml-dial.gif)

---

### qml_spinbox

演示 Qt Quick 中 `SpinBox` 数字输入框的用法。包含基础 SpinBox、自定义步长、Basic 与 Material 自定义样式，以及缩放动画和数字滚动列表等示例。

![QML SpinBox Demo](asserts/doc-images/qml-spinbox.gif)

---

### qml_progressbar

演示 Qt Quick 中 `ProgressBar` 进度条的用法。包含默认样式、平滑动画、矩形自定义、Material 风格、条纹不确定动画，以及环形和多环进度等示例。

![QML ProgressBar Demo](asserts/doc-images/qml-progressbar.gif)

---

## 交互基础篇

### qml_signals

演示 Qt Quick 中的信号与槽机制。包含直接绑定、跨文件通信、JS 动态连接以及 C++ 到 QML 的信号互操作示例。

![QML Signals Demo](asserts/doc-images/qml-signals.gif)

---

### qml_timer

演示 Qt Quick 中 Timer 组件的基础用法。包含单次触发、重复触发、启动立即触发以及用 Timer 控制动画等示例。

![QML Timer Demo](asserts/doc-images/qml-timer.gif)

---

### qml_js_interaction

演示 Qt Quick 中 QML 与 JavaScript 的交互方式。包含内联 JS 函数、导入外部 JS 文件、JS 函数作为信号槽以及 WorkerScript 工作线程示例。

![QML JS Interaction Demo](asserts/doc-images/qml-js-interaction.gif)

---

## 动画效果篇

### qml_busyindicator

演示 Qt Quick 中 BusyIndicator 加载指示器的用法。包含基础用法、原生实现自定义配色、矩形缺口环和 Shape 圆弧动画等示例。

![QML BusyIndicator Demo](asserts/doc-images/qml-busyindicator.gif)

---

### qml_tumbler

演示 Qt Quick 中 `Tumbler` 滚轮选择器的用法。包含基础时间选择、颜色选择器、透明度渐变、高亮背景、3D 旋转、年月日选择、日期联动选择和水平滚动等示例。

![QML Tumbler Demo](asserts/doc-images/qml-tumbler.gif)

---

## 弹窗对话篇

### qml_windowflags

演示 Qt Quick 中各种窗口标志位和弹出组件。包含 Popup、Dialog 和自定义弹窗，以及 Tool、ToolTip、SplashScreen、Frameless、StayOnTop、Dialog 等窗口标志位示例。

![QML Window Flags Demo](asserts/doc-images/qml-windowflags.gif)

---

### qml_tooltip

演示 Qt Quick 中 ToolTip 组件的用法。包含基础悬停提示、自定义样式、富文本提示与阴影效果等示例。

![QML ToolTip Demo](asserts/doc-images/qml-tooltip.gif)

---

## qml_textarea

演示 Qt Quick 中的 TextArea 多行文本编辑组件。包含基础文本编辑、字体与颜色、富文本、换行模式等基础示例，自定义样式、暗色主题、Material 风格等样式示例，以及文本搜索、带行号的文本编辑器、Markdown 编辑器、保持滚动、加载大文本等应用示例。

![QML TextArea Demo](asserts/doc-images/qml-textarea.gif)

---

## qml_textfield

演示 Qt Quick 中的 TextField 单行输入组件。包含基础输入与输入限制等基础示例，年龄、邮箱、手机号、掩码与日期、IP 地址、身份证等多种校验规则，自定义文本框、带图标、带删除按钮、主题切换等样式示例，以及自动关联、表单提交等应用示例。

![QML TextField Demo](asserts/doc-images/qml-textfield.gif)

---

**持续更新中...**
