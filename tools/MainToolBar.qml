import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import "functions.js" as Js

ToolBar {
    id: mainToolBar

    property alias currentPageTitle: toolBarTitle.text
    property int totalNotifications: userAccessLevel
    Material.foreground: "white"

    RowLayout {
        anchors.fill: parent
        spacing: 5

        ToolButton {
            id: back
            contentItem: Image {
                fillMode: Image.Pad
                source: "qrc:/assets/icons/back.png"
            }
            visible: loggedIn && (mainView.depth > 2)
            enabled: loggedIn && (mainView.depth > 2)
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Back")
            onClicked: function() {
                away = false;
                mainView.pop();
            }
        }

//        ToolButton {
//            id: home
//            contentItem: Image {
//                fillMode: Image.Pad
//                source: "qrc:/assets/icons/home.png"
//            }
//            visible: loggedIn && switchedRoles
//            enabled: loggedIn && switchedRoles
//            ToolTip.visible: hovered
//            ToolTip.text: qsTr("Home")
//            onClicked: function() {
//                switchedRoles = false;
//                mainView.pop();
//            }
//        }

        ToolButton {
            id: help
            contentItem: Image {
                fillMode: Image.Pad
                source: "qrc:/assets/icons/help.png"
            }
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Help")
            onClicked: helpMenu.open()

            Menu {
                id: helpMenu
                x: parent.width - width
                y: parent.height
                transformOrigin: Menu.TopLeft

                MenuItem {
                    text: "Modio Burn Tutorial"
                    onTriggered: notYet.open()
                }
                MenuItem {
                    text: "About"
                    onTriggered: aboutDialog.open()
                }
            }
        }

        ToolButton {
            id: notifications
            contentItem: Image {
                fillMode: Image.Pad
                source: "qrc:/assets/icons/notifications.png"
            }
            visible: loggedIn
            enabled: loggedIn
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Notifications")
            onClicked: notificationsDialog.open()
        }

        NotificationIcon {
            id: notificationsFlasher
            x: notifications.x + (notifications.width - 10)
            y: notifications.y + Math.round(notifications.height / 3)
            z: 1
            opacity: notifications.enabled ? 1.0 : 0.0
            iconSize: 20
            notificationNum: String(totalNotifications)
        }

        ToolButton {
            id: cart
            contentItem: Image {
                fillMode: Image.Pad
                source: "qrc:/assets/icons/cart.png"
            }
            visible: loggedIn && ((userRole.toLowerCase() === "customer") || (selectedRole.toLowerCase() === "customer"))
            enabled: loggedIn && ((userRole.toLowerCase() === "customer") || (selectedRole.toLowerCase() === "customer"))
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Shopping Cart")
            onClicked: notYet.open()
        }

        ToolButton {
            id: systemStatusButton
            contentItem: Image {
                fillMode: Image.Pad
                source: "qrc:/assets/icons/system2.png"
            }
            visible: loggedIn && (userRole != "customer") && (userRole != "super-administrator")
            enabled: loggedIn && (userRole != "customer") && (userRole != "super-administrator")
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Check system status")
            onClicked: notYet.open()
        }

        Label {
            id: toolBarTitle
            font.pixelSize: 30
            text: "Modio Burn"
            elide: Label.ElideRight
            horizontalAlignment: Qt.AlignHCenter
            Layout.fillWidth: true

        }

        ToolButton {
            id: roleDisplay

            contentItem: Text {
                id: roleDisplayText
                font.pixelSize: 12
                text: userRole.toUpperCase()
                color: "#2e2f30"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 80
                implicitHeight: 20
                radius: 15
                color: "white"
            }

            visible: loggedIn && (userRole != "customer")
            enabled: loggedIn && (userRole != "customer")
        }

        ToolButton {
            id: timer
            contentItem: Image {
                fillMode: Image.Pad
                source: "qrc:/assets/icons/timer.png"
            }
            visible: loggedIn && (userRole == "customer")
            enabled: loggedIn && (userRole == "customer")
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Cost: Ksh ") + Js.getCost()
            onClicked: timerDetails.open()

            Menu {
                id: timerDetails
                x: parent.width - width
                y: parent.height
                transformOrigin: Menu.TopRight

                MenuItem {
                    text: "Elapsed: 00:00"
                    enabled: false
                }

                MenuSeparator {}

                MenuItem {
                    text: "Cost: Ksh 0"
                    enabled: false
                }
            }
        }

        ToolButton {
            id: userAccountButton
            contentItem: Image {
                fillMode: Image.Pad
                source: "qrc:/assets/icons/user.png"
            }
            visible: loggedIn
            enabled: loggedIn
            ToolTip.visible: hovered
            ToolTip.text: qsTr("User Account")
            onClicked: userAccountMenu.open()

            Menu {
                id: userAccountMenu
                x: parent.width - width
                y: parent.height
                transformOrigin: Menu.TopRight

                MenuItem {
                    text: "Settings"
                    onTriggered: notYet.open()
                }
                MenuItem {
                    text: "Logout (" + userName + ")"
                    onTriggered: logoutDialog.open()
                }
            }
        }

        ToolButton {
            id: shutdownButton
            contentItem: Image {
                fillMode: Image.Pad
                source: "qrc:/assets/icons/power.png"
            }
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Shut Down Modio Burn")
            onClicked: function() {
                shutdownDialog.open()
            }

            visible: loggedIn && (userRole != "customer")
            enabled: loggedIn && (userRole != "customer")
        }


        ToolSeparator {
            opacity: loggedIn ? 1.0 : 0.0
        }

        ToolButton {
            id: clock
            anchors.right: parent.right
            anchors.rightMargin: 5

            contentItem: Text {
                id: timerText
                text: ""
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 40
                implicitHeight: 40
                color: "transparent"
                border.color: "#cccccc"
            }

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: timerText.text = Js.getTime()
            }
        }
    }

    Dialog {
        id: notificationsDialog

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: 350
        height: 200
        parent: ApplicationWindow.overlay

        modal: true
        title: "Notifications"
        standardButtons: Dialog.Close

        Row {
            id: upperRow
            width: parent.width
            anchors.top: parent.top
            spacing: 20

            Label {
                font.pixelSize: 15
                text: "You have " + String(totalNotifications) + " new notifications"
                anchors.verticalCenter: parent.verticalCenter
            }

            Button {
                text: "View"
                anchors.verticalCenter: parent.verticalCenter
                enabled: (totalNotifications > 0)
                onClicked: notYet.open()
            }
        }

    }

    Dialog {
        id: aboutDialog
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: 320
        parent: ApplicationWindow.overlay

        modal: true
        title: "Modio Burn Version 1.0"
        standardButtons: Dialog.Close

        Column {
            id: column
            spacing: 20
            width: parent.width

            Image {
                id: logo
                width: parent.width / 2
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                source: "qrc:/assets/icons/logo2.png"
            }

            Label {
                width: parent.width
                text: "Modio Burn is a state of the art Media Management and Accounting tool. "
                    + "The Modio Burn End User License is a two-in-one licensing solution "
                    + "applicable for single-user and multi-user setups. Please read "
                    + "LICENSE.pdf in the setup disc to learn more about the Modio Burn End User License.\n"
                    + "\nModio Burn is a product of KitiSoft Apps, Ltd."
                wrapMode: Label.Wrap
            }
        }
    }
}

