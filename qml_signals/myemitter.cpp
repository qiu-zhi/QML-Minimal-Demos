#include "myemitter.h"
#include <QDebug>
#include <QDateTime>

MyEmitter::MyEmitter(QObject* parent) : QObject(parent)
{
    m_timer = new QTimer(this);
    connect(m_timer, &QTimer::timeout, this, &MyEmitter::sendDemoSignals);
}

void MyEmitter::cppSendMsg(const QString &msg)
{
    emit cppSignal(msg);
    qDebug() << "发送C++信号:" << msg;
}

void MyEmitter::qmlSendMessage(const QString &msg)
{
    QString response = QString("[%1] C++收到QML消息: %2").arg(
        QDateTime::currentDateTime().toString("hh:mm:ss.zzz"), msg);
    emit cppResponse(response);
}

void MyEmitter::startDemoSignals()
{
    m_timer->start(2000);
    qDebug() << "信号定时器已启动";
}

void MyEmitter::stopDemoSignals()
{
    m_timer->stop();
    qDebug() << "信号定时器已停止";
}

void MyEmitter::sendDemoSignals()
{
    static int counter = 0;
    counter++;

    emit statusChanged(QString("[C++] 发送JSON数据[%1]").arg(counter));
    QVariantMap data;
    data["timestamp"] = QDateTime::currentDateTime().toString("hh:mm:ss.zzz");
    data["counter"] = counter;
    data["status"] = "active";
    emit dataReceived(data);
}
