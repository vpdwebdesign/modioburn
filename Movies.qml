import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Page {
    ListView {
        anchors.fill: parent
        model: moviesmodel
        delegate: moviesdelegate
        ScrollBar.vertical: ScrollBar {
            id: moviesscrollbar
            active: true
            contentItem: Rectangle {
                implicitWidth: 6
                radius: width / 2
                color: moviesscrollbar.pressed ? "#607d8b" : "#a5b7c0"
            }
        }
    }

    ListModel {
        id: moviesmodel
        ListElement {
            name: qsTr("The Dark Tower")
            star: qsTr("Idris Elba, Matthew McConaughey")
            director: qsTr("Nikolaj Arcel")
            category: qsTr("Horror, Science Fiction")
            year: qsTr("Coming Soon")
            thumb: "qrc:/assets/posters/darktower_thumb.jpg"
            fullimage: qsTr("qrc:/assets/posters/darktower.jpg")
        }
        ListElement {
            name: qsTr("Annabelle 2: Creation")
            star: qsTr("Stephanie Bailman, Talitha Bailman")
            director: qsTr("James Wan")
            category: qsTr("Horror")
            year: qsTr("Coming Soon")
            thumb: "qrc:/assets/posters/annabelle2_thumb.jpg"
            fullimage: qsTr("qrc:/assets/posters/annabelle2.jpg")
        }
        ListElement {
            name: qsTr("The Emoji Movie")
            star: qsTr("Various Voices")
            director: qsTr("John Laseter")
            category: qsTr("Animation, Comedy")
            year: qsTr("2017")
            thumb: "qrc:/assets/posters/emojimovie_thumb.jpg"
            fullimage: qsTr("qrc:/assets/posters/emojimovie.jpg")
        }
        ListElement {
            name: qsTr("Miss Peregrine's Home For Peculiar Children")
            star: qsTr("Mike Higham, Matthew Margeson")
            director: qsTr("Tim Burton")
            category: qsTr("Horror, Science Fiction")
            year: qsTr("2017")
            thumb: "qrc:/assets/posters/mphpc_thumb.jpg"
            fullimage: qsTr("qrc:/assets/posters/mphpc_thumb.jpg")
        }
        ListElement {
            name: qsTr("The Nut Job 2: Nutty By Nature")
            star: qsTr("Various Voices")
            director: qsTr("Henry Goodman")
            category: qsTr("Animation, Comedy")
            year: qsTr("2017")
            thumb: "qrc:/assets/posters/nutjob2_thumb.jpg"
            fullimage: qsTr("qrc:/assets/posters/nutjob2.jpg")
        }
    }

    Component {
        id: moviesdelegate
        Item {
            width: parent.width
            height: 220

            Image {
                id: moviethumb
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                source: thumb
            }

            MouseArea {
                anchors.fill: moviethumb
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: notyet.open()
            }

            RowLayout {
                id: movietitle
                Layout.fillWidth: true
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.left: moviethumb.right
                anchors.leftMargin: 30
                Label {
                    color: "#595959"
                    text: name
                    font.pixelSize: 30
                }
            }

            RowLayout {
                id: moviestars
                Layout.fillWidth: true
                anchors.top: movietitle.bottom
                anchors.topMargin: 20
                anchors.left: moviethumb.right
                anchors.leftMargin: 30
                Label {
                    color: "#333333"
                    text: qsTr("Starring: ") + star
                    font.pixelSize: 15
                }
            }

            RowLayout {
                id: moviedirector
                Layout.fillWidth: true
                anchors.top: moviestars.bottom
                anchors.topMargin: 20
                anchors.left: moviethumb.right
                anchors.leftMargin: 30
                Label {
                    color: "#333333"
                    text: qsTr("Director: ") + director
                    font.pixelSize: 15
                }
            }

            RowLayout {
                id: moviecategory
                Layout.fillWidth: true
                anchors.top: moviedirector.bottom
                anchors.topMargin: 20
                anchors.left: moviethumb.right
                anchors.leftMargin: 30
                Label {
                    color: "#333333"
                    text: qsTr("Category: ") + category
                    font.pixelSize: 15
                }
            }

            RowLayout {
                id: movieyear
                Layout.fillWidth: true
                anchors.top: moviecategory.bottom
                anchors.topMargin: 20
                anchors.left: moviethumb.right
                anchors.leftMargin: 30
                Label {
                    color: "#333333"
                    text: qsTr("Year: ") + year
                    font.pixelSize: 15
                }
            }

            RowLayout {
                id: buttons
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.right: parent.right
                anchors.rightMargin: 40
                  Button {
                      text: "Trailer"
                      onClicked: notyet.open()
                  }
                  Button {
                      text: "Buy"
                      onClicked: notyet.open()
                  }
              }

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 20
                height: 1
                color: "#bfbfbf"
            }
        }

    }
}
