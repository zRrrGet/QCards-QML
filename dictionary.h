#ifndef DICTIONARY_H
#define DICTIONARY_H
#include <vector>
#include <word.h>
#include <QString>
#include <QList>
#include <memory>

class Dictionary
{
private:
    QString dictName;
    QList<Word> words;
    QString pathToDict;
public:
    Dictionary();
    Dictionary(QString name);
    void insertWord(Word w);
    void deleteWord(Word w);
    void updateWords();
    void updateFile();
    long long findWord(Word w);
    long long getWordCount() const;
    QList<Word> getWords() const;
    QString getPathToDict() const;
    QString getDictName() const;
};

#endif // DICTIONARY_H
