import QtQuick 2.9
import QtMultimedia 5.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

import "tools"

Page {

    Material.theme: Material.Light

    property string pageTitle: qsTr("Music")

    property int delegateHeight: 220
    property int musicRectangleWidth: 150
    property int musicRectangleHeight: delegateHeight - 20
    property string musicRectangleColor: "transparent"
    property real musicRectangleOpacity: 1.0
    property int musicYearRectangleWidth: Math.round(musicRectangleWidth / 1.5)
    property int musicFontSize: 16

    property string musicToPlayUrl
    property string musicAlbumArtUrl
    property string musicTitle
    property string musicAlbum
    property string musicCategory
    property string musicReleaseYear
    property string musicPlayStatus

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
            url: "file:/home/vpd/projects/qt/modioburn/assets/music/paradise.m4a"
        }
        ListElement {
            title: qsTr("Viva La Vida")
            artist: qsTr("Coldplay")
            album: qsTr("Viva La Vida")
            category: qsTr("Rock, Pop, Dance")
            year: qsTr("2008")
            duration: qsTr("4 minutes 1 second")
            thumb: "qrc:/assets/albumart/coldplay_vlv.jpg"
            url: "file:/home/vpd/projects/qt/modioburn/assets/music/viva la vida.m4a"
        }
        ListElement {
            title: qsTr("Wavin' Flag")
            artist: qsTr("K'naan")
            album: qsTr("Troubadour")
            category: qsTr("Pop, Dance")
            year: qsTr("2010")
            duration: qsTr("3 minutes 32 seconds")
            thumb: "qrc:/assets/albumart/knaan.jpg"
            url: "file:/home/vpd/projects/qt/modioburn/assets/music/wavin' flag.m4a"
        }
        ListElement {
            title: qsTr("Your Great Name")
            artist: qsTr("Natalie Grant")
            album: qsTr("Love Revolution")
            category: qsTr("Gospel")
            year: qsTr("2010")
            duration: qsTr("6 minutes 1 second")
            thumb: "qrc:/assets/albumart/nataliegrant.jpg"
            url: "file:/home/vpd/projects/qt/modioburn/assets/music/your great name.m4a"
        }
        ListElement {
            title: qsTr("You Found Me")
            artist: qsTr("The Fray")
            album: qsTr("You Found Me")
            category: qsTr("Rock")
            year: qsTr("2009")
            duration: qsTr("4 minutes 3 seconds")
            thumb: "qrc:/assets/albumart/fray.jpg"
            url: "file:/home/vpd/projects/qt/modioburn/assets/music/you found me.m4a"
        }
        ListElement {
            title: qsTr("Broken (New Version)")
            artist: qsTr("Lifehouse")
            album: qsTr("Who We Are")
            category: qsTr("Rock, Pop")
            year: qsTr("2007")
            duration: qsTr("4 minutes 15 seconds")
            thumb: "qrc:/assets/albumart/lifehouse.jpg"
            url: "file:/home/vpd/projects/qt/modioburn/assets/music/broken.m4a"
        }
        ListElement {
            title: qsTr("Forgiven")
            artist: qsTr("Sanctus Real")
            album: qsTr("Pieces of a Real Heart (Deluxe Edition)")
            category: qsTr("Gospel")
            year: qsTr("2010")
            duration: qsTr("3 minutes 35 seconds")
            thumb: "qrc:/assets/albumart/sanctusreal.jpg"
            url: "file:/home/vpd/projects/qt/modioburn/assets/music/forgiven.m4a"
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
                        text: "Play"
                        onClicked: function() {
                            musicAlbumArtUrl = thumb;
                            musicToPlayUrl = url;
                            musicTitle = title;
                            musicAlbum = album;
                            musicCategory = category;
                            musicReleaseYear = year;

                            musicPlayerDialog.open();
                        }
                    }
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

    Dialog {
        id: musicPlayerDialog
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        width: 640
        height: 400
        header: RowLayout {
            width: parent.width
            height: 40
            Label {
                id: musicPlayerTitle
                anchors.centerIn: parent
                Layout.fillWidth: true
                font.pixelSize: 20
                color: "#c5c5c5"
                text: "Modio Burn Audio Player"
            }

            Button {
                anchors.right: parent.right
                anchors.rightMargin: 20
                text: "Exit"
                onClicked: musicPlayerDialog.close()
            }

        }

        RowLayout {
            anchors.fill: parent
            Item {
                width: parent.width - 20
                height: parent.height - 20
                anchors.centerIn: parent

                Image {
                    id: musicAlbumArt
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    source: musicAlbumArtUrl
                    fillMode: Image.Pad
                }

                ColumnLayout {
                    height: musicAlbumArt.implicitHeight
                    width: parent.width - musicAlbumArt.implicitWidth
                    anchors.left: musicAlbumArt.right
                    anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter

                    Label {
                        font.pixelSize: 20
                        text: "\" " + musicTitle + " \""
                    }

                    Label {
                        text: "Album: " + musicAlbum
                    }

                    Label {
                        text: "Genre: " + musicCategory
                    }

                    Label {
                        text: "Released: " + musicReleaseYear
                    }

                    Label {
                        font.pixelSize: 17
                        color: musicPlayStatus.toLowerCase() === "playing" ? "#a7e3ef" : "orange"
                        text: "Status: " + musicPlayStatus
                    }
                }

                ProgressBar {
                    width: parent.width - 20
                    height: 10
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 30
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    value: musicPlayer.position / musicPlayer.duration
                }
            }
        }

        footer: RowLayout {
            width: parent.width
            height: 80
            Rectangle {
                width: Math.round(parent.width / 2)
                height: parent.height - 20
                radius: 40.0
                color: "transparent"
                border.color: "#c5c5c5"
                anchors.centerIn: parent


                Item {
                    height: 40
                    width: 230
                    anchors.centerIn: parent

                    Image {
                        id: rewindButton
                        anchors.left: parent.left
                        source: "qrc:/assets/icons/media/rewind.png"
                        fillMode: Image.Pad
                        opacity: 0.5

                        MouseArea {
                            id: rewindButtonMouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: rewindButton.opacity = 1.0
                            onExited: rewindButton.opacity = 0.5
                            onClicked: musicPlayer.seek(musicPlayer.position - 5000)
                        }
                    }

                    Image {
                        id: playPauseButton
                        anchors.left: rewindButton.right
                        anchors.leftMargin: 20
                        source: musicPlayer.playbackState == Audio.PlayingState ? "qrc:/assets/icons/media/pause.png" : "qrc:/assets/icons/media/play.png"
                        fillMode: Image.Pad
                        opacity: 0.5

                        MouseArea {
                            id: playPauseButtonMouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: playPauseButton.opacity = 1.0
                            onExited: playPauseButton.opacity = 0.5
                            onClicked: function() {
                                if (musicPlayer.playbackState == Audio.PlayingState) {
                                    musicPlayer.pause();
                                     musicPlayStatus = "Paused";
                                } else {
                                     musicPlayer.play();
                                     musicPlayStatus = "Playing";
                                }
                           }
                        }
                    }

                    Image {
                        id: stopButton
                        anchors.left: playPauseButton.right
                        anchors.leftMargin: 20
                        source: "qrc:/assets/icons/media/stop.png"
                        fillMode: Image.Pad
                        opacity: 0.5

                        MouseArea {
                            id: stopButtonMouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: stopButton.opacity = 1.0
                            onExited: stopButton.opacity = 0.5
                            onClicked: function() {
                                musicPlayer.stop();
                                musicPlayStatus = "Stopped";
                           }
                        }
                    }

                    Image {
                        id: fastForwadButton
                        anchors.left: stopButton.right
                        anchors.leftMargin: 20
                        source: "qrc:/assets/icons/media/fastforward.png"
                        fillMode: Image.Pad
                        opacity: 0.5

                        MouseArea {
                            id: fastForwardButtonMouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: fastForwadButton.opacity = 1.0
                            onExited: fastForwadButton.opacity = 0.5
                            onClicked: musicPlayer.seek(musicPlayer.position + 5000)
                        }
                    }
                }
            }
        }

        onOpened: function() {
            musicPlayer.play();
            if (musicPlayer.playbackState == Audio.PlayingState) {
                musicPlayStatus = "Playing";
            } else if (musicPlayer.playbackState == Audio.PausedState) {
                musicPlayStatus = "Paused";
            } else {
                musicPlayStatus = "Unknown";
            }
        }

        onClosed: function() {
            musicPlayer.stop();
            musicPlayStatus = "Stopped";
            }

        Audio {
            id: musicPlayer
            source: musicToPlayUrl
        }
    }
}
