#ifndef SESSIONMANAGER_H
#define SESSIONMANAGER_H
#include "dictionary.h"
#include "profile.h"

#include <QObject>
#include <QtQml>

// manages session, check answers and output word for session depending on profile and dictionary
class SessionManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString currentWord READ getCurrentWord NOTIFY currentWordChanged)
    Q_PROPERTY(QString profile WRITE setProfile NOTIFY profileChanged)
    Q_PROPERTY(QString dictionary WRITE setDictionary NOTIFY dictionaryChanged)
    // number of words in the session(if it is higher than number of words in dictionary - the least will be picked)
    Q_PROPERTY(int sessionWordCount READ getSessionWordCount WRITE setSessionWordCount NOTIFY sessionWordCountChanged)
    // number of answered words
    Q_PROPERTY(int answeredWordsCount READ getAnsweredWordsCount NOTIFY answeredWordsCountChanged)
    QML_ELEMENT
private:
    QSharedPointer<Dictionary> sessionDictionary;
    QSharedPointer<Profile> sessionProfile;
    // array of words for current session
    QList<Word> sessionWords;
    // iterator through sessionWords
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
    // should be called to start recieving words and answers
    Q_INVOKABLE void start();
    // should be called in the end of session to stop it and get statistics
    // statistics are to be get from QVariantList: [0] - answeredWordsCount, [1] - correctWordsCount,
    // [2] - number of days studying, [3] - number of remaining words, [4] - how many words remaining in %
    Q_INVOKABLE QVariantList end();
    // actual number of size of sessionWords
    Q_INVOKABLE int getPoolWordsCount();
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
