#ifndef DICTIONARY_H
#define DICTIONARY_H
#include <vector>
#include <word.h>
#include <QString>
#include <QVector>

class Dictionary
{
private:
    QString dictName;
    QVector<Word> words;
    QString pathToDict;
public:
    Dictionary();
    Dictionary(QString path);
    void insertWord(Word w);
    void deleteWord(Word w);
    void updateWords();
    void updateFile();
    long long findWord(Word w);
    long long getWordCount() const;
    void setWordCount(long long value);
    QVector<Word> getWords() const;
    QString getPathToDict() const;
    QString getDictName() const;
};

#endif // DICTIONARY_H
