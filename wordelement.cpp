#include "wordelement.h"

WordElement::WordElement(Word w) : w(w) {}

QString WordElement::getFrom()
{
    return w.getFirst();
}

QString WordElement::getTo()
{
    return w.getSecond();
}

void WordElement::setFrom(const QString &from)
{
    w.setFirst(from);
    emit fromChanged();
}

void WordElement::setTo(const QString &to)
{
    w.setSecond(to);
    emit toChanged();
}
