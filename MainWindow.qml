import QtQuick 2.0
import QtQuick.Window 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import custom.managers 1.0 // qml module of the project

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
    SessionManager {
        id: sessionManager
    }

    ProfileSettings {
        id: profilePopup
        visible: false
    }
    DictionarySettings {
        id: dictionaryPopup
        visible: false
    }
    Dialog {
        id: askNumber
        width: parent.width/3
        height: 150
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        visible: false
        modal: true
        standardButtons: Dialog.Ok | Dialog.Cancel
        Label {
            text: qsTr("Number of words in session:")
            anchors.bottom: numberField.top
        }
        TextField {
            id: numberField
            width: parent.width
            placeholderText: qsTr("Input number")
            inputMethodHints: Qt.ImhDigitsOnly
            anchors.bottom: parent.bottom
            validator: IntValidator { bottom: 1 }
        }
        onAccepted: {
            if (numberField.text!="") {
                stateGroup.state = "SessionStarted"
                sessionManager.dictionary = dictionaryManager.currentDictionary
                sessionManager.profile = profileManager.currentProfile
                sessionManager.sessionWordCount = numberField.text
                sessionManager.start()
                // if user learnt all the words
                if (sessionManager.getPoolWordsCount()==0) {
                    stateGroup.state = "Ready"
                    sessionManager.end();
                }
                else {
                    centralLabel.text = sessionManager.currentWord
                    numberField.text = ""
                }
            }
            else
                accepted = false;
        }
    }

    ColumnLayout {
        id: mainLayout
        width: parent.width
        height: parent.height
        // notifications at the top of window
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
                onClicked: askNumber.visible = true
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
        anchors.centerIn: mainLayout
        font.pointSize: 20
        horizontalAlignment: Text.AlignHCenter
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
        property bool isChecking: true
        property bool isDone: false
        onClicked: {
            // quit the session
            if (isDone) {
                stateGroup.state = "Ready"
                isDone = false
                isChecking = true
            }
            // if no words left - print information
            else if ((sessionManager.sessionWordCount<=sessionManager.answeredWordsCount
                    || sessionManager.answeredWordsCount>=dictionaryManager.currentWords.length)
                     &&!isChecking&&answerField.text!="") {
                var vl = sessionManager.end()
                centralLabel.color = "black";
                sessionLine.color = "gray"
                centralLabel.text = qsTr("Congratulations! For this session:\n"+
                                            "- You considered " + vl[0] + " words.\n"+
                                            "- Correct answers: " + vl[1] + ".\n"+
                                            "- Incorrect answers: " + (vl[0]-vl[1]) + ".\n"+
                                            "- Number of days studying: " + vl[2] + ".\n"+
                                            "Words remaining: " + vl[3] + "(" + vl[4].toFixed(2) + "%).")
                answerField.text = ""
                answerField.visible = false
                isDone = true;
            }
            // display the word
            else if (!isChecking) {
                centralLabel.color = "black"
                sessionLine.color = "gray"
                centralLabel.text = sessionManager.currentWord;
                isChecking = true;
                answerField.text = ""
            }
            // if the word is displayed and user input the answer to it - we do the checks
            else if (answerField.text!="") {
                var ans = sessionManager.sendAnswer(answerField.text)
                if (answerField.text === ans) {
                    centralLabel.color = "green"
                    sessionLine.color = "green"
                    centralLabel.text = centralLabel.text + qsTr("\n Right!")
                }
                else {
                    centralLabel.color = "red"
                    sessionLine.color = "red"
                    centralLabel.text = centralLabel.text + qsTr("\n Wrong("+ans+")!")
                }
                isChecking = false;
            }
        }
    }
    //

    // states to change visibilities of some buttons
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
               PropertyChanges { target: profileButton; visible: true }
               PropertyChanges { target: dictionaryButton; visible: true }
               PropertyChanges { target: blueLine; visible: true }
               PropertyChanges { target: inputButton; visible: false }
               PropertyChanges { target: sessionLine; visible: false }
               PropertyChanges { target: centralLabel; visible: false }
               PropertyChanges { target: answerField; visible: false }
               when: profileManager.currentProfile!=="" && dictionaryManager.currentDictionary!==""
            },
            State {
               name: "SessionStarted"
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
