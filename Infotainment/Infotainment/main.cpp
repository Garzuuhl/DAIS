#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtGui/QFont>
#include <QtGui/QFontDatabase>
#include <QtMqtt/QtMqtt>


#include "qmlmqttclient.hpp"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    QFontDatabase::addApplicationFont(":/fonts/Roboto-Regular.ttf");
    app.setFont(QFont("Roboto Regular"));

    qmlRegisterType<QmlMqttClient>("MqttClient", 1, 0, "MqttClient");
    qmlRegisterUncreatableType<QmlMqttSubscription>("MqttClient", 1, 0, "MqttSubscription", QLatin1String("Subscriptions are read-only"));

    engine.load(QUrl("qrc:/qml/infotainment.qml"));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
