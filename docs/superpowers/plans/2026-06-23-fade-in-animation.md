# FadeInAnimation 入场动画 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create a reusable FadeInAnimation component and apply it to all 16 Demo components for page entrance animation.

**Architecture:** A single `FadeInAnimation.qml` component wraps child content with a fade-in effect. Each Demo's root `Item` is replaced by `FadeInAnimation`, keeping inner layout unchanged.

**Tech Stack:** Qt 6 / QML (QtQuick)

---

### Task 1: Create FadeInAnimation.qml

**Files:**
- Create: `qml_text/FadeInAnimation.qml`

- [ ] **Step 1: Create the FadeInAnimation component**

```qml
// qml_text/FadeInAnimation.qml
import QtQuick

Item {
    id: root

    property int fadeInDuration: 500
    property var fadeInEasingType: Easing.OutQuad

    opacity: 0

    Behavior on opacity {
        NumberAnimation {
            duration: root.fadeInDuration
            easing.type: root.fadeInEasingType
        }
    }

    Component.onCompleted: {
        root.opacity = 1
    }

    default property alias content: contentColumn.data

    Column {
        id: contentColumn
        anchors.fill: parent
    }
}
```

- [ ] **Step 2: Commit**

```bash
git add qml_text/FadeInAnimation.qml
git commit -m "feat: add FadeInAnimation component"
```

---

### Task 2: Apply FadeInAnimation to Demo_TextBasic

**Files:**
- Modify: `qml_text/Demo_TextBasic.qml`

- [ ] **Step 1: Replace root Item with FadeInAnimation**

Change the file from:
```qml
import QtQuick

Item {
    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15
        ...
    }
}
```

To:
```qml
import QtQuick

FadeInAnimation {
    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15
        ...
    }
}
```

Full file content after change:
```qml
import QtQuick

FadeInAnimation {
    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        TitleSeparator {
            title: "Text 基础用法"
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: 20
            spacing: 12

            Text {
                text: "普通文本 - Hello World!"
                font.pointSize: 12
            }

            Text {
                text: "带颜色文本"
                font.pointSize: 12
                color: "#E91E63"
            }

            Text {
                text: "粗体文本"
                font.pointSize: 12
                font.bold: true
            }

            Text {
                text: "斜体文本"
                font.pointSize: 12
                font.italic: true
            }

            Text {
                text: "下划线文本"
                font.pointSize: 12
                font.underline: true
            }

            Text {
                text: "删除线文本"
                font.pointSize: 12
                font.strikeout: true
            }
        }
    }
}
```

- [ ] **Step 2: Commit**

```bash
git add qml_text/Demo_TextBasic.qml
git commit -m "feat: apply FadeInAnimation to Demo_TextBasic"
```

---

### Task 3: Apply FadeInAnimation to all Text Demo components (10 files)

All files follow the same pattern: replace `Item {` with `FadeInAnimation {` and remove the `import QtQuick` line (it's already imported in FadeInAnimation).

- [ ] **Step 1: Demo_TextFont.qml**

Change:
```qml
import QtQuick

Item {
    Column {
```

To:
```qml
import QtQuick

FadeInAnimation {
    Column {
```

- [ ] **Step 2: Demo_TextStyle.qml**

Same pattern: replace `Item {` with `FadeInAnimation {`.

- [ ] **Step 3: Demo_TextAlignment.qml**

Same pattern.

- [ ] **Step 4: Demo_TextWrap.qml**

Same pattern.

- [ ] **Step 5: Demo_TextElide.qml**

Same pattern.

- [ ] **Step 6: Demo_TextRich.qml**

Same pattern.

- [ ] **Step 7: Demo_TextMarkdown.qml**

Same pattern.

- [ ] **Step 8: Demo_TextLink.qml**

Same pattern.

- [ ] **Step 9: Demo_TextFit.qml**

Same pattern.

- [ ] **Step 10: Demo_TextSelectable.qml**

Same pattern.

- [ ] **Step 11: Demo_TextClickable.qml**

Same pattern.

- [ ] **Step 12: Commit all Text Demo changes**

```bash
git add qml_text/Demo_TextFont.qml qml_text/Demo_TextStyle.qml \
  qml_text/Demo_TextAlignment.qml qml_text/Demo_TextWrap.qml \
  qml_text/Demo_TextElide.qml qml_text/Demo_TextRich.qml \
  qml_text/Demo_TextMarkdown.qml qml_text/Demo_TextLink.qml \
  qml_text/Demo_TextFit.qml qml_text/Demo_TextSelectable.qml \
  qml_text/Demo_TextClickable.qml
git commit -m "feat: apply FadeInAnimation to all Text Demo components"
```

---

### Task 4: Apply FadeInAnimation to Label Demo components (4 files)

These files also import `QtQuick.Controls` — keep that import.

- [ ] **Step 1: Demo_LabelBasic.qml**

Change:
```qml
import QtQuick
import QtQuick.Controls

Item {
    Column {
```

To:
```qml
import QtQuick
import QtQuick.Controls

FadeInAnimation {
    Column {
```

- [ ] **Step 2: Demo_LabelBackground.qml**

Same pattern.

- [ ] **Step 3: Demo_LabelPadding.qml**

Same pattern.

- [ ] **Step 4: Demo_TextVsLabel.qml**

Same pattern.

- [ ] **Step 5: Commit all Label Demo changes**

```bash
git add qml_text/Demo_LabelBasic.qml qml_text/Demo_LabelBackground.qml \
  qml_text/Demo_LabelPadding.qml qml_text/Demo_TextVsLabel.qml
git commit -m "feat: apply FadeInAnimation to all Label Demo components"
```

---

### Task 5: Verify the build

- [ ] **Step 1: Build and run**

```bash
cd D:/Projects/Github/QML-Minimal-Demos
cmake --build build/Desktop_Qt_6_11_1_MinGW_64_bit-Debug
```

- [ ] **Step 2: Run the application to verify animation works**

```bash
./build/Desktop_Qt_6_11_1_MinGW_64_bit-Debug/qml_text/qml_text.exe
```

Verify: Each page should fade in from transparent to opaque when selected from the navigation list.
