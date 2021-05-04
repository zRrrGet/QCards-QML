#include "word.h"

QString Word::getSecond() const
{
    return second;
}


void Word::setFirst(const QString &value)
{
    first = value;
}

void Word::setSecond(const QString &value)
{
    second = value;
}

QVariantList Word::toQVariantList(const QList<Word> &ql)
{
    QVariantList vl;
    for(auto& i : ql)
        vl.push_back(QVariant::fromValue(i));
    return vl;
}

QList<Word> Word::toQList(const QVariantList &vl)
{
    QList<Word> ql;
    for(auto& i : vl)
        ql.push_back(i.value<Word>());
    return ql;
}

Word::Word(QString f, QString s) : first(f), second(s) {}

Word::Word() {}

QString Word::getFirst() const
{
    return first;
}
