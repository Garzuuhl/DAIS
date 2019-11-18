#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtMqtt/QtMqtt>


#include "mqttconnection.hpp"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<MqttConnection>("MqttConnection", 1, 0, "MqttConnection");
    qmlRegisterUncreatableType<MqttSubscription>("MqttConnection", 1, 0, "MqttSubscription", QLatin1String("Subscriptions are read-only"));

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
