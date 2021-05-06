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
            placeholderText: qsTr("Enter title")
        }
        onAccepted: {
            dictionaryManager.createDictionary(textField.text);
            textField.text = ""
        }
    }
    ColumnLayout {
        id: columnLayout
        anchors.fill: parent
        anchors.margins: parent
        clip: true
        Label {
            text: qsTr("Dictionary:")
        }
        ComboBox {
            id: dictionarySelector
            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: columnLayout.width
            Layout.bottomMargin: 20
            model: dictionaryManager.dictionaries
            onCurrentTextChanged: updateWordCounter()
            function updateWordCounter() {
                countLabel.text = qsTr("Number of words: ") +
                                    dictionaryManager.getWordsFromDict(currentText).length
            }
        }
        Label {
            id: countLabel
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Number of words: 0")
        }

        RowLayout {
            Layout.alignment: Qt.AlignBottom
            Button {
                Layout.preferredWidth: dialog.width/3-dialog.padding
                text: qsTr("Add")
                onClicked: addDialog.visible = true;
            }
            Button {
                Layout.preferredWidth: dialog.width/3-dialog.padding
                text: qsTr("Edit");
                onClicked: {dictEditor.visible=!dictEditor.visible;
                    dictionaryManager.editedDictionary = dictionarySelector.currentText;
                    console.warn(dictionaryManager.model) }
            }
            Button {
                Layout.preferredWidth: dialog.width/3-dialog.padding
                text: qsTr("Delete");
                onClicked: dictionaryManager.deleteDictionary(dictionarySelector.currentText)
            }
        }
    }
    onAccepted: dictionaryManager.currentDictionary = dictionarySelector.currentText;

}
