import QtQuick 2.0
import QtQuick.Window 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

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
                color: "#ffbfbf"                   // "#90ff8a"
                border.color: "red"                // "green"
                border.width: 2
                Label {
                    anchors.centerIn: parent
                    id: profileLabel
                    font.pointSize: 10
                    text: qsTr("Profile is not selected")
                }
            }
            Rectangle {
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
                onClicked: console.warn("zhopa")
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
}
