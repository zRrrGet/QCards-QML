#include "profile.h"
#include <QSettings>

QString Profile::getUserName() const
{
    return userName;
}

void Profile::setUserName(const QString &value)
{
    userName = value;
}

Profile::Profile(QString name)
{
    pathToUserStats = "profiles/"+name+".config";
    QSettings stats(pathToUserStats, QSettings::IniFormat);
    userName = name;
    studyDays = stats.value("days").toLongLong();
}
