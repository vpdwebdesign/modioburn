import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Page {
    ListView {
        anchors.fill: parent
        model: musicmodel
        delegate: musicdelegate
        ScrollBar.vertical: ScrollBar {
            id: musicscrollbar
            active: true
            contentItem: Rectangle {
                implicitWidth: 6
                radius: width / 2
                color: musicscrollbar.pressed ? "#607d8b" : "#a5b7c0"
            }
        }
    }

    ListModel {
        id: musicmodel
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
        id: musicdelegate
        Item {
            width: parent.width
            height: 260

            Image {
                id: musicthumb
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                source: thumb
            }

            MouseArea {
                anchors.fill: musicthumb
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: notyet.open()
            }


            RowLayout {
                id: musictitle
                Layout.fillWidth: true
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.left: musicthumb.right
                anchors.leftMargin: 30
                Label {
                    color: "#595959"
                    text: title
                    font.pixelSize: 30
                }
            }

            RowLayout {
                id: musicartist
                Layout.fillWidth: true
                anchors.top: musictitle.bottom
                anchors.topMargin: 20
                anchors.left: musicthumb.right
                anchors.leftMargin: 30
                Label {
                    color: "#333333"
                    text: qsTr("Artist: ") + artist
                    font.pixelSize: 15
                }
            }

            RowLayout {
                id: musicalbum
                Layout.fillWidth: true
                anchors.top: musicartist.bottom
                anchors.topMargin: 20
                anchors.left: musicthumb.right
                anchors.leftMargin: 30
                Label {
                    color: "#333333"
                    text: qsTr("Album: ") + album
                    font.pixelSize: 15
                }
            }

            RowLayout {
                id: musiccategory
                Layout.fillWidth: true
                anchors.top: musicalbum.bottom
                anchors.topMargin: 20
                anchors.left: musicthumb.right
                anchors.leftMargin: 30
                Label {
                    color: "#333333"
                    text: qsTr("Category: ") + category
                    font.pixelSize: 15
                }
            }

            RowLayout {
                id: musicyear
                Layout.fillWidth: true
                anchors.top: musiccategory.bottom
                anchors.topMargin: 20
                anchors.left: musicthumb.right
                anchors.leftMargin: 30
                Label {
                    color: "#333333"
                    text: qsTr("Year: ") + year
                    font.pixelSize: 15
                }
            }

            RowLayout {
                id: musicduration
                Layout.fillWidth: true
                anchors.right: buttons.left
                anchors.rightMargin: 20
                anchors.verticalCenter: buttons.verticalCenter
                Label {
                    background: Rectangle {
                              color: "transparent"
                              border.color: "#cccccc"
                    }
                    color: "#333333"
                    padding: 10
                    text: qsTr("Duration: ") + duration
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
                      text: "Sample"
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
