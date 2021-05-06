#include "dictionary.h"
#include <fstream>
#include <string>
#include <QString>
#include <QFile>
#include <QVector>
#include <iostream>


Dictionary::Dictionary(QString name)
{
    pathToDict = "dictionaries/"+name+".dict";
    dictName = name;
    updateWords();
}
void Dictionary::insertWord(Word w)
{
    std::fstream dictFile(pathToDict.toStdString(), std::ios::app);
    dictFile << w.getFirst().toStdString() << ";" << w.getSecond().toStdString() << ";"; // ; is a separator
    dictFile.close();
    words.push_back(w);
}

void Dictionary::deleteWord(Word w)
{
    if (findWord(w)!=-1) {
        words.erase(words.begin()+findWord(w));
        updateFile();
    }
}

void Dictionary::updateWords()
{
    std::string f,s;
    words.clear();
    std::fstream dictFile(pathToDict.toStdString(), std::ios::in);
    while (std::getline(dictFile,f,';')) {
        std::getline(dictFile,s,';');
        words.push_back(Word(QString::fromStdString(f),QString::fromStdString(s)));

    }
    dictFile.close();
}

void Dictionary::updateFile()    // rewrites file according to the "words" array
{
    std::fstream dictFile(pathToDict.toStdString(), std::ios::out);
    for (int i = 0; i < words.size();++i)
        dictFile << words[i].getFirst().toStdString() << ";" << words[i].getSecond().toStdString() << ";";
    dictFile.close();
}

long long Dictionary::findWord(Word w)
{
    for (int i = 0;i < words.size();++i)
        if (w.getFirst()==words[i].getFirst()&&w.getSecond()==words[i].getSecond()) return i;
    return -1;
}

QList<Word> Dictionary::getWords() const
{
    return words;
}

QString Dictionary::getPathToDict() const
{
    return pathToDict;
}

QString Dictionary::getDictName() const
{
    return dictName;
}

Dictionary::Dictionary() {}


