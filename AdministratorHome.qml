import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "tools"

Page {
    id: homePageAdministrator

    StackView.onActivated: function() {
        if (selectedRole.toLowerCase() === "customer") {
            selectedRole = "norole";
        }
    }

    property string pageTitle: qsTr("Welcome, ") + userName
    property int iconSpacing: 70
    property double iconsLayoutWidthDivisor: 3

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
            text: qsTr("Select a task:")
        }

        Item {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width: Math.round(parent.width / iconsLayoutWidthDivisor)

            Image {
                id: manageManagersIcon
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/assets/icons/manage2.png"


                MouseArea {
                    anchors.fill: manageManagersIcon
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: manageManagersIconRectangle.opacity = 1.0
                    onExited: manageManagersIconRectangle.opacity = 0.0
                    onClicked: mainView.push("ManageManagers.qml")
                }
            }

            Image {
                id: salesIcon
                anchors.left: manageManagersIcon.right
                anchors.leftMargin: iconSpacing
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/assets/icons/sales2.png"


                MouseArea {
                    anchors.fill: salesIcon
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: salesIconRectangle.opacity = 1.0
                    onExited: salesIconRectangle.opacity = 0.0
                    onClicked: mainView.push("SalesReport.qml")
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
                id:manageManagersIconRectangle
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
                    text: qsTr("Manage Managers")
                    font.pixelSize: 25
                }
            }

            Rectangle {
                id: salesIconRectangle
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
                    text: qsTr("Sales Reports")
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
        visible: (userRole === "administrator")

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

                var homePages = ["CustomerHome.qml", "AttendantHome.qml", "ManagerHome.qml"];

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
