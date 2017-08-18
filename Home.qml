import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Page {
    id: homepage

    RowLayout {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: 512

        Label {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 100
            color: "#ababab"
            font.pixelSize: 50
            text: qsTr("Hi,\nWhat would you like to do today?")
        }

        Item {
            width: parent.width / 1.8
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Image {
                id: moviesicon
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/assets/icons/movies_.png"
            }

            MouseArea {
                id: moviesiconmousearea
                anchors.fill: moviesicon
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: moviesiconrectangle.opacity = 1.0
                onExited: moviesiconrectangle.opacity = 0.0
                onClicked: [ clientInterfaceSwipeViewIndex = 0,
                    mainview.replace("qrc:/Client.qml"), pagetitle.text = qsTr("Movies") ]
            }

            Image {
                id: musicicon
                anchors.left: moviesicon.right
                anchors.leftMargin: width
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/assets/icons/music_.png"
            }

            MouseArea {
                anchors.fill: musicicon
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: musiciconrectangle.opacity = 1.0
                onExited: musiciconrectangle.opacity = 0.0
                onClicked: [ clientInterfaceSwipeViewIndex = 1,
                    mainview.replace("qrc:/Client.qml"), pagetitle.text = qsTr("Music") ]
            }

            Image {
                id: gamesicon
                anchors.left: musicicon.right
                anchors.leftMargin: width
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/assets/icons/games_.png"
            }

            MouseArea {
                anchors.fill: gamesicon
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: gamesiconrectangle.opacity = 1.0
                onExited: gamesiconrectangle.opacity = 0.0
                onClicked: [ clientInterfaceSwipeViewIndex = 2,
                    mainview.replace("qrc:/Client.qml"), pagetitle.text = qsTr("Games") ]
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
                id: moviesiconrectangle
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width / 2
                height: 70
                color: "transparent"
                border.color: "#ababab"
                opacity: 0.0

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Watch a movie")
                    font.pixelSize: 25
                }
            }

            Rectangle {
                id: musiciconrectangle
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width / 2
                height: 70
                color: "transparent"
                border.color: "#ababab"
                opacity: 0.0

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Listen to music")
                    font.pixelSize: 25
                }
            }

            Rectangle {
                id: gamesiconrectangle
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width / 2
                height: 70
                color: "transparent"
                border.color: "#ababab"
                opacity: 0.0

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Play a game")
                    font.pixelSize: 25
                }
            }

        }

    }

    Dialog {
        id: logindialog

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: parent.width / 2
        parent: ApplicationWindow.overlay

        focus: true
        modal: true
        title: "Modio Burn Login"
        standardButtons: Dialog.Ok | Dialog.Cancel

        ColumnLayout {
            spacing: 20
            anchors.fill: parent
            Label {
                elide: Label.ElideRight
                text: "Please enter your credentials"
                Layout.fillWidth: true
            }
            TextField {
                id: username
                focus: true
                placeholderText: "Username"
                Layout.fillWidth: true
            }
            TextField {
                id: password
                placeholderText: "Password"
                echoMode: TextInput.Password
                Layout.fillWidth: true
            }
        }
    }

    Component.onCompleted: [ pagetitle.text = qsTr("Welcome"), logindialog.open() ]
}
