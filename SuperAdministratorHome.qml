import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "tools"

Page {
    id: homePageSuperAdministrator

    StackView.onActivated: function() {
        if (selectedRole.toLowerCase() === "customer") {
            selectedRole = "norole";
        }
    }

    property string pageTitle: "System Control Center"
    property int iconSpacing: 70
    property double iconsLayoutWidthDivisor: 2

    property string selectedRoleIndex

    RowLayout {
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        height: 512

        Label {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: iconSpacing
            color: "#ababab"
            font.pixelSize: 50
            text: qsTr("Choose a task:")
        }

        Item {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width: Math.round(parent.width / iconsLayoutWidthDivisor)

            Image {
                id: subscriptionsIcon
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/assets/icons/subscriptions.png"


                MouseArea {
                    anchors.fill: subscriptionsIcon
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: subscriptionsIconRectangle.opacity = 1.0
                    onExited: subscriptionsIconRectangle.opacity = 0.0
                    onClicked: mainView.push("Subscriptions.qml")
                }
            }

            Image {
                id: salesReportsIcon
                anchors.left: subscriptionsIcon.right
                anchors.leftMargin: iconSpacing
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/assets/icons/sales3.png"


                MouseArea {
                    anchors.fill: salesReportsIcon
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: salesReportsIconRectangle.opacity = 1.0
                    onExited: salesReportsIconRectangle.opacity = 0.0
                    onClicked: notYet.open()
                }
            }

            Image {
                id: systemStatusIcon
                anchors.left: salesReportsIcon.right
                anchors.leftMargin: iconSpacing
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/assets/icons/system3.png"

                MouseArea {
                    anchors.fill: systemStatusIcon
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: systemStatusIconRectangle.opacity = 1.0
                    onExited: systemStatusIconRectangle.opacity = 0.0
                    onClicked: function () {
                        notYet.open();
                    }
                }
            }
        }
    }

    RowLayout {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: 100

        Item {
            width: parent.width / 1.8
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                id: subscriptionsIconRectangle
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width / 2
                height: 70
                color: "transparent"
                border.color: "#e0e0e0"
                opacity: 0.0

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#f3f3f4"
                    text: qsTr("Subscriptions")
                    font.pixelSize: 25
                }
            }

            Rectangle {
                id: salesReportsIconRectangle
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width / 2
                height: 70
                color: "transparent"
                border.color: "#e0e0e0"
                opacity: 0.0

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#f3f3f4"
                    text: qsTr("Financial Reports")
                    font.pixelSize: 25
                }
            }

            Rectangle {
                id: systemStatusIconRectangle
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width / 2
                height: 70
                color: "transparent"
                border.color: "#e0e0e0"
                opacity: 0.0

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#f3f3f4"
                    text: qsTr("Network Status")
                    font.pixelSize: 25
                }
            }
        }
    }

    RowLayout {
        id: switchRoleLayout
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: 10
        anchors.rightMargin: 10
        spacing: 5
        visible: (userRole === "super-administrator")

        Label {
            id: switchRoleLabel
            text: "Switch Role"
        }

        ComboBox {
            id: switchRoleOptions
            implicitWidth: 200
            model: ListModel {
                id: rolesModel

                ListElement { role: "Customer" }
                ListElement { role: "Attendant" }
                ListElement { role: "Manager" }
                ListElement { role: "Administrator" }
                ListElement { role: "Super Administrator" }

            }
            textRole: "role"
            onActivated: function() {
                selectedRole = currentText;
                selectedRoleIndex = currentIndex;

                var homePages = ["CustomerHome.qml", "AttendantHome.qml", "ManagerHome.qml", "AdministratorHome.qml"];

                var selectedUserAccessLevel = currentIndex + 1;
                var currentUserAccessLevel = userAccessLevel;

                if (selectedUserAccessLevel == currentUserAccessLevel) {
                    currentRoleAlreadyActiveDialog.open();
                }  else if (selectedUserAccessLevel > currentUserAccessLevel) {
                    insufficientPrivilegesDialog.open();
                } else if (selectedUserAccessLevel < currentUserAccessLevel) {
                    mainView.push(homePages[selectedRoleIndex]);
                    switchedRoles = true;

                } else {
                    console.log("Nothing else");
                }

                console.log("Role: ", selectedRole, " Index: ", selectedRoleIndex, " User Access Level: ", userAccessLevel);
            }
        }

    }

    Dialog {
        id: currentRoleAlreadyActiveDialog
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        width: Math.round(parent.width / 3)
        parent: ApplicationWindow.overlay

        modal: true
        title: "CURRENT ROLE ALREADY ACTIVE"
        standardButtons: Dialog.Close

        Label {
            text: "Selected role already active. Please choose another."
        }
    }

    Dialog {
        id: insufficientPrivilegesDialog
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        width: Math.round(parent.width / 3)
        parent: ApplicationWindow.overlay

        modal: true
        title: "INSUFFICIENT PRIVILEGES"
        standardButtons: Dialog.Close

        Label {
            text: qsTr("You do not have sufficient privileges to select that role.")
        }
    }
}
