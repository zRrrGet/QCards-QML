import QtQuick 2.0
import QtQuick.Window 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

ApplicationWindow {
    id: mainWindow
    width: 800
    height: 600
    visible: true
    menuBar: MenuBar {
            Menu {
                title: qsTr("Settings")
                Action { text: qsTr("Session") }
                Action { text: qsTr("Profile") }
                Action { text: qsTr("Dictionary") }
                MenuSeparator { }
                Action { text: qsTr("Log out(Profile)") }
                Action { text: qsTr("&Quit") }
            }
        }

    ColumnLayout {
        width: parent.width
        height: parent.height
        Label {
            Layout.alignment: Qt.AlignCenter
            font.pointSize: 30
            text: qsTr("Profile is not selected")
        }
        Label {
            Layout.alignment: Qt.AlignCenter
            font.pointSize: 30
            text: qsTr("Dictionary is not selected")
        }
        Button {
            text: qsTr("Start Session")
            Layout.alignment: Qt.AlignBottom
            Layout.preferredWidth: mainWindow.width
        }
    }
}
