CONFIG += qmltypes

QT += quick

CONFIG += c++11

QML_IMPORT_NAME = custom.managers
QML_IMPORT_MAJOR_VERSION = 1

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        dictionary.cpp \
        dictionarymanager.cpp \
        main.cpp \
        profile.cpp \
        profilemanager.cpp \
        sessionmanager.cpp \
        word.cpp

RESOURCES += \
    res.qrc

TRANSLATIONS += \ts\
    QCards-QML_en_US.ts

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = $$PWD

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
    dictionary.h \
    dictionarymanager.h \
    profile.h \
    profilemanager.h \
    sessionmanager.h \
    word.h
