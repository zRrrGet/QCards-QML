#ifndef DICTIONARYMANAGER_H
#define DICTIONARYMANAGER_H
#include <QObject>
#include <QtQml>
#include "../dictionary.h"
#include "wordmodel.h"

// class for managing dictionaries - getting words from dictionaries, etc
class DictionaryManager : public QObject
{
    Q_OBJECT
    // list of all dictionary names
    Q_PROPERTY(QVariantList dictionaries READ getDicts NOTIFY dictionariesChanged)
    // selected dictionary to process
    Q_PROPERTY(QString currentDictionary READ getCurrentDictionary WRITE setCurrentDictionary
               NOTIFY currentDictionaryChanged)
    // words of selected dictionary
    Q_PROPERTY(QVariantList currentWords READ getWords NOTIFY currentWordsChanged)
    // words of edited dictionary
    Q_PROPERTY(QVariantList editedWords READ getEditedWords NOTIFY editedWordsChanged)
    // dictionary which is edited now
    Q_PROPERTY(QString editedDictionary READ getEditedDictionary WRITE setEditedDictionary
               NOTIFY editedDictionaryChanged)
    QML_ELEMENT
private:
    QVector<Dictionary> dicts;
    QString currentDictionary;
    QString editedDictionary;
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
    // delete word from edited dictionary
    Q_INVOKABLE void deleteWordAt(int ind);
    // add word to edited dictionary
    Q_INVOKABLE void addWord(QString from, QString to);
    QString getEditedDictionary() const;
    void setEditedDictionary(const QString &value);
    QVariantList getEditedWords();

signals:
    void dictionariesChanged();
    void currentDictionaryChanged();
    void currentWordsChanged();
    void editedWordsChanged();
    void editedDictionaryChanged();
};

#endif // DICTIONARYMANAGER_H
