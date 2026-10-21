#include "stylehelper.h"

#include <QCoreApplication>
#include <QProcess>
#include <QQuickStyle>

StyleHelper::StyleHelper(QObject *parent)
    : QObject(parent)
{
}

QString StyleHelper::currentStyle() const
{
    // QQuickStyle::name() 就是控件实际渲染用的样式名，-style / 环境变量 / 平台默认
    // 这几级 Qt 已经解析完；别自己去 argv 里翻，QGuiApplication 构造时就把它取走了。
    return QQuickStyle::name();
}

QStringList StyleHelper::styles() const
{
    return {
        QStringLiteral("Basic"),
        QStringLiteral("Fusion"),
        QStringLiteral("Material"),
        QStringLiteral("Universal"),
        QStringLiteral("Imagine"),
        QStringLiteral("Windows"),
    };
}

void StyleHelper::restartWithStyle(const QString &style)
{
    if (style.isEmpty() || style == QQuickStyle::name())
        return;

    // 重启时带上 -style，新进程里由 Qt 自己取走并应用
    QProcess::startDetached(QCoreApplication::applicationFilePath(),
                            { QStringLiteral("-style"), style });
    QCoreApplication::quit();
}