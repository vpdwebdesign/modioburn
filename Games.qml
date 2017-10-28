import QtQuick 2.9
import QtMultimedia 5.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2
import "tools"

Page {

    Material.theme: Material.Light

    property string pageTitle: qsTr("Games")

    property int delegateHeight: 220
    property int gameRectangleWidth: 160
    property int gameRectangleHeight: delegateHeight - 20
    property string gameRectangleColor: "transparent"
    property real gameRectangleOpacity: 1.0
    property int gameYearRectangleWidth: Math.round(gameRectangleWidth / 1.5)
    property int gameFontSize: 16

    RowLayout {
        id: searchBarRow
        width: parent.width
        height: 80
        SearchBar {
            id: search
            Layout.alignment: Qt.AlignHCenter
            placeHolder: qsTr("Game title, developer, category, release year")
        }

    }

    Item {
        id: sortBarRow
        width: parent.width
        height: 30
        anchors.top: searchBarRow.bottom
        SortBarGames {
        }

    }

    ListView {
        id:gamesView
        clip: true
        anchors.top: sortBarRow.bottom
        anchors.topMargin: 20
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        model:gamesModel
        delegate:gamesDelegate
        ScrollBar.vertical: ScrollBar {
            id:gamesScrollbar
            active: true
            contentItem: Rectangle {
                implicitWidth: 10
                radius: width / 2
                color:gamesScrollbar.pressed ? "#607d8b" : "#a5b7c0"
            }
        }
    }

    ListModel {
        id:gamesModel
        ListElement {
            title: qsTr("Grand Theft Auto V")
            developer: qsTr("Rockstar North")
            publisher: qsTr("Rockstar Games")
            category: qsTr("Action, Adventure")
            year: qsTr("2015")
            thumb: "qrc:/assets/posters/games/gta-v.jpg"
        }
        ListElement {
            title: qsTr("Need For Speed - Most Wanted")
            developer: qsTr("EA Black Box")
            publisher: qsTr("Electronic Arts")
            category: qsTr("Racing, Action")
            year: qsTr("2005")
            thumb: "qrc:/assets/posters/games/nfs-mw.jpg"
        }
        ListElement {
            title: qsTr("Call of Duty - Black Ops")
            developer: qsTr("Treyarch")
            publisher: qsTr("Activision")
            category: qsTr("First Person Shooter, Action")
            year: qsTr("2010")
            thumb: "qrc:/assets/posters/games/cod-blackops.png"
        }
        ListElement {
            title: qsTr("Doom 3")
            developer: qsTr("id Software")
            publisher: qsTr("Activision")
            category: qsTr("First Person Shooter, Horror")
            year: qsTr("2004")
            thumb: "qrc:/assets/posters/games/doom3.jpg"
        }
        ListElement {
            title: qsTr("Prey")
            developer: qsTr("Human Head Studios")
            publisher: qsTr("2K Games")
            category: qsTr("First Person Shooter, Horror")
            year: qsTr("2006")
            thumb: "qrc:/assets/posters/games/prey.jpg"
        }
    }

    Component {
        id:gamesDelegate
        Item {
            width: parent.width
            height: delegateHeight

            Image {
                id: gameThumb
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                source: thumb
            }

            MouseArea {
                anchors.fill: gameThumb
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: notYet.open()
            }

            RowLayout {
                height: parent.height
                anchors.left: gameThumb.right
                anchors.leftMargin: 30
                spacing: 20

                Rectangle {
                    id: titleRectangle
                    width: gameRectangleWidth
                    height: gameRectangleHeight
                    color: gameRectangleColor
                    opacity: gameRectangleOpacity

                    Text {
                        anchors.centerIn: parent
                        color: "#595959"
                        text: title
                        font.pixelSize: gameFontSize
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }

                }

                Rectangle {
                    id: developerRectangle
                    width: gameRectangleWidth
                    height: gameRectangleHeight
                    color: gameRectangleColor
                    opacity: gameRectangleOpacity

                    Text {
                        anchors.centerIn: parent
                        color: "#595959"
                        text: developer
                        font.pixelSize: gameFontSize
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: publisherRectangle
                    width: gameRectangleWidth
                    height: gameRectangleHeight
                    color: gameRectangleColor
                    opacity: gameRectangleOpacity

                    Text {
                        anchors.centerIn: parent
                        color: "#595959"
                        text: publisher
                        font.pixelSize: gameFontSize
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: categoryRectangle
                    width: gameRectangleWidth
                    height: gameRectangleHeight
                    color: gameRectangleColor
                    opacity: gameRectangleOpacity

                    Text {
                        anchors.centerIn: parent
                        color: "#595959"
                        text: category
                        font.pixelSize: gameFontSize
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: yearRectangle
                    width: gameYearRectangleWidth
                    height: gameRectangleHeight
                    color: gameRectangleColor
                    opacity: gameRectangleOpacity

                    Text {
                        anchors.centerIn: parent
                        color: "#595959"
                        text: year
                        font.pixelSize: gameFontSize
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }
                }
            }


            RowLayout {
                id: buttons
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 40
                spacing: 10
                Button {
                    text: "Play"
                    onClicked: notYet.open()
                }
                  Button {
                      text: "Trailer"
                      onClicked: notYet.open()
                  }
                  Button {
                      text: "Buy"
                      onClicked: notYet.open()
                  }
              }

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 20
                height: 1
                color: "#bfbfbf"
                opacity: 0.5
            }
        }
    }
}
