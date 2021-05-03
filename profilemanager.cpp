#include <QDir>
#include <algorithm>
#include "profilemanager.h"

void ProfileManager::pushProfile(const QString &p)
{
    jProfiles.push_back(p);
    profiles.push_back(p);
    emit profilesChanged();
}

QString ProfileManager::getCurrentProfile() const
{
    return currentProfile;
}

void ProfileManager::setCurrentProfile(QString name)
{
    if (!jProfiles.contains(name))
        std::runtime_error("In ProfileManager::setCurrentProfile: no such profile");
    currentProfile = name;
    emit currentProfileChanged();
}

QVariantList ProfileManager::getJProfiles() const
{
    return jProfiles;
}

void ProfileManager::setJProfiles(const QVariantList &value)
{
    jProfiles = value;
    emit profilesChanged();
}

void ProfileManager::deleteProfile(const QString &name)
{
    if (currentProfile==name) {
        currentProfile = "";
        emit currentProfileChanged();
    }

    // deleting profile file
    QFile("profiles/"+name+".config").remove();

    updateArrays();

    emit profilesChanged();
}

void ProfileManager::updateArrays()
{
    jProfiles.clear();
    profiles.clear();
    QStringList conf = QDir("profiles").entryList(QStringList() << "*.config", QDir::Files);
    for(QString &fname : conf) {
        pushProfile(fname.remove(".config"));
        profiles.push_back(fname.remove(".config"));
    }
}

ProfileManager::ProfileManager()
{
    updateArrays();
}
