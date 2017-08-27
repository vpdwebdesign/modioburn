import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.XmlListModel 2.0

import "tools"

Page {

    property string pageTitle: qsTr("Series")

    property int delegateHeight: 220
    property int seriesRectangleWidth: 160
    property int seriesRectangleHeight: delegateHeight - 20
    property string seriesRectangleColor: "transparent"
    property real seriesRectangleOpacity: 1.0
    property int seriesYearRectangleWidth: Math.round(seriesRectangleWidth / 1.5)
    property int seriesFontSize: 16

    // For use in displaying episode data for selected series
    property string selectedSeriesTitle
    property string selectedSeriesSeason
    property string selectedSeriesThumb
    property int counter: 0

    RowLayout {
        id: searchBarRow
        width: parent.width
        height: 80
        SearchBar {
            id: search
            Layout.alignment: Qt.AlignHCenter
            placeHolder: qsTr("Series title, season, episode title, stars, category or year")
        }

    }

    Item {
        id: sortBarRow
        width: parent.width
        height: 30
        anchors.top: searchBarRow.bottom
        SortBarSeries {
        }

    }

    ListView {
        id: seriesView
        clip: true
        anchors.top: sortBarRow.bottom
        anchors.topMargin: 20
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        model: seriesModel
        delegate: seriesDelegate
        ScrollBar.vertical: ScrollBar {
            id: seriesScrollbar
            active: true
            contentItem: Rectangle {
                implicitWidth: 10
                radius: width / 2
                color: seriesScrollbar.pressed ? "#607d8b" : "#a5b7c0"
            }
        }
    }

    XmlListModel {
        id: seriesModel
        source: "qrc:/series.xml"
        query: "/data/series"

        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "season"; query: "season/string()" }
        XmlRole { name: "stars"; query: "stars/string()" }
        XmlRole { name: "category"; query: "category/string()" }
        XmlRole { name: "year"; query: "year/string()" }
        XmlRole { name: "thumb"; query: "thumb/string()" }
    }

    Component {
        id: seriesDelegate
        Item {
            width: parent.width
            height: delegateHeight

            Image {
                id: seriesThumb
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                source: thumb
            }

            MouseArea {
                anchors.fill: seriesThumb
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: notYet.open()
            }

            RowLayout {
                height: parent.height
                anchors.left: seriesThumb.right
                anchors.leftMargin: 30
                spacing: 20

                Rectangle {
                    id: titleRectangle
                    width: seriesRectangleWidth
                    height: seriesRectangleHeight
                    color: seriesRectangleColor
                    opacity: seriesRectangleOpacity

                    Text {
                        id: seriesTitle
                        anchors.centerIn: parent
                        color: "#595959"
                        text: title
                        font.pixelSize: seriesFontSize
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }

                }

                Rectangle {
                    id: seasonRectangle
                    width: seriesRectangleWidth
                    height: seriesRectangleHeight
                    color: seriesRectangleColor
                    opacity: seriesRectangleOpacity

                    Text {
                        id: seriesSeason
                        anchors.centerIn: parent
                        color: "#595959"
                        text: season
                        font.pixelSize: seriesFontSize
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: starsRectangle
                    width: seriesRectangleWidth
                    height: seriesRectangleHeight
                    color: seriesRectangleColor
                    opacity: seriesRectangleOpacity

                    Text {
                        anchors.centerIn: parent
                        color: "#595959"
                        text: stars
                        font.pixelSize: seriesFontSize
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: categoryRectangle
                    width: seriesRectangleWidth
                    height: seriesRectangleHeight
                    color: seriesRectangleColor
                    opacity: seriesRectangleOpacity

                    Text {
                        anchors.centerIn: parent
                        color: "#595959"
                        text: category
                        font.pixelSize: seriesFontSize
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: yearRectangle
                    width: seriesYearRectangleWidth
                    height: seriesRectangleHeight
                    color: seriesRectangleColor
                    opacity: seriesRectangleOpacity

                    Text {
                        anchors.centerIn: parent
                        color: "#595959"
                        text: year
                        font.pixelSize: seriesFontSize
                        width: parent.width - 10
                        wrapMode: Text.WordWrap
                    }
                }
            }


            RowLayout {
                id: buttons
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 20
                spacing: 10
                Button {
                    text: "Episodes"
                    onClicked: {
                        selectedSeriesTitle = seriesTitle.text
                        selectedSeriesSeason = seriesSeason.text
                        selectedSeriesThumb = seriesThumb.source
                        episodesDialog.open()

                    }
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

    // Fetch episodes data
    Dialog {
        id: episodesDialog
        x: parent.x + 50
        y: parent.y + 50
        width: parent.width - 100
        height: parent.height - 50
        modal: true
        standardButtons: Dialog.Close

        RowLayout {
            id: seriesDataRow
            width: parent.width

            Image {
                id: seriesImageData
                source: selectedSeriesThumb
                anchors.left: parent.left
                anchors.leftMargin: 50
                anchors.verticalCenter: parent.verticalCenter
            }

            Label {
                id: seriesTitle_
                font.pixelSize: 30
                text: selectedSeriesTitle
                anchors.left: seriesImageData.right
                anchors.leftMargin: 20
                anchors.top: parent.top
            }

            Label {
                id: seriesSeason_
                font.pixelSize: 25
                text: "Season " + selectedSeriesSeason + " episodes"
                anchors.top: seriesTitle_.bottom
                anchors.topMargin: 20
                anchors.left: seriesImageData.right
                anchors.leftMargin: 20
            }

        }

        RowLayout {
            id: episodesViewTopBar
            width: parent.width
            anchors.top: seriesDataRow.bottom
            anchors.topMargin: 20

            Rectangle {
                id: episodeNumberColumn
                width: 100
                height: 30
                anchors.left: parent.left
                color: "teal"

                Text {
                    text: qsTr("#")
                    font.pixelSize: 15
                    color: "white"
                    anchors.centerIn: parent
                }
            }

            Rectangle {
                id: episodeTitleColumn
                width: 600
                height: 30
                anchors.left: episodeNumberColumn.right
                anchors.leftMargin: 10
                color: "teal"

                Text {
                    text: qsTr("Title")
                    font.pixelSize: 15
                    color: "white"
                    anchors.centerIn: parent
                }
            }

            Rectangle {
                id: episodeYearColumn
                width: 200
                height: 30
                anchors.left: episodeTitleColumn.right
                anchors.leftMargin: 10
                color: "teal"

                Text {
                    text: qsTr("Aired Date")
                    font.pixelSize: 15
                    color: "white"
                    anchors.centerIn: parent
                }
            }
        }

        ListView {
            id: episodesView
            anchors.top: episodesViewTopBar.bottom
            anchors.topMargin: 20
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            clip: true
            model: episodesModel
            delegate: episodesDelegate
            ScrollBar.vertical: ScrollBar {
                id: episodesScrollbar
                active: true
                contentItem: Rectangle {
                    implicitWidth: 10
                    radius: width / 2
                    color: episodesScrollbar.pressed ? "#607d8b" : "#a5b7c0"
                }
            }
        }

        XmlListModel {
            id: episodesModel
            source: "qrc:/series.xml"
            query: "/data/series[title='" + selectedSeriesTitle + "']/episode"

            XmlRole { name: "number"; query: "number/string()" }
            XmlRole { name: "title"; query: "title/string()" }
            XmlRole { name: "year"; query: "year/string()" }
        }

        Component {
            id: episodesDelegate

            Item {
                width: parent.width
                height: 70

                RowLayout {
                    anchors.fill: parent

                    Rectangle {
                        id: episodeNumberRectangle
                        width: 100
                        height: 70

                        Text {
                            id: episodeNumber
                            anchors.centerIn: parent
                            color: "#595959"
                            text: number
                            font.pixelSize: 20
                            width: parent.width - 10
                        }

                    }

                    Rectangle {
                        id: episodeTitleRectangle
                        width: 600
                        height: 70

                        Text {
                            id: episodeTitle
                            anchors.centerIn: parent
                            color: "#595959"
                            text: title
                            font.pixelSize: 20
                            width: parent.width - 10
                        }

                    }

                    Rectangle {
                        id: episodeYearRectangle
                        width: 200
                        height: 70

                        Text {
                            id: episodeYear
                            anchors.centerIn: parent
                            color: "#595959"
                            text: year
                            font.pixelSize: 20
                            width: parent.width - 10
                        }

                    }

                    RowLayout {
                        id: seriesButtons
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 40
                        spacing: 10
                          Button {
                              text: "Watch"
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
                    opacity: 0.5
                }
            }
        }

    }
}
