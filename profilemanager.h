#ifndef PROFILEMANAGER_H
#define PROFILEMANAGER_H
#include <QVector>
#include <QObject>
#include <QtQml>
#include "profile.h"

// class to manage with profiles(adding, deleting, etc)
class ProfileManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString currentProfile READ getCurrentProfile WRITE setCurrentProfile
               NOTIFY currentProfileChanged)
    Q_PROPERTY(QVariantList profiles READ getJProfiles
               NOTIFY profilesChanged)
    QML_ELEMENT
private:
    QString currentProfile;
    QVector<Profile> profiles;
public:
    ProfileManager();
    void pushProfile(const QString &p);
    QString getCurrentProfile() const;
    void setCurrentProfile(QString name);
    QVariantList getJProfiles() const;
    void setJProfiles(const QVariantList &value);
    Q_INVOKABLE void deleteProfile(const QString &name);
    void updateArrays();
    Q_INVOKABLE void createProfile(const QString &name);
signals:
    void profilesChanged();
    void currentProfileChanged();
};

#endif // PROFILEMANAGER_H
