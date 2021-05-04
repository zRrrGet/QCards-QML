#include "dictionarymanager.h"
#include "wordelement.h"
#include <QDebug>

QString DictionaryManager::getCurrentDictionary() const
{
    return currentDictionary;
}

void DictionaryManager::setCurrentDictionary(const QString &value)
{
    currentDictionary = value;
    emit currentDictionaryChanged();
    emit currentWordsChanged();
}

QVariantList DictionaryManager::getDicts() const
{
    QVariantList jsProfiles;
    for (const auto& i : dicts)
        jsProfiles.push_back(i.getDictName());
    return jsProfiles;
}

void DictionaryManager::deleteDictionary(const QString &name)
{
    if (currentDictionary==name) {
        setCurrentDictionary("");
    }

    // deleting profile file
    QFile("dictionaries/"+name+".dict").remove();

    updateDictionaries();

    emit dictionariesChanged();
}

void DictionaryManager::createDictionary(const QString &name)
{
    if (QFile("dictionaries/"+name+".dict").open(QIODevice::ReadWrite)) {
        updateDictionaries();
        emit dictionariesChanged();
    }
    else throw std::runtime_error("In DictionaryManager::createDictionary: can't open file");
}

QVariantList DictionaryManager::getWords()
{
    if (currentDictionary=="") return QVariantList();
    return getWordsFromDict(currentDictionary);
}

QVariantList DictionaryManager::getWordsFromDict(const QString &dict)
{
    if (dict=="") return QVariantList();
    return Word::toQVariantList(std::find_if(dicts.begin(), dicts.end(),
                                             [&dict](Dictionary &d){return d.getDictName()==dict;})->getWords());
}

void DictionaryManager::setWords(QVariantList a)
{

}

void DictionaryManager::deleteWordAt(int ind)
{
    auto current = std::find_if(dicts.begin(), dicts.end(),
                       [this](Dictionary &d){return d.getDictName()==currentDictionary;});
    current->deleteWord(current->getWords().at(ind));
    emit currentWordsChanged();
}

void DictionaryManager::addWord(QString from, QString to)
{
    auto current = std::find_if(dicts.begin(), dicts.end(),
                       [this](Dictionary &d){return d.getDictName()==currentDictionary;});
    current->insertWord(Word(from, to));
    emit currentWordsChanged();
}

void DictionaryManager::updateDictionaries()
{
    dicts.clear();
    QStringList dict = QDir("dictionaries").entryList(QStringList() << "*.dict",QDir::Files);
    for (QString &fname : dict)
        dicts.push_back(fname.remove(".dict"));
}

DictionaryManager::DictionaryManager()
{
    updateDictionaries();
}
