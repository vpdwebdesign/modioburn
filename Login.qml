import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Page {
    id: loginWindow

    property string pageTitle: qsTr("Welcome to Modio Burn")

    anchors.fill: parent
    clip: true
    background: Image {
        id: loginBg
        anchors.fill: parent
        source: "qrc:/assets/posters/loginbg.jpg"

    }

    RowLayout {
        id: login
        width: Math.round(parent.width / 2.5)
        height: 500
        anchors.centerIn: parent

        Rectangle {
            anchors.fill: parent
            opacity: 0.9


            RowLayout {
                id: topRow
                width: parent.width
                height: 210
                anchors.top: parent.top
                anchors.topMargin: 10

                Image {
                    id: logo
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "qrc:/assets/icons/logo.png"
                }
            }

            RowLayout {
                id: middleRow
                width: parent.width
                anchors.bottom: usernameRow.top
                anchors.bottomMargin: 20
                height: 40

                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 25
                    color: "#595959"
                    text: "Login"
                }
            }

            RowLayout {
                id: usernameRow
                spacing: 10
                width: parent.width
                height: 50
                anchors.bottom: passwordRow.top
                anchors.bottomMargin: 10

                Label {
                    id: usernameLabel
                    text: "Username"
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                }
                TextField {
                    id: usernameTextField
                    anchors.left: usernameLabel.right
                    anchors.leftMargin: 10
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    Layout.fillWidth: true
                    placeholderText: "Enter your name or phone number"
                }
            }
            RowLayout {
                id: passwordRow
                spacing: 10
                width: parent.width
                height: 50
                anchors.bottom: buttonsRow.top
                anchors.bottomMargin: 10

                Label {
                    id: passwordLabel
                    text: "Password"
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                }
                TextField {
                    id: passwordTextField
                    anchors.left: passwordLabel.right
                    anchors.leftMargin: 10
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    Layout.fillWidth: true
                    echoMode: TextInput.Password
                    placeholderText: "Enter your password"
                }
            }

            RowLayout {
                id: buttonsRow
                width: parent.width
                height: 50
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5

                Button {
                    id: cancelButton
                    text: "Cancel"
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.right: okButton.left
                    anchors.rightMargin: 5
                    Layout.fillWidth: true
                    onClicked: [usernameTextField.clear(), passwordTextField.clear()]
                }

                Button {
                    id: okButton
                    text: "Ok"
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    Layout.fillWidth: true
                    onClicked: {
                        if (usernameTextField.text.length == 0 ||
                            passwordTextField.text.length == 0) {
                            errorDialog.open();
                        }
                        else {
                            loggedIn = true;
                            userName = usernameTextField.text;
                            mainView.goToPage(2);

                            usernameTextField.clear();
                            passwordTextField.clear();
                        }
                    }
                }
            }

        }
    }

    Dialog {
        id: errorDialog
        x: login.x
        y: login.y + login.height - 80
        width: login.width
        modal: true
        focus: true
        title: qsTr("Error!")
        Label {
            text: qsTr("Please enter both your username and password")
        }
        standardButtons: Dialog.Close
    }

    function whoAmI() {
        return qsTr("Message from Login Page")
    }
    // called immediately after push()
    function init() {
        console.log(qsTr("Init done from Login Page"))
    }
    // called immediately after pop()
    function cleanup() {
        console.log(qsTr("Cleanup done from Login Page"))
    }
}

