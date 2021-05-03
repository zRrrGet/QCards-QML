#ifndef WORD_H
#define WORD_H
#include <QString>


class Word // class, containing pair of words
{
private:
    QString first;
    QString second;
public:
    Word(QString f, QString s) : first(f), second(s) {
    }
    Word();
    ~Word(){}
    QString getFirst() const;
    QString getSecond() const;
};

#endif // WORD_H
