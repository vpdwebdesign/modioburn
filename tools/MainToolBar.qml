import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import "functions.js" as Js

ToolBar {
    id: mainToolBar

    property alias currentPageTitle: toolBarTitle.text

    Material.foreground: "white"

    RowLayout {
        anchors.fill: parent
        spacing: 5

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
            opacity: loggedIn ? 1.0 : 0.0
            enabled: loggedIn
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Notifications (0)")
            onClicked: notYet.open()
        }

        ToolButton {
            id: cart
            contentItem: Image {
                fillMode: Image.Pad
                source: "qrc:/assets/icons/cart.png"
            }
            opacity: loggedIn ? 1.0 : 0.0
            enabled: loggedIn
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Shopping Cart (Empty)")
            onClicked: notYet.open()
        }

        Label {
            id: toolBarTitle
            font.pixelSize: 20
            text: "Modio Burn"
            elide: Label.ElideRight
            horizontalAlignment: Qt.AlignHCenter
            Layout.fillWidth: true

        }

        ToolButton {
            id: timer
            contentItem: Image {
                fillMode: Image.Pad
                source: "qrc:/assets/icons/timer.png"
            }
            opacity: loggedIn ? 1.0 : 0.0
            enabled: loggedIn
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
            opacity: loggedIn ? 1.0 : 0.0
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
                    text: "Logout"
                    onTriggered: logoutDialog.open()
                }
            }
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
