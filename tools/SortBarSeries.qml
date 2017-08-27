import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {

    height: parent.height
    anchors.left: parent.left
    anchors.leftMargin: 185
    spacing: 20

    property int rectangleWidth: 160
    property int rectangleHeight: parent.height
    property int yearRectangleWidth: Math.round(rectangleWidth / 1.5)
    property string rectangleColor: "#607d8b"

    Rectangle {
        id: sortByTitle
        width: rectangleWidth
        height: rectangleHeight
        color: rectangleColor

        Text {
            id: sortByTitleText
            text: qsTr("Title")
            font.pixelSize: 15
            color: "white"
            anchors.centerIn: parent
        }

        Image {
            id: sortByTitleButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            source: "qrc:/assets/icons/sort_down.png"
        }

        MouseArea {
            anchors.fill: sortByTitleButton
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (sortByTitleButton.source == "qrc:/assets/icons/sort_down.png") {
                    sortByTitleButton.source = "qrc:/assets/icons/sort_up.png"
                } else {
                    sortByTitleButton.source = "qrc:/assets/icons/sort_down.png"
                }
            }
        }
    }

    Rectangle {
        id: sortBySeason
        width: rectangleWidth
        height: rectangleHeight
        color: rectangleColor

        Text {
            text: qsTr("Season")
            font.pixelSize: 15
            color: "white"
            anchors.centerIn: parent
        }

        Image {
            id: sortBySeasonButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            source: "qrc:/assets/icons/sort_down.png"
        }

        MouseArea {
            anchors.fill: sortBySeasonButton
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (sortBySeasonButton.source == "qrc:/assets/icons/sort_down.png") {
                    sortBySeasonButton.source = "qrc:/assets/icons/sort_up.png"
                } else {
                    sortBySeasonButton.source = "qrc:/assets/icons/sort_down.png"
                }
            }
        }
    }

    Rectangle {
        id: sortByStars
        width: rectangleWidth
        height: rectangleHeight
        color: rectangleColor

        Text {
            text: qsTr("Stars")
            font.pixelSize: 15
            color: "white"
            anchors.centerIn: parent
        }

        Image {
            id: sortByStarsButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            source: "qrc:/assets/icons/sort_down.png"
        }

        MouseArea {
            anchors.fill: sortByStarsButton
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (sortByStarsButton.source == "qrc:/assets/icons/sort_down.png") {
                    sortByStarsButton.source = "qrc:/assets/icons/sort_up.png"
                } else {
                    sortByStarsButton.source = "qrc:/assets/icons/sort_down.png"
                }
            }
        }
    }

    Rectangle {
        id: category
        width: rectangleWidth
        height: rectangleHeight
        color: rectangleColor

        Text {
            text: qsTr("Category")
            font.pixelSize: 15
            color: "white"
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: sortByYear
        width: yearRectangleWidth
        height: rectangleHeight
        color: rectangleColor

        Text {
            text: qsTr("Year")
            font.pixelSize: 15
            color: "white"
            anchors.centerIn: parent
        }

        Image {
            id: sortByYearButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            source: "qrc:/assets/icons/sort_down.png"
        }

        MouseArea {
            anchors.fill: sortByYearButton
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (sortByYearButton.source == "qrc:/assets/icons/sort_down.png") {
                    sortByYearButton.source = "qrc:/assets/icons/sort_up.png"
                } else {
                    sortByYearButton.source = "qrc:/assets/icons/sort_down.png"
                }
            }
        }
    }
}
