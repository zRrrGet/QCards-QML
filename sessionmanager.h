#ifndef SESSIONMANAGER_H
#define SESSIONMANAGER_H
#include "dictionary.h"
#include "profile.h"

#include <QObject>
#include <QtQml>

class SessionManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString currentWord READ getCurrentWord NOTIFY currentWordChanged)
    Q_PROPERTY(QString profile WRITE setProfile NOTIFY profileChanged)
    Q_PROPERTY(QString dictionary WRITE setDictionary NOTIFY dictionaryChanged)
    Q_PROPERTY(int sessionWordCount READ getSessionWordCount WRITE setSessionWordCount NOTIFY sessionWordCountChanged)
    Q_PROPERTY(int answeredWordsCount READ getAnsweredWordsCount NOTIFY answeredWordsCountChanged)
    QML_ELEMENT
private:
    QSharedPointer<Dictionary> sessionDictionary;
    QSharedPointer<Profile> sessionProfile;
    QList<Word> sessionWords;
    QList<Word>::iterator wordIterator;
    int correctWordsCount;
    int sessionWordCount;
    int answeredWordsCount;
    bool isStarted;
public:
    SessionManager();
    QString getCurrentWord();
    void setProfile(QString name);
    void setDictionary(QString name);
    int getCorrectWordsCount() const;
    void setCorrectWordsCount(int value);
    Q_INVOKABLE QString sendAnswer(QString ans);
    void setSessionWordCount(int num);
    Q_INVOKABLE void start();
    Q_INVOKABLE QVariantList end();
    int getSessionWordCount() const;
    int getAnsweredWordsCount() const;

signals:
    void currentWordChanged();
    void profileChanged();
    void dictionaryChanged();
    void sessionWordCountChanged();
    void answeredWordsCountChanged();
};

#endif // SESSIONMANAGER_H
