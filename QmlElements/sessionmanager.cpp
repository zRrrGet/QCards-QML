#include "sessionmanager.h"

int SessionManager::getCorrectWordsCount() const
{
    return correctWordsCount;
}

void SessionManager::setCorrectWordsCount(int value)
{
    correctWordsCount = value;
}

void SessionManager::start()
{
    if (!sessionDictionary || !sessionProfile)
        throw std::runtime_error("In SessionManager::sendAnswer: no set profile or dictionary");

    QSettings sets("profiles/"+sessionProfile->getUserName()+".config", QSettings::IniFormat);
    sets.beginGroup(sessionDictionary->getDictName());

    for (int i = 0;i<6;++i) { // form session words array with words sorted by their "stage"(words with lower stage will be considered firstly)
        for (int j = 0;j < sessionDictionary->getWords().size() && sessionWords.size()<sessionWordCount; ++j) {
            QString key = (sessionDictionary->getWords()[j].getFirst()+";"+sessionDictionary->getWords()[j].getSecond());

            key.replace(" ","_");

            // if word in config have no stage - it's 0
            if (!i&&!sets.allKeys().contains(key)) sessionWords.push_back(Word(sessionDictionary->getWords()[j].getFirst(),
                                                                               sessionDictionary->getWords()[j].getSecond()));
            else if (sets.value(key)==i){
                sessionWords.push_back(Word(sessionDictionary->getWords()[j].getFirst(),
                                            sessionDictionary->getWords()[j].getSecond()));
            }
        }
    }

    wordIterator = sessionWords.begin();

    isStarted = true;
    sets.endGroup();
}

QVariantList SessionManager::end()
{
    QVariantList info;
    QSettings sets("profiles/"+sessionProfile->getUserName()+".config", QSettings::IniFormat);
    sets.beginGroup("Stats");

    // lastday contains last day when user studied, days is the number of day they studied
    if (sets.allKeys().contains("lastday")&&sets.value("lastday").toDate()!=QDate().currentDate()) {
        sets.setValue("days", sets.value("days").toInt()+1);
        sets.setValue("lastday",QDate().currentDate());
    }
    else if (!(sets.allKeys().contains("lastday"))) {
        sets.setValue("lastday", QDate().currentDate());
        sets.setValue("days", sets.value("days").toInt()+1);;
    }

    sets.endGroup();
    sets.beginGroup(sessionDictionary->getDictName());

    int remain = 6*sessionDictionary->getWords().size(); // counting stages(6 stages)

    QStringList l = sets.allKeys();
    for(QString &key : l)
        remain-=sets.value(key).toInt();
    sets.endGroup();

    sets.beginGroup("Stats");

    // put statistics
    info << answeredWordsCount << correctWordsCount << sets.value("days") << remain;
    info << (double(remain)/(6*sessionDictionary->getWords().size())*100);

    isStarted = false;
    sessionWords.clear();
    correctWordsCount=0;
    answeredWordsCount=0;
    return info;
}

int SessionManager::getPoolWordsCount()
{
    return sessionWords.size();
}

int SessionManager::getSessionWordCount() const
{
    return sessionWordCount;
}

int SessionManager::getAnsweredWordsCount() const
{
    return answeredWordsCount;
}

SessionManager::SessionManager() : correctWordsCount(0), sessionWordCount(INT_MAX),
    answeredWordsCount(0), isStarted(false) { }

QString SessionManager::getCurrentWord()
{
    if (!isStarted) throw std::runtime_error("In SessionManager::getCurrentWord: session haven't started(use start())");
    return wordIterator->getFirst();
}

QString SessionManager::sendAnswer(QString ans) {
    if (!isStarted) throw std::runtime_error("In SessionManager::sendAnswer: session haven't started yet(use start())");
    if (wordIterator>=sessionWords.end() || answeredWordsCount>=sessionWordCount)
        throw std::runtime_error("In SessionManager::sendAnswer: session ended, but sendAnswer is called");

    QSettings sets("profiles/"+sessionProfile->getUserName()+".config", QSettings::IniFormat);
    QString key = (wordIterator->getFirst()+";"+wordIterator->getSecond());
    key.replace(" ","_");
    sets.beginGroup(sessionDictionary->getDictName());

    if (!ans.compare(wordIterator->getSecond(), Qt::CaseSensitivity::CaseInsensitive)) {
        ++correctWordsCount;

        // increase stage of pair of words
        if (sets.allKeys().contains(key)) sets.setValue(key,sets.value(key).toInt()+1);
        else sets.setValue(key,1);
    }
    else {
        // decrease stage of pair of words
        if (sets.allKeys().contains(key)&& sets.value(key).toInt()-1>0) sets.setValue(key,sets.value(key).toInt()-1);
        else if (sets.allKeys().contains(key)) sets.remove(key);
    }
    ++answeredWordsCount;
    sets.endGroup();

    return wordIterator++->getSecond();
}

void SessionManager::setSessionWordCount(int num)
{
    if (isStarted) throw std::runtime_error("In SessionManager::setSessionWordCount: restricted during session");
    sessionWordCount = num;
    emit sessionWordCountChanged();
}

void SessionManager::setProfile(QString name)
{
    sessionProfile.clear();
    sessionProfile.reset(new Profile(name));
    emit profileChanged();
}

void SessionManager::setDictionary(QString name)
{
    sessionDictionary.clear();
    sessionDictionary.reset(new Dictionary(name));
    emit dictionaryChanged();
}
