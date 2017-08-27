import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "tools"

Page {

    property string pageTitle: qsTr("Music")

    property int delegateHeight: 220
    property int musicRectangleWidth: 160
    property int musicRectangleHeight: delegateHeight - 20
    property string musicRectangleColor: "transparent"
    property real musicRectangleOpacity: 1.0
    property int musicYearRectangleWidth: Math.round(musicRectangleWidth / 1.5)
    property int musicFontSize: 16

    RowLayout {
        id: searchBarRow
        width: parent.width
        height: 80
        SearchBar {
            id: search
            Layout.alignment: Qt.AlignHCenter
            placeHolder: qsTr("Music title, artist, album, category or year")
        }
    }

    Item {
        id: sortBarRow
        width: parent.width
        height: 30
        anchors.top: searchBarRow.bottom
        SortBarMusic {
        }

    }
    ListView {
        id: musicView
        clip: true
        anchors.top: sortBarRow.bottom
        anchors.topMargin: 20
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        model: musicModel
        delegate: musicDelegate
        ScrollBar.vertical: ScrollBar {
            id: musicScrollbar
            active: true
            contentItem: Rectangle {
                implicitWidth: 6
                radius: width / 2
                color: musicScrollbar.pressed ? "#607d8b" : "#a5b7c0"
            }
        }
    }

    ListModel {
        id: musicModel
        ListElement {
            title: qsTr("Paradise")
            artist: qsTr("Coldplay")
            album: qsTr("Mylo Xyloto")
            category: qsTr("Rock, Pop, Dance")
            year: qsTr("2011")
            duration: qsTr("4 minutes 37 seconds")
            thumb: "qrc:/assets/albumart/coldplay_mx.jpg"
            fullimage: qsTr("qrc:/assets/albumart/coldplay_mx.jpg")
        }
        ListElement {
            title: qsTr("Viva La Vida")
            artist: qsTr("Coldplay")
            album: qsTr("Viva La Vida")
            category: qsTr("Rock, Pop, Dance")
            year: qsTr("2008")
            duration: qsTr("4 minutes 1 second")
            thumb: "qrc:/assets/albumart/coldplay_vlv.jpg"
            fullimage: qsTr("qrc:/assets/albumart/coldplay_vlv.jpg")
        }
        ListElement {
            title: qsTr("Wavin' Flag")
            artist: qsTr("K'naan")
            album: qsTr("Troubadour")
            category: qsTr("Pop, Dance")
            year: qsTr("2010")
            duration: qsTr("3 minutes 32 seconds")
            thumb: "qrc:/assets/albumart/knaan.jpg"
            fullimage: qsTr("qrc:/assets/albumart/knaan.jpg")
        }
        ListElement {
            title: qsTr("Your Great Name")
            artist: qsTr("Natalie Grant")
            album: qsTr("Love Revolution")
            category: qsTr("Gospel")
            year: qsTr("2010")
            duration: qsTr("6 minutes 1 second")
            thumb: "qrc:/assets/albumart/nataliegrant.jpg"
            fullimage: qsTr("qrc:/assets/albumart/nataliegrant.jpg")
        }
        ListElement {
            title: qsTr("You Found Me")
            artist: qsTr("The Fray")
            album: qsTr("You Found Me")
            category: qsTr("Rock")
            year: qsTr("2009")
            duration: qsTr("4 minutes 3 seconds")
            thumb: "qrc:/assets/albumart/fray.jpg"
            fullimage: qsTr("qrc:/assets/albumart/fray.jpg")
        }
        ListElement {
            title: qsTr("Broken (New Version)")
            artist: qsTr("Lifehouse")
            album: qsTr("Who We Are")
            category: qsTr("Rock, Pop")
            year: qsTr("2007")
            duration: qsTr("4 minutes 15 seconds")
            thumb: "qrc:/assets/albumart/lifehouse.jpg"
            fullimage: qsTr("qrc:/assets/albumart/lifehouse.jpg")
        }
        ListElement {
            title: qsTr("Forgiven")
            artist: qsTr("Sanctus Real")
            album: qsTr("Pieces of a Real Heart (Deluxe Edition)")
            category: qsTr("Gospel")
            year: qsTr("2010")
            duration: qsTr("3 minutes 35 seconds")
            thumb: "qrc:/assets/albumart/sanctusreal.jpg"
            fullimage: qsTr("qrc:/assets/albumart/sanctusreal.jpg")
        }
    }

    Component {
        id: musicDelegate
        Item {
            width: parent.width
            height: delegateHeight

            Image {
                id: musicThumb
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                source: thumb
            }

            MouseArea {
                anchors.fill: musicThumb
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: notYet.open()
            }


            RowLayout {
                height: parent.height
                anchors.left: musicThumb.right
                anchors.leftMargin: 30
                spacing: 20

                Rectangle {
                    id: titleRectangle
                    width: musicRectangleWidth
                    height: musicRectangleHeight
                    color: musicRectangleColor
                    opacity: musicRectangleOpacity

                    Text {
                        anchors.centerIn: parent
                        color: "#595959"
                        text: title
                        font.pixelSize: musicFontSize
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }

                }

                Rectangle {
                    id: artistRectangle
                    width: musicRectangleWidth
                    height: musicRectangleHeight
                    color: musicRectangleColor
                    opacity: musicRectangleOpacity

                    Text {
                        anchors.centerIn: parent
                        color: "#595959"
                        text: artist
                        font.pixelSize: musicFontSize
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: albumRectangle
                    width: musicRectangleWidth
                    height: musicRectangleHeight
                    color: musicRectangleColor
                    opacity: musicRectangleOpacity

                    Text {
                        anchors.centerIn: parent
                        color: "#595959"
                        text: album
                        font.pixelSize: musicFontSize
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: categoryRectangle
                    width: musicRectangleWidth
                    height: musicRectangleHeight
                    color: musicRectangleColor
                    opacity: musicRectangleOpacity

                    Text {
                        anchors.centerIn: parent
                        color: "#595959"
                        text: category
                        font.pixelSize: musicFontSize
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: yearRectangle
                    width: musicYearRectangleWidth
                    height: musicRectangleHeight
                    color: musicRectangleColor
                    opacity: musicRectangleOpacity

                    Text {
                        anchors.centerIn: parent
                        color: "#595959"
                        text: year
                        font.pixelSize: musicFontSize
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }
                }
            }

            ColumnLayout {
                anchors.right: parent.right
                anchors.rightMargin: 30
                height: delegateHeight

                Label {
                    background: Rectangle {
                              color: "transparent"
                              border.color: "#cccccc"
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#333333"
                    padding: 10
                    text: duration
                    font.pixelSize: musicFontSize
                }

                RowLayout {
                    anchors.horizontalCenter: parent.horizontalCenter
                    Button {
                        text: "Sample"
                        onClicked: notYet.open()
                    }
                    Button {
                        text: "Buy"
                        onClicked: notYet.open()
                    }

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
