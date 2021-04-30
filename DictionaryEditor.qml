import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.14
import QtQuick.Controls 2.15
import QtQml.Models 2.15

Dialog {
    id: dialog
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    height: 1000
    visible: true
    modal: true
    standardButtons: Dialog.Ok
    ListModel {
        id: wordModel
        ListElement { from: "1"; to: "second" }
        ListElement { from: "2"; to: "second" }
        ListElement { from: "3"; to: "second" }
        ListElement { from: "4"; to: "second" }
        ListElement { from: "5"; to: "second" }
        ListElement { from: "6"; to: "second" }
        ListElement { from: "7"; to: "second" }
        ListElement { from: "8"; to: "second" }
        ListElement { from: "9"; to: "second" }
        ListElement { from: "10"; to: "second" }
        ListElement { from: "11"; to: "second" }
        ListElement { from: "12"; to: "second" }
        ListElement { from: "13"; to: "second" }
        ListElement { from: "14"; to: "second" }
        ListElement { from: "15"; to: "second" }
        ListElement { from: "16"; to: "second" }
        ListElement { from: "17"; to: "second" }
        ListElement { from: "18"; to: "second" }
        ListElement { from: "19"; to: "second" }
        ListElement { from: "20"; to: "second" }
        ListElement { from: "21"; to: "second" }
        ListElement { from: "22"; to: "second" }
        ListElement { from: "23"; to: "second" }
        ListElement { from: "24"; to: "second" }
        ListElement { from: "25"; to: "second" }
        ListElement { from: "26"; to: "second" }
        ListElement { from: "27"; to: "second" }
        ListElement { from: "28"; to: "second" }
        ListElement { from: "29"; to: "second" }
        ListElement { from: "30"; to: "second" }
        ListElement { from: "31"; to: "second" }
        ListElement { from: "32"; to: "second" }
        ListElement { from: "33"; to: "second" }
        ListElement { from: "34"; to: "second" }
        ListElement { from: "35"; to: "second" }
        ListElement { from: "36"; to: "second" }
        ListElement { from: "37"; to: "second" }

    }
    Label {
        id: title
        text: "Content of the dictionary:"
    }
    ListView {
        id: table
        anchors.top: title.bottom
        y: dialog.padding
        width: dialog.width*2/3
        height: dialog.height-dialog.implicitFooterHeight-dialog.padding*3
        model: wordModel
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
                            text: "original word"
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
                            text: "translation"
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
        }
        Button {
            Layout.alignment: Qt.AlignBottom
            text: qsTr("Delete")
            Layout.fillWidth: true
        }
    }
}