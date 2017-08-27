import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "tools"

Page {

    property string pageTitle: qsTr("Movies")

    property int delegateHeight: 220
    property int movieRectangleWidth: 170
    property int movieRectangleHeight: delegateHeight - 20
    property string movieRectangleColor: "transparent"
    property real movieRectangleOpacity: 1.0
    property int movieYearRectangleWidth: Math.round(movieRectangleWidth / 1.5)
    property int movieFontSize: 16

    RowLayout {
        id: searchBarRow
        width: parent.width
        height: 80
        SearchBar {
            id: search
            Layout.alignment: Qt.AlignHCenter
            placeHolder: qsTr("Movie title, star, director, category or year")
        }

    }

    Item {
        id: sortBarRow
        width: parent.width
        height: 30
        anchors.top: searchBarRow.bottom
        SortBarMovies {
        }

    }

    ListView {
        id: moviesView
        clip: true
        anchors.top: sortBarRow.bottom
        anchors.topMargin: 20
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        model: moviesModel
        delegate: moviesDelegate
        ScrollBar.vertical: ScrollBar {
            id: moviesScrollbar
            active: true
            contentItem: Rectangle {
                implicitWidth: 10
                radius: width / 2
                color: moviesScrollbar.pressed ? "#607d8b" : "#a5b7c0"
            }
        }
    }

    ListModel {
        id: moviesModel
        ListElement {
            title: qsTr("The Dark Tower")
            star: qsTr("Idris Elba, Matthew McConaughey")
            director: qsTr("Nikolaj Arcel")
            category: qsTr("Horror, Science Fiction")
            year: qsTr("2017")
            thumb: "qrc:/assets/posters/darktower_thumb.jpg"
            fullimage: qsTr("qrc:/assets/posters/darktower.jpg")
        }
        ListElement {
            title: qsTr("Annabelle 2: Creation")
            star: qsTr("Stephanie Bailman, Talitha Bailman")
            director: qsTr("James Wan")
            category: qsTr("Horror")
            year: qsTr("Coming Soon")
            thumb: "qrc:/assets/posters/annabelle2_thumb.jpg"
            fullimage: qsTr("qrc:/assets/posters/annabelle2.jpg")
        }
        ListElement {
            title: qsTr("The Emoji Movie")
            star: qsTr("Various Voices")
            director: qsTr("John Laseter")
            category: qsTr("Animation, Comedy")
            year: qsTr("2017")
            thumb: "qrc:/assets/posters/emojimovie_thumb.jpg"
            fullimage: qsTr("qrc:/assets/posters/emojimovie.jpg")
        }
        ListElement {
            title: qsTr("Miss Peregrine's Home For Peculiar Children")
            star: qsTr("Mike Higham, Matthew Margeson")
            director: qsTr("Tim Burton")
            category: qsTr("Horror, Science Fiction")
            year: qsTr("2017")
            thumb: "qrc:/assets/posters/mphpc_thumb.jpg"
            fullimage: qsTr("qrc:/assets/posters/mphpc_thumb.jpg")
        }
        ListElement {
            title: qsTr("The Nut Job 2: Nutty By Nature")
            star: qsTr("Various Voices")
            director: qsTr("Henry Goodman")
            category: qsTr("Animation, Comedy")
            year: qsTr("2017")
            thumb: "qrc:/assets/posters/nutjob2_thumb.jpg"
            fullimage: qsTr("qrc:/assets/posters/nutjob2.jpg")
        }
    }

    Component {
        id: moviesDelegate
        Item {
            width: parent.width
            height: delegateHeight

            Image {
                id: movieThumb
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                source: thumb
            }

            MouseArea {
                anchors.fill: movieThumb
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: notYet.open()
            }

            RowLayout {
                height: parent.height
                anchors.left: movieThumb.right
                anchors.leftMargin: 30
                spacing: 20

                Rectangle {
                    id: titleRectangle
                    width: movieRectangleWidth
                    height: movieRectangleHeight
                    color: movieRectangleColor
                    opacity: movieRectangleOpacity

                    Text {
                        anchors.centerIn: parent
                        color: "#595959"
                        text: title
                        font.pixelSize: movieFontSize
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }

                }

                Rectangle {
                    id: starsRectangle
                    width: movieRectangleWidth
                    height: movieRectangleHeight
                    color: movieRectangleColor
                    opacity: movieRectangleOpacity

                    Text {
                        anchors.centerIn: parent
                        color: "#595959"
                        text: star
                        font.pixelSize: movieFontSize
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: directorRectangle
                    width: movieRectangleWidth
                    height: movieRectangleHeight
                    color: movieRectangleColor
                    opacity: movieRectangleOpacity

                    Text {
                        anchors.centerIn: parent
                        color: "#595959"
                        text: director
                        font.pixelSize: movieFontSize
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: categoryRectangle
                    width: movieRectangleWidth
                    height: movieRectangleHeight
                    color: movieRectangleColor
                    opacity: movieRectangleOpacity

                    Text {
                        anchors.centerIn: parent
                        color: "#595959"
                        text: category
                        font.pixelSize: movieFontSize
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: yearRectangle
                    width: movieYearRectangleWidth
                    height: movieRectangleHeight
                    color: movieRectangleColor
                    opacity: movieRectangleOpacity

                    Text {
                        anchors.centerIn: parent
                        color: "#595959"
                        text: year
                        font.pixelSize: movieFontSize
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
