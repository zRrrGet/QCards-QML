#ifndef WORDELEMENT_H
#define WORDELEMENT_H
#include <QObject>
#include <QtQml>
#include "word.h"

class WordElement : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString from READ getFrom WRITE setFrom NOTIFY fromChanged)
    Q_PROPERTY(QString to READ getTo WRITE setTo NOTIFY toChanged)
private:
    Word w;
public:
    WordElement(Word w);
    QString getFrom();
    QString getTo();
    void setFrom(const QString &from);
    void setTo(const QString &to);
signals:
    void fromChanged();
    void toChanged();
};

#endif // WORDELEMENT_H
