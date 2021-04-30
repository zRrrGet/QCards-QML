import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.15
import QtQml.Models 2.15

Dialog {
    id: dialog
    width: parent.width/3
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    visible: true
    modal: true
    standardButtons: Dialog.Ok | Dialog.Cancel
    DictionaryEditor {
        id: dictEditor
        visible: false
        width: dialog.parent.width/2
        height: dialog.parent.height/2
    }

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent
        anchors.margins: parent
        clip: true
        Label {
            text: "Dictionary:"
        }
        ComboBox {
            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: columnLayout.width
            Layout.bottomMargin: 20
        }
        Label {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Number of words: 0")
        }

        RowLayout {
            Layout.alignment: Qt.AlignBottom
            Button {
                Layout.preferredWidth: dialog.width/3-dialog.padding
                text: qsTr("Add")
            }
            Button {
                Layout.preferredWidth: dialog.width/3-dialog.padding
                text: qsTr("Edit");
                onClicked: dictEditor.visible=!dictEditor.visible
            }
            Button {
                Layout.preferredWidth: dialog.width/3-dialog.padding
                text: qsTr("Delete");
            }
        }
    }

}
