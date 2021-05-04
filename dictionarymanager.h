#ifndef DICTIONARYMANAGER_H
#define DICTIONARYMANAGER_H
#include <QObject>
#include <QtQml>
#include "dictionary.h"
#include "wordmodel.h"

class DictionaryManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantList dictionaries READ getDicts NOTIFY dictionariesChanged)
    Q_PROPERTY(QString currentDictionary READ getCurrentDictionary WRITE setCurrentDictionary
               NOTIFY currentDictionaryChanged)
    Q_PROPERTY(QVariantList currentWords READ getWords WRITE setWords NOTIFY currentWordsChanged)
    QML_ELEMENT
private:
    QVector<Dictionary> dicts;
    QString currentDictionary;
public:
    void updateDictionaries();
    DictionaryManager();
    QString getCurrentDictionary() const;
    void setCurrentDictionary(const QString &value);
    QVariantList getDicts() const;
    Q_INVOKABLE void deleteDictionary(const QString &name);
    Q_INVOKABLE void createDictionary(const QString &name);
    QVariantList getWords();
    Q_INVOKABLE QVariantList getWordsFromDict(const QString &dict);
    void setWords(QVariantList a);
    Q_INVOKABLE void deleteWordAt(int ind);
    Q_INVOKABLE void addWord(QString from, QString to);
signals:
    void dictionariesChanged();
    void currentDictionaryChanged();
    void currentWordsChanged();
};

#endif // DICTIONARYMANAGER_H
