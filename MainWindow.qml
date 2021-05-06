import QtQuick 2.0
import QtQuick.Window 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import custom.managers 1.0 // custom module of the project

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
    }
    DictionaryManager {
        id: dictionaryManager
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
        id: mainLayout
        width: parent.width
        height: parent.height
        Item {
            Layout.alignment: Qt.AlignTop
            Layout.preferredWidth: mainWindow.width
            Rectangle {
                id: profileNotification
                width: mainWindow.width
                height: profileLabel.height+15
                color: profileManager.currentProfile===""?"#ffbfbf":"#90ff8a";
                border.color: profileManager.currentProfile===""?"red":"green"
                border.width: 2
                Label {
                    anchors.centerIn: parent
                    id: profileLabel
                    font.pointSize: 10
                    text: profileManager.currentProfile===""?
                              qsTr("Profile is not selected"):
                                qsTr("Profile " + profileManager.currentProfile + " selected")
                }
            }
            Rectangle {
                id: dictionaryNotification
                anchors.top: profileNotification.bottom
                width: mainWindow.width
                height: dictionaryLabel.height+15
                color: dictionaryManager.currentDictionary===""?"#ffbfbf":"#90ff8a";
                border.color: dictionaryManager.currentDictionary===""?"red":"green"
                border.width: 2
                Label {
                    anchors.centerIn: parent
                    id: dictionaryLabel
                    font.pointSize: 10
                    text: dictionaryManager.currentDictionary===""?
                              qsTr("Dictionary is not selected"):
                                qsTr("Dictionary " + dictionaryManager.currentDictionary + " selected")
                }
            }

        }
        ColumnLayout {
            Layout.alignment: Qt.AlignBottom
            Rectangle {
                id: blueLine
                Layout.preferredWidth: mainWindow.width
                height: 2
                color: "blue"
            }
            RoundButton {
                id: sessionButton
                radius: 5
                text: qsTr("Start session")
                Layout.preferredWidth: mainWindow.width
                onClicked: stateGroup.state = "SessionStarted"
            }
            RowLayout {
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

    // session elements
    Label {
        id: centralLabel
        text: "aaaaaaaaaaaaaaa"
        anchors.centerIn: mainLayout
        font.pointSize: 20
        visible: false
    }
    Rectangle {
        id: sessionLine
        width: mainWindow.width
        height: 2
        color: "gray"
        anchors.bottom: answerField.top
        anchors.bottomMargin: 10
        visible: false
    }
    TextField {
        id: answerField
        placeholderText: qsTr("Translation")
        width: mainWindow.width
        anchors.bottom: inputButton.top
        visible: false
    }
    RoundButton {
        id: inputButton
        radius: 5
        text: qsTr("OK")
        width: mainWindow.width
        anchors.bottom: mainLayout.bottom
        visible: false
    }
    //

    StateGroup {
        id: stateGroup
        states: [
            State {
                name: "notReady"
                PropertyChanges { target: sessionButton; enabled: false }
                when: profileManager.currentProfile==="" || dictionaryManager.currentDictionary===""
            },
            State {
               name: "Ready"
               PropertyChanges { target: sessionButton; enabled: true }
               when: profileManager.currentProfile!=="" && dictionaryManager.currentDictionary!==""
            },
            State {
               name: "SessionStarted"
               PropertyChanges { target: sessionButton; enabled: true }
               PropertyChanges { target: profileButton; visible: false }
               PropertyChanges { target: dictionaryButton; visible: false }
               PropertyChanges { target: sessionButton; visible: false }
               PropertyChanges { target: blueLine; visible: false }
               PropertyChanges { target: inputButton; visible: true }
               PropertyChanges { target: answerField; visible: true }
               PropertyChanges { target: sessionLine; visible: true }
               PropertyChanges { target: centralLabel; visible: true }
            }
        ]
    }
}
