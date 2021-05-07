
QT += qml quick

CONFIG += c++11
CONFIG += qmltypes

QML_IMPORT_NAME = custom.managers
QML_IMPORT_MAJOR_VERSION = 1

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        QmlElements/dictionarymanager.cpp \
        QmlElements/profilemanager.cpp \
        QmlElements/sessionmanager.cpp \
        QmlElements/wordmodel.cpp \
        dictionary.cpp \
        main.cpp \
        profile.cpp \
        word.cpp

RESOURCES += \
    QmlElements/res.qrc

TRANSLATIONS += \ts\
    QCards-QML_en_US.ts

INCLUDEPATH = QmlElements/

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    profiles/Profile1.config \
    profiles/Profile2.config \
    ts/QCards-QML_en_US.ts

HEADERS += \
    QmlElements/dictionarymanager.h \
    QmlElements/profilemanager.h \
    QmlElements/sessionmanager.h \
    QmlElements/wordmodel.h \
    dictionary.h \
    profile.h \
    word.h
