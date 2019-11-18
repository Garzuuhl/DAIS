#ifndef MQTTCONNECTION_H
#define MQTTCONNECTION_H

#include <QtCore/QMap>
#include <QtMqtt/QMqttClient>
#include <QtMqtt/QMqttSubscription>

class MqttConnection;

class MqttSubscription : public QObject
{
        Q_OBJECT
        Q_PROPERTY(QMqttTopicFilter topic MEMBER m_topic NOTIFY topicChanged)
    public:
        MqttSubscription(QMqttSubscription *s, MqttConnection *c);
        ~MqttSubscription();

    Q_SIGNALS:
        void topicChanged(QString);
        void messageReceived(const QString &msg);

    public slots:
        void handleMessage(const QMqttMessage &qmsg);

    private:
        Q_DISABLE_COPY(MqttSubscription)
        QMqttSubscription *subscription;
        MqttConnection *connection;
        QMqttTopicFilter m_topic;
};

class MqttConnection : public QMqttClient {
        Q_OBJECT
    public:
        MqttConnection(QObject *parent = nullptr);

        Q_INVOKABLE MqttSubscription *subscribe(const QString &topic);
    private:
        Q_DISABLE_COPY(MqttConnection)
};

#endif // MQTTCONNECTION_H
