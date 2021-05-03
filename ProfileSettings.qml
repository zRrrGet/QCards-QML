import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.15
import QtQml.Models 2.15
import custom.managers 1.0

Dialog {
    id: dialog
    width: parent.width/3
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    visible: true
    modal: true
    standardButtons: Dialog.Ok | Dialog.Cancel

    Dialog {
        id: addDialog
        visible: false
        standardButtons: Dialog.Ok | Dialog.Cancel
        width: parent.width
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        TextField {
            id: textField
            width: parent.width
            placeholderText: qsTr("Enter name")
        }
        onAccepted: {
            profileManager.createProfile(textField.text);
            textField.text = ""
        }
    }

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent
        clip: true
        Label {
            text: "Profile:"
        }

        ComboBox {
            id: profileSelector
            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: columnLayout.width
            Layout.bottomMargin: 20
            model: profileManager.profiles
        }
        RowLayout {
            Layout.alignment: Qt.AlignBottom
            Button {
                Layout.preferredWidth: columnLayout.width/2
                text: qsTr("Add")
                onClicked: addDialog.visible = true
            }
            Button {
                Layout.preferredWidth: columnLayout.width/2
                text: qsTr("Delete");
                onClicked: profileManager.deleteProfile(profileSelector.currentText)
            }
        }
    }
    onAccepted: profileManager.currentProfile = profileSelector.currentText;
}
