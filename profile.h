#ifndef PROFILE_H
#define PROFILE_H
#include <QString>
#include <QObject>
#include <QtQml>

// incapsulates some statisticks and information about profile
class Profile
{
private:
    QString userName;
    QString pathToUserStats;
    long long studyDays; // number of days when user studied
public:
    Profile(QString name);
    QString getUserName() const;
    void setUserName(const QString &value);
};

#endif // PROFILE_H
