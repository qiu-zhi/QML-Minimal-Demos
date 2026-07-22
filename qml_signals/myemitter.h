#ifndef MYEMITTER_H
#define MYEMITTER_H

#include <QObject>
#include <QTimer>
#include <QVariantMap>

class MyEmitter : public QObject
{
    Q_OBJECT
public:
    explicit MyEmitter(QObject* parent = nullptr);

    Q_INVOKABLE void cppSendMsg(const QString &msg);
    Q_INVOKABLE void qmlSendMessage(const QString &msg);
    Q_INVOKABLE void startDemoSignals();
    Q_INVOKABLE void stopDemoSignals();

signals:
    void cppSignal(const QString &msg);
    void cppResponse(const QString &response);
    void statusChanged(const QString &status);
    void dataReceived(const QVariantMap &data);

private slots:
    void sendDemoSignals();

private:
    QTimer *m_timer;
};

#endif // MYEMITTER_H
