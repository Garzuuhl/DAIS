#include "mqttconnection.hpp"
#include <QDebug>

MqttConnection::MqttConnection(QObject *parent)
    : QMqttClient(parent)
{}

MqttSubscription* MqttConnection::subscribe(const QString &topic)
{
    auto subscription = QMqttClient::subscribe(topic, 0);
    auto result = new MqttSubscription(subscription, this);
    return result;
}

MqttSubscription::MqttSubscription(QMqttSubscription *s, MqttConnection *c)
    : subscription(s),
      connection(c)
{
    connect(subscription, &QMqttSubscription::messageReceived, this, &MqttSubscription::handleMessage);
    m_topic = subscription->topic();
}
