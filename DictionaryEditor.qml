import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.15
import QtQml.Models 2.15
import custom.managers 1.0

// dialog with table to edit contents of dictionary
Dialog {
    id: dialog
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    height: 1000
    visible: true
    modal: true
    standardButtons: Dialog.Ok
    Label {
        id: title
        text: "Content of the dictionary:"
    }
    WordModel {
        id: wm
        words: dictionaryManager.editedWords
    }
    // add button dialog
    Dialog {
        id: addDialog
        visible: false
        standardButtons: Dialog.Ok | Dialog.Cancel
        width: parent.width
        height: parent.height
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        TextField {
            id: fromField
            width: parent.width
            placeholderText: qsTr("Enter original word")
        }
        TextField {
            id: toField
            anchors.top: fromField.bottom
            width: parent.width
            placeholderText: qsTr("Enter translation")
        }
        onAccepted: {
            if (fromField.text != "" && toField.text != "") {
                dictionaryManager.addWord(fromField.text, toField.text);
                fromField.text = "";
                toField.text = "";
            }
            else {
                fromField.text = "";
                toField.text = "";
                accepted = false;
            }

        }
    }

    ListView {
        id: table
        anchors.top: title.bottom
        y: dialog.padding
        width: dialog.width*2/3
        height: dialog.height-dialog.implicitFooterHeight-dialog.padding*3
        model: wm
        headerPositioning: ListView.OverlayHeader
        clip: true
        header: Item {
                width: parent.width
                height: fromHeaderLabel.height+1
                z: 4
                Row {
                    id: headerRow
                    width: parent.width
                    Rectangle {
                        width: parent.width/2
                        height: fromHeaderLabel.height
                        color: "white"
                        Label {
                            id: fromHeaderLabel
                            x: 10
                            text: qsTr("original word")
                        }
                    }

                    Rectangle { height: toHeaderLabel.height; width: 1; color: "black" }

                    Rectangle {
                        width: parent.width/2
                        height: toHeaderLabel.height
                        color: "white"
                        Label {
                            id: toHeaderLabel
                            x: 10
                            text: qsTr("translation")
                        }
                    }
                }
                Rectangle {
                    height: 1
                    width: parent.width
                    color: "black"
                    anchors.top : headerRow.bottom
                }

        }
        delegate: Item {
                    width: parent.width
                    height: fromLabel.height
                    Row {
                        width: parent.width
                        Rectangle {
                            width: parent.width/2
                            height: fromLabel.height
                            color: "white"
                            Label {
                                id: fromLabel
                                x: 10
                                text: from
                            }
                        }
                        Rectangle {
                            height: toLabel.height
                            width: 1
                            color: "black"
                        }
                        Rectangle {
                            width: parent.width/2
                            height: toLabel.height
                            color: "white"
                            Label {
                                id: toLabel
                                x: 10
                                text: to
                            }
                        }
                }
                MouseArea {
                    id: selectedRowArea
                    height: parent.height
                    width: parent.width
                    anchors.fill: parent
                    z: 3
                    onClicked: {
                        table.currentIndex = index
                    }
                }
        }
        ScrollIndicator.vertical: ScrollIndicator { }
        boundsBehavior: Flickable.StopAtBounds
        highlight: Rectangle
                      {
                           color: palette.highlight
                           opacity: 0.5
                           focus: true
                           z: 3
                      }
    }
    ColumnLayout {
        anchors.left: table.right
        anchors.leftMargin: 10
        width: dialog.width/3-35
        height: dialog.height-dialog.implicitFooterHeight-dialog.padding*3
        Button {
            text: qsTr("Add")
            Layout.fillWidth: true
            onClicked: {
                addDialog.visible = true;
            }
        }
        Button {
            Layout.alignment: Qt.AlignBottom
            text: qsTr("Delete")
            Layout.fillWidth: true
            onClicked:  if (table.count) dictionaryManager.deleteWordAt(table.currentIndex)
        }
    }
    onAccepted: {
        dictionarySelector.updateWordCounter()
    }
}
