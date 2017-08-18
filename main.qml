import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import "functions.js" as Js

ApplicationWindow {
    id: mainwindow
    visible: true
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    title: qsTr("Modio Burn 1.0")


    property int clientInterfaceSwipeViewIndex

    header: ToolBar {

        Material.foreground: "white"

        RowLayout {
            anchors.fill: parent
            spacing: 5

            ToolButton {
                id: notifications
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "qrc:/assets/icons/notifications.png"
                }

                ToolTip.visible: hovered
                ToolTip.text: qsTr("Notifications (0)")
                onClicked: notyet.open()
            }

            ToolButton {
                id: help
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "qrc:/assets/icons/help.png"
                    anchors.centerIn: parent
                }

                ToolTip.visible: hovered
                ToolTip.text: qsTr("Help")
                onClicked: notyet.open()
            }

            ToolButton {
                id: cart
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "qrc:/assets/icons/cart.png"
                    anchors.centerIn: parent
                }

                ToolTip.visible: hovered
                ToolTip.text: qsTr("Shopping Cart (Empty)")
                onClicked: notyet.open()
            }

            Label {
                id: pagetitle
                font.pixelSize: 30
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }

            Image {
                id: timericon
                source: "qrc:/assets/icons/timer.png"
                anchors.verticalCenter: parent.verticalCenter
                fillMode: Image.Pad
            }

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: [ timertext.text = Js.getTime() + " ",
                    costtext.text = "Ksh " + Js.getCost() + " "]
            }

            Text {
                id: timertext
                color: "white"
                font.pixelSize: 15
                verticalAlignment: Qt.AlignVCenter
            }

            ToolSeparator {}

            Text {
                id: costtext
                color: "white"
                font.pixelSize: 15
                verticalAlignment: Qt.AlignVCenter
            }


            ToolButton {
                id: useraccount
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "qrc:/assets/icons/user.png"
                    anchors.centerIn: parent
                }
                ToolTip.visible: hovered
                ToolTip.text: qsTr("User Account")
                onClicked: useraccountmenu.open()

                Menu {
                    id: useraccountmenu
                    x: parent.width - width
                    y: parent.height
                    transformOrigin: Menu.TopRight

                    MenuItem {
                        text: "Settings"
                        onTriggered: notyet.open()
                    }
                    MenuItem {
                        text: "Logout"
                        onTriggered: logoutdialog.open()
                    }
                }
            }

        }
    }

    StackView {
        id: mainview
        anchors.fill: parent
        initialItem: Home {}
    }

    Dialog {
        id: notyet

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        title: "Functionality Not Yet Available"

        Label {
            text: "This functionality has not yet been built.\nClick anywhere outside this dialog box to continue."
        }
    }

    Dialog {
        id: logoutdialog
        x: Math.round((parent.width - width) / 2)
        y: Math.round(parent.height / 6)
        width: Math.round(parent.width) / 2
        modal: true
        focus: true
        title: "Modio Burn Logout"

        Label {
            text: qsTr("Are you sure you want to logout?")
        }

        standardButtons: Dialog.No | Dialog.Yes
        onAccepted: {
            mainview.replace("qrc:/main.qml")
        }
        onRejected: {
            logoutdialog.close()
        }

        }
}
