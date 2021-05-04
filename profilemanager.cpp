#include <QDir>
#include <algorithm>
#include "profilemanager.h"

void ProfileManager::pushProfile(const QString &p)
{
    profiles.push_back(p);
    emit profilesChanged();
}

QString ProfileManager::getCurrentProfile() const
{
    return currentProfile;
}

void ProfileManager::setCurrentProfile(QString name)
{
    if (std::find_if(profiles.begin(), profiles.end(),
                      [&name](Profile &p){return p.getUserName()==name;})==profiles.end())
        std::runtime_error("In ProfileManager::setCurrentProfile: no such profile");
    currentProfile = name;
    emit currentProfileChanged();
}

QVariantList ProfileManager::getJProfiles() const
{
    QVariantList jsProfiles;
    for(const auto& i : profiles)
        jsProfiles.push_back(i.getUserName());
    return jsProfiles;
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
    profiles.clear();
    QStringList conf = QDir("profiles").entryList(QStringList() << "*.config", QDir::Files);
    for(QString &fname : conf) {
        profiles.push_back(fname.remove(".config"));
    }
}

void ProfileManager::createProfile(const QString &name)
{
    if (QFile("profiles/"+name+".config").open(QIODevice::ReadWrite)) {
        updateArrays();
        emit profilesChanged();
    }
    else throw std::runtime_error("In ProfileManager::createProfile: can't open file");
}

ProfileManager::ProfileManager()
{
    updateArrays();
}
