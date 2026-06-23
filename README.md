# QML-Minimal-Demos
A growing collection of runnable QML (Qt Quick) demos covering components, animations, layouts, charts, and particle   systems. Each example is minimal, verified, and ready to run with Qt 6.5+. Learning by doing, continuously expanding.

---

## Why This Collection

Qt's official QML documentation is relatively sparse, making it easy for beginners to feel lost.

Since 2025, I've been using my spare time to generate demo code with DeepSeek, then manually debug and fix issues — learning QML through the process of fixing bugs. The original demos were created on CSDN, and now I've iterated and optimized all of them into this collection.

## Environment Requirements

- Minimum Qt version: 6.5
- Current development environment: Win11 + Qt 6.8.2 / Qt 6.11.1 / upcoming Qt 6.12
- Note: Qt 6 programs cannot run on Win7; versions after Qt 6.12 will drop Win10 support

## Who Is This For

### 1. Developers Interested in QML

This collection covers most commonly used QML components and patterns — from basic Hello World to particle systems, charts, and tables. Each example is a standalone, runnable minimal case. It's much more intuitive than reading official Qt documentation.

### 2. People Who Use AI to Generate QML Code But Encounter Errors

AI-generated QML code often has two types of issues:
- Using non-existent properties or signals
- Incorrect component nesting relationships

Every example in this collection has been verified through actual compilation and can serve as a "correct reference." When AI-generated code doesn't work, find a similar example here to see where the difference lies.

### 3. QML Beginners

Each example has a small codebase (usually 50-200 lines), focusing on demonstrating a single knowledge point. No complex project structure interference — perfect for starting with qml_hello and progressing gradually by category.

## How to Run Examples

1. Download or clone the repository to your local machine
2. Open the target example's `CMakeLists.txt` file using Qt Creator
3. Click run to see the effect

---

## qml_hello

A minimal QML example demonstrating text rendering with two basic animations: color transition and bounce effect. The "Hello World" text animates from the top of the window to the center while fading from white to dark gray.

![QML Hello Demo](images/qml_hello.gif)

---

**To be continued...**
