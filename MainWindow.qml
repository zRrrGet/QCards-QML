import QtQuick 2.0
import QtQuick.Window 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import custom.managers 1.0

ApplicationWindow {
    id: mainWindow
    minimumWidth: 640
    minimumHeight: 480
    width: 640
    height: 480
    visible: true
    palette.window: "#8cddff"
    palette.button: "#00b4ff"
    title: "QCards"
    ProfileManager {
        id: profileManager
        onCurrentProfileChanged: {
            if (currentProfile!="") {
                profileNotification.color = "#90ff8a"
                profileNotification.border.color = "green"
                profileLabel.text = "Profile " + profileManager.currentProfile + " selected"
            }
            else {
                profileNotification.color = "#ffbfbf"
                profileNotification.border.color = "red"
                profileLabel.text = "Profile is not selected"
            }
        }
    }
    ProfileSettings {
        id: profilePopup
        visible: false
    }
    DictionarySettings {
        id: dictionaryPopup
        visible: false
    }

    ColumnLayout {
        width: parent.width
        height: parent.height
        Item {
            Layout.alignment: Qt.AlignTop
            Layout.preferredWidth: mainWindow.width
            Rectangle {
                id: profileNotification
                width: mainWindow.width
                height: profileLabel.height+15
                color: "#ffbfbf"
                border.color: "red"
                border.width: 2
                Label {
                    anchors.centerIn: parent
                    id: profileLabel
                    font.pointSize: 10
                    text: qsTr("Profile is not selected")
                }
            }
            Rectangle {
                id: dictionaryNotification
                anchors.top: profileNotification.bottom
                width: mainWindow.width
                height: dictionaryLabel.height+15
                color: "#ffbfbf"
                border.color: "red"
                border.width: 2
                Label {
                    anchors.centerIn: parent
                    id: dictionaryLabel
                    font.pointSize: 10
                    text: qsTr("Dictionary is not selected")
                }
            }

        }
        ColumnLayout {
            Layout.alignment: Qt.AlignBottom
            Rectangle {
                Layout.preferredWidth: mainWindow.width
                height: 2
                color: "blue"
            }
            RoundButton {
                id: sessionButton
                radius: 5
                text: qsTr("Start session")
                Layout.preferredWidth: mainWindow.width
            }
            RowLayout {
                Layout.alignment: Qt.AlignBottom
                Layout.preferredWidth: mainWindow.width
                RoundButton {
                    id: profileButton
                    radius: 5
                    text: qsTr("Choose profile")
                    Layout.preferredWidth: mainWindow.width/2
                    onClicked: profilePopup.visible=!profilePopup.visible
                }
                RoundButton {
                    id: dictionaryButton
                    radius: 5
                    text: qsTr("Choose dictionary")
                    Layout.preferredWidth: mainWindow.width/2
                    onClicked: dictionaryPopup.visible=!dictionaryPopup.visible
                }
            }
        }
    }
    StateGroup {
        id: stateGroup
        states: [
            State {
               name: "ProfileAndDictionary"
               PropertyChanges { target: profileNotification; color: "#ffbfbf"; border.color: "red" }
               PropertyChanges { target: dictionaryNotification; color: "#ffbfbf"; border.color: "red" }
               PropertyChanges { target: profileLabel; text: qsTr("Profile is not selected") }
               PropertyChanges { target: dictionaryLabel; text: qsTr("Dictionary is not selected") }
            },
            State {
               name: "Profile"
               PropertyChanges { target: profileNotification; color: "#ffbfbf"; border.color: "red" }
               PropertyChanges { target: dictionaryNotification; color: "#90ff8a"; border.color: "green" }
               PropertyChanges { target: profileLabel; text: qsTr("Profile is not selected") }
               PropertyChanges { target: dictionaryLabel; text: qsTr("Profile " + profileManager.currentProfile + " selected")}
            },
            State {
               name: "Dictionary"
               PropertyChanges { target: profileNotification; color: "#90ff8a"; border.color: "green" }
               PropertyChanges { target: dictionaryNotification; color: "#ffbfbf"; border.color: "red" }
               PropertyChanges { target: profileLabel; text: qsTr("Dictionary " + profileManager.currentProfile + " selected") }
               PropertyChanges { target: dictionaryLabel; text: qsTr("Profile is not selected")}
            },
            State {
                name: "Ready"
                PropertyChanges { target: profileNotification; color: "#90ff8a"; border.color: "green" }
                PropertyChanges { target: dictionaryNotification; color: "#90ff8a"; border.color: "green" }
                PropertyChanges { target: profileLabel; text: qsTr("Dictionary " + profileManager.currentProfile + " selected") }
                PropertyChanges { target: dictionaryLabel; text: qsTr("Profile " + profileManager.currentProfile + " selected")}
            }
        ]
    }
}
