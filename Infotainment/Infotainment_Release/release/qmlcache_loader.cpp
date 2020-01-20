#include <QtQml/qqmlprivate.h>
#include <QtCore/qdir.h>
#include <QtCore/qurl.h>

static const unsigned char qt_resource_tree[] = {
0,
0,0,0,0,2,0,0,0,8,0,0,0,1,0,0,1,
0,0,0,0,0,0,1,0,0,0,0,0,0,0,218,0,
0,0,0,0,1,0,0,0,0,0,0,0,120,0,0,0,
0,0,1,0,0,0,0,0,0,0,82,0,0,0,0,0,
1,0,0,0,0,0,0,0,8,0,0,0,0,0,1,0,
0,0,0,0,0,0,196,0,0,0,0,0,1,0,0,0,
0,0,0,0,158,0,0,0,0,0,1,0,0,0,0,0,
0,0,46,0,0,0,0,0,1,0,0,0,0};
static const unsigned char qt_resource_names[] = {
0,
1,0,0,0,47,0,47,0,16,5,119,26,220,0,80,0,
97,0,103,0,101,0,50,0,70,0,111,0,114,0,109,0,
46,0,117,0,105,0,46,0,113,0,109,0,108,0,15,15,
228,235,188,0,86,0,97,0,108,0,117,0,101,0,83,0,
111,0,117,0,114,0,99,0,101,0,46,0,113,0,109,0,
108,0,16,5,87,26,220,0,80,0,97,0,103,0,101,0,
51,0,70,0,111,0,114,0,109,0,46,0,117,0,105,0,
46,0,113,0,109,0,108,0,16,5,23,26,220,0,80,0,
97,0,103,0,101,0,49,0,70,0,111,0,114,0,109,0,
46,0,117,0,105,0,46,0,113,0,109,0,108,0,16,11,
58,38,124,0,65,0,100,0,100,0,114,0,101,0,115,0,
115,0,77,0,111,0,100,0,101,0,108,0,46,0,113,0,
109,0,108,0,8,8,1,90,92,0,109,0,97,0,105,0,
110,0,46,0,113,0,109,0,108,0,16,4,183,26,220,0,
80,0,97,0,103,0,101,0,52,0,70,0,111,0,114,0,
109,0,46,0,117,0,105,0,46,0,113,0,109,0,108,0,
16,4,151,26,220,0,80,0,97,0,103,0,101,0,53,0,
70,0,111,0,114,0,109,0,46,0,117,0,105,0,46,0,
113,0,109,0,108};
static const unsigned char qt_resource_empty_payout[] = { 0, 0, 0, 0, 0 };
QT_BEGIN_NAMESPACE
extern Q_CORE_EXPORT bool qRegisterResourceData(int, const unsigned char *, const unsigned char *, const unsigned char *);
QT_END_NAMESPACE
namespace QmlCacheGeneratedCode {
namespace _0x5f__Page5Form_ui_0x2e_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _0x5f__Page4Form_ui_0x2e_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _0x5f__main_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _0x5f__AddressModel_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _0x5f__Page1Form_ui_0x2e_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _0x5f__Page3Form_ui_0x2e_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _0x5f__ValueSource_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}
namespace _0x5f__Page2Form_ui_0x2e_qml { 
    extern const unsigned char qmlData[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), nullptr, nullptr
    };
}

}
namespace {
struct Registry {
    Registry();
    ~Registry();
    QHash<QString, const QQmlPrivate::CachedQmlUnit*> resourcePathToCachedUnit;
    static const QQmlPrivate::CachedQmlUnit *lookupCachedUnit(const QUrl &url);
};

Q_GLOBAL_STATIC(Registry, unitRegistry)


Registry::Registry() {
        resourcePathToCachedUnit.insert(QStringLiteral("/Page5Form.ui.qml"), &QmlCacheGeneratedCode::_0x5f__Page5Form_ui_0x2e_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/Page4Form.ui.qml"), &QmlCacheGeneratedCode::_0x5f__Page4Form_ui_0x2e_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/main.qml"), &QmlCacheGeneratedCode::_0x5f__main_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/AddressModel.qml"), &QmlCacheGeneratedCode::_0x5f__AddressModel_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/Page1Form.ui.qml"), &QmlCacheGeneratedCode::_0x5f__Page1Form_ui_0x2e_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/Page3Form.ui.qml"), &QmlCacheGeneratedCode::_0x5f__Page3Form_ui_0x2e_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/ValueSource.qml"), &QmlCacheGeneratedCode::_0x5f__ValueSource_qml::unit);
        resourcePathToCachedUnit.insert(QStringLiteral("/Page2Form.ui.qml"), &QmlCacheGeneratedCode::_0x5f__Page2Form_ui_0x2e_qml::unit);
    QQmlPrivate::RegisterQmlUnitCacheHook registration;
    registration.version = 0;
    registration.lookupCachedQmlUnit = &lookupCachedUnit;
    QQmlPrivate::qmlregister(QQmlPrivate::QmlUnitCacheHookRegistration, &registration);
QT_PREPEND_NAMESPACE(qRegisterResourceData)(/*version*/0x01, qt_resource_tree, qt_resource_names, qt_resource_empty_payout);
}

Registry::~Registry() {
    QQmlPrivate::qmlunregister(QQmlPrivate::QmlUnitCacheHookRegistration, quintptr(&lookupCachedUnit));
}

const QQmlPrivate::CachedQmlUnit *Registry::lookupCachedUnit(const QUrl &url) {
    if (url.scheme() != QLatin1String("qrc"))
        return nullptr;
    QString resourcePath = QDir::cleanPath(url.path());
    if (resourcePath.isEmpty())
        return nullptr;
    if (!resourcePath.startsWith(QLatin1Char('/')))
        resourcePath.prepend(QLatin1Char('/'));
    return unitRegistry()->resourcePathToCachedUnit.value(resourcePath, nullptr);
}
}
int QT_MANGLE_NAMESPACE(qInitResources_qml)() {
    ::unitRegistry();
    Q_INIT_RESOURCE(qml_qmlcache);
    return 1;
}
Q_CONSTRUCTOR_FUNCTION(QT_MANGLE_NAMESPACE(qInitResources_qml))
int QT_MANGLE_NAMESPACE(qCleanupResources_qml)() {
    Q_CLEANUP_RESOURCE(qml_qmlcache);
    return 1;
}
