#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include "httputils.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    app.setWindowIcon(QIcon(":/images/music"));

    qmlRegisterType<HttpUtils>("MyUtils", 1, 0, "HttpUtils");

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/Qtmusic_video/App.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
