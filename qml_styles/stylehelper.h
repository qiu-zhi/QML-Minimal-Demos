#ifndef STYLEHELPER_H
#define STYLEHELPER_H

#include <QObject>
#include <QStringList>
#include <QtQmlIntegration/qqmlintegration.h>

// C++ 单例：把当前生效的样式、可选样式列表和"重启换样式"的能力交给 QML
class StyleHelper : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

    Q_PROPERTY(QString currentStyle READ currentStyle CONSTANT)
    Q_PROPERTY(QStringList styles READ styles CONSTANT)

public:
    explicit StyleHelper(QObject *parent = nullptr);

    QString currentStyle() const;
    QStringList styles() const;

    // 样式只能在引擎加载前确定，所以切换样式用重启进程的方式实现
    Q_INVOKABLE void restartWithStyle(const QString &style);
};

#endif // STYLEHELPER_H