#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QObject>
#include <QFile>
#include <QRegularExpression>
#include <QStringList>
#include <QVariantMap>

// 通用文本加载器：读取 UTF-8 文本文件，按行拆成阅读块（换行即分段）
// QML 中通过 context property textLoader 调用：
//   var data = textLoader.load("qrc:/qt/qml/qml_textarea/白话史记.txt")
//   data.blocks     -> 分块后的字符串数组（每行一块）
//   data.totalChars -> 文本总字符数
//   data.error      -> 加载失败时的错误信息（可选）
class TextLoader : public QObject
{
    Q_OBJECT

public:
    Q_INVOKABLE QVariantMap load(const QString &path) const
    {
        QVariantMap result;

        // Windows 上 QFile 不识别 "qrc:" 前缀（会当作非法本地路径），
        // 统一规范化为 ":/"；QML 里传 "qrc:/..." 或 ":/..." 均可
        QString filePath = path;
        if (filePath.startsWith(QLatin1String("qrc:")))
            filePath = filePath.mid(3); // "qrc:/..." -> ":/..."

        QFile file(filePath);
        if (!file.open(QIODevice::ReadOnly)) {
            result.insert(QStringLiteral("error"),
                          QStringLiteral("无法打开文件: ") + path);
            return result;
        }

        const QString text = QString::fromUtf8(file.readAll());

        // 按行切分：MultilineOption 让 ^ 匹配行首、$ 匹配行尾，
        // 一次匹配一整行，换行即分段；每行一个块，保证句子完整不被截断；
        // 空行跳过
        QStringList blocks;
        const QRegularExpression sentenceRe(QStringLiteral(u"^.*$"),
                                            QRegularExpression::MultilineOption);
        QRegularExpressionMatchIterator it = sentenceRe.globalMatch(text);
        while (it.hasNext()) {
            QString line = it.next().captured();
            line.remove(QLatin1Char('\r')); // CRLF 文件去掉行尾 \r，避免残留
            if (line.isEmpty())
                continue;
            blocks.append(line);
        }

        result.insert(QStringLiteral("blocks"), blocks);
        result.insert(QStringLiteral("totalChars"), text.size());
        return result;
    }
};

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    TextLoader loader;
    engine.rootContext()->setContextProperty(QStringLiteral("textLoader"), &loader);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("qml_textarea", "Main");

    return app.exec();
}

#include "main.moc"
