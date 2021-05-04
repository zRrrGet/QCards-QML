#ifndef WORDMODEL_H
#define WORDMODEL_H

#include "word.h"

#include <QAbstractListModel>
#include <QtQml>

class WordModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QVariantList words READ getWords WRITE setWords NOTIFY wordsChanged)
    QML_ELEMENT
private:
    QList<Word> m_words;
protected:
    QHash<int, QByteArray> roleNames() const;
public:
    // Qt::UserRole	to define user roles
    enum Roles {from = Qt::UserRole	+ 1, to};
    WordModel();
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QVariantList getWords() const;
    void setWords(const QVariantList &words);
signals:
    void wordsChanged();
};

#endif // WORDMODEL_H
