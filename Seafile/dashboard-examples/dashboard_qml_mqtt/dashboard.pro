TEMPLATE = app
TARGET = dashboard
INCLUDEPATH += .
QT += quick mqtt
CONFIG += c++1z

SOURCES += \
    main.cpp \
    qmlmqttclient.cpp

RESOURCES += \
    dashboard.qrc

QMAKE_LFLAGS += -static-libgcc -static-libstdc++ -static

OTHER_FILES += \
    qml/dashboard.qml \
    qml/DashboardGaugeStyle.qml \
    qml/IconGaugeStyle.qml \
    qml/TachometerStyle.qml \
    qml/TurnIndicator.qml \
    qml/ValueSource.qml

target.path = $$[QT_INSTALL_EXAMPLES]/quickcontrols/extras/dashboard
INSTALLS += target

HEADERS += \
    qmlmqttclient.hpp

DISTFILES +=


