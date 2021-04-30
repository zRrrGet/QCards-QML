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

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent
        clip: true
        Label {
            text: "Profile:"
        }

        ComboBox {
            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: columnLayout.width
            Layout.bottomMargin: 20
        }
        RowLayout {
            Layout.alignment: Qt.AlignBottom
            Button {
                Layout.preferredWidth: columnLayout.width/2
                text: qsTr("Add")
            }
            Button {
                Layout.preferredWidth: columnLayout.width/2
                text: qsTr("Delete");
            }
        }
    }

}
