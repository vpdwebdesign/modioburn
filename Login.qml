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
            color: "#2e2f30"
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
                    color: "#e0e0e0"
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
                    selectByMouse: true
                    focus: true
                    onAccepted: passwordTextField.focus = true
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
                    selectByMouse: true
                    onAccepted: function() {
                        var enteredName = (usernameTextField.text).toLowerCase();
                        var enteredPassword = passwordTextField.text;

                        if (enteredName.length > 0 && enteredPassword.length > 0) {
                            if (mbUsers.hasOwnProperty(enteredName) && mbUsers[enteredName].pwd === enteredPassword) {
                                userName = usernameTextField.text;
                                userRole = mbUsers[enteredName].role;
                                userAccessLevel = mbUsers[enteredName].accesslevel;
                                loggedIn = true;
                                usernameTextField.clear();
                                passwordTextField.clear();

                                if (userRole === "customer") {
                                    mainView.push("CustomerHome.qml");
                                } else if (userRole === "attendant") {
                                    mainView.push("AttendantHome.qml");
                                } else if (userRole === "manager") {
                                    mainView.push("ManagerHome.qml");
                                } else if (userRole === "administrator") {
                                    mainView.push("AdministratorHome.qml");
                                } else if (userRole === "super-administrator") {
                                    mainView.push("SuperAdministratorHome.qml");
                                } else {
                                    loggedIn = false;
                                    noSuchRoleDialog.open();
                                    mainView.push(null);
                                }
                            } else {
                                noSuchUserDialog.open();
                                loggedIn = false;
                            }
                        } else {
                            emptyFieldsDialog.open();
                            loggedIn = false;
                        }
                    }
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
                    onClicked: function() {
                        usernameTextField.clear();
                        passwordTextField.clear();
                        usernameTextField.focus = true;
                    }
                }

                Button {
                    id: okButton
                    text: "Ok"
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    Layout.fillWidth: true
                    onClicked: function() {
                        var enteredName = (usernameTextField.text).toLowerCase();
                        var enteredPassword = passwordTextField.text;

                        if (enteredName.length > 0 && enteredPassword.length > 0) {
                            if (mbUsers.hasOwnProperty(enteredName) && mbUsers[enteredName].pwd === enteredPassword) {
                                userName = usernameTextField.text;
                                userRole = mbUsers[enteredName].role;
                                userAccessLevel = mbUsers[enteredName].accesslevel;
                                loggedIn = true;
                                usernameTextField.clear();
                                passwordTextField.clear();

                                if (userRole == "customer") {
                                    mainView.push("CustomerHome.qml");
                                } else if (userRole == "attendant") {
                                    mainView.push("AttendantHome.qml");
                                } else if (userRole == "manager") {
                                    mainView.push("ManagerHome.qml");
                                } else if (userRole == "administrator") {
                                    mainView.push("AdministratorHome.qml");
                                } else {
                                    loggedIn = false;
                                    noSuchRoleDialog.open();
                                    mainView.push(null);
                                }
                            } else {
                                noSuchUserDialog.open();
                                loggedIn = false;

                            }
                        } else {
                            emptyFieldsDialog.open();
                            loggedIn = false;
                        }
                    }
                }
            }

        }
    }


    Dialog {
        id: emptyFieldsDialog
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

    Dialog {
        id: noSuchRoleDialog
        x: login.x
        y: login.y + login.height - 80
        width: login.width
        modal: true
        focus: true
        title: qsTr("Error!")
        Label {
            text: qsTr("Only customers, attendants, managers and administrators accepted for now.")
        }
        standardButtons: Dialog.Close
    }

    Dialog {
        id: noSuchUserDialog
        x: login.x
        y: login.y + login.height - 80
        width: login.width
        modal: true
        focus: true
        title: qsTr("Error!")
        Label {
            text: qsTr("Wrong credentials entered. Please try again.")
        }
        standardButtons: Dialog.Close
    }
}

