#include "wordmodel.h"

void WordModel::setWords(const QVariantList &words)
{
    beginRemoveRows(QModelIndex(), 0, m_words.size()-1);
    m_words.clear();
    endRemoveRows();
    beginInsertRows(QModelIndex(), 0, words.size()-1);

    m_words = Word::toQList(words);

    endInsertRows();
    emit wordsChanged();
}

QVariantList WordModel::getWords() const
{
    return Word::toQVariantList(m_words);
}

QHash<int, QByteArray> WordModel::roleNames() const
{
    QHash<int, QByteArray> r;
    r[from] = "from";
    r[to] = "to";
    return r;
}

WordModel::WordModel() {}

int WordModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid()) return 0;
    return m_words.size();
}

QVariant WordModel::data(const QModelIndex &index, int role) const
{
    if (role == from)
        return m_words[index.row()].getFirst();
    else if (role==to)
        return m_words[index.row()].getSecond();
    return QVariant();
}
