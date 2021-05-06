#ifndef SESSIONMANAGER_H
#define SESSIONMANAGER_H
#include "dictionary.h"

#include <QObject>
#include <QtQml>

class SessionManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString currentWord READ getCurrentWord NOTIFY currentWordChanged)
    QML_ELEMENT
private:
    QSharedPointer<Dictionary> sessionDictionary;
    QList<QString>::iterator dictionaryIt;
public:
    SessionManager();
    QString getCurrentWord();
signals:
    void currentWordChanged();
};

#endif // SESSIONMANAGER_H
