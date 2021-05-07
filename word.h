#ifndef WORD_H
#define WORD_H
#include <QString>
#include <QMetaType>
#include <QList>
#include <QVariant>

class Word // class, containing pair of words
{
private:
    QString first;
    QString second;
public:
    Word(QString f, QString s);
    Word();
    QString getFirst() const;
    QString getSecond() const;
    void setFirst(const QString &value);
    void setSecond(const QString &value);
    static QVariantList toQVariantList(const QList<Word> &ql);
    static QList<Word> toQList(const QVariantList &vl);
};
Q_DECLARE_METATYPE(Word)

#endif // WORD_H
