import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

RowLayout {

    height: parent.height
    anchors.left: parent.left
    anchors.leftMargin: 60
    spacing: 10

    property int rectangleWidth: 170
    property int rectangleHeight: parent.height
    property int costTimeRectangleWidth: Math.round(rectangleWidth / 1.4)
    property string rectangleColor: "#ea5354"

    Rectangle {
        id: profilePic
        width: Math.round(rectangleWidth / 1.4)
        height: rectangleHeight
        color: rectangleColor

        Text {
            text: qsTr("Profile")
            font.pixelSize: 15
            color: "white"
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: sortByCustomerID
        width: rectangleWidth
        height: rectangleHeight
        color: rectangleColor

        Text {
            id: sortByCustomerIDText
            text: qsTr("Customer ID")
            font.pixelSize: 15
            color: "white"
            anchors.centerIn: parent
        }

        Image {
            id: sortByCustomerIDButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            source: "qrc:/assets/icons/sort_down.png"
        }

        MouseArea {
            anchors.fill: sortByCustomerIDButton
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (sortByCustomerIDButton.source == "qrc:/assets/icons/sort_down.png") {
                    sortByCustomerIDButton.source = "qrc:/assets/icons/sort_up.png"
                } else {
                    sortByCustomerIDButton.source = "qrc:/assets/icons/sort_down.png"
                }
            }
        }
    }

    Rectangle {
        id: description
        width: rectangleWidth
        height: rectangleHeight
        color: rectangleColor

        Text {
            text: qsTr("Description")
            font.pixelSize: 15
            color: "white"
            anchors.centerIn: parent
        }

        Image {
            id: descriptionButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            source: "qrc:/assets/icons/sort_down.png"
        }

        MouseArea {
            anchors.fill: descriptionButton
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (descriptionButton.source == "qrc:/assets/icons/sort_down.png") {
                    descriptionButton.source = "qrc:/assets/icons/sort_up.png"
                } else {
                    descriptionButton.source = "qrc:/assets/icons/sort_down.png"
                }
            }
        }
    }

    Rectangle {
        id: sortByCost
        width: costTimeRectangleWidth
        height: rectangleHeight
        color: rectangleColor

        Text {
            text: qsTr("Cost (Ksh)")
            font.pixelSize: 15
            color: "white"
            anchors.centerIn: parent
        }

        Image {
            id: sortByCostButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            source: "qrc:/assets/icons/sort_down.png"
        }

        MouseArea {
            anchors.fill: sortByCostButton
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (sortByCostButton.source == "qrc:/assets/icons/sort_down.png") {
                    sortByCostButton.source = "qrc:/assets/icons/sort_up.png"
                } else {
                    sortByCostButton.source = "qrc:/assets/icons/sort_down.png"
                }
            }
        }
    }

    Rectangle {
        id: sortByTime
        width: costTimeRectangleWidth
        height: rectangleHeight
        color: rectangleColor

        Text {
            text: qsTr("Time")
            font.pixelSize: 15
            color: "white"
            anchors.centerIn: parent
        }

        Image {
            id: sortByTimeButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            source: "qrc:/assets/icons/sort_down.png"
        }

        MouseArea {
            anchors.fill: sortByTimeButton
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (sortByTimeButton.source == "qrc:/assets/icons/sort_down.png") {
                    sortByTimeButton.source = "qrc:/assets/icons/sort_up.png"
                } else {
                    sortByTimeButton.source = "qrc:/assets/icons/sort_down.png"
                }
            }
        }
    }

    Rectangle {
        id: requiredActions
        width: rectangleWidth
        height: rectangleHeight
        color: rectangleColor

        Text {
            text: qsTr("Required Actions")
            font.pixelSize: 15
            color: "white"
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: requiredActionsOptions
        width: rectangleWidth
        height: rectangleHeight
        color: rectangleColor

        Text {
            text: qsTr("Options")
            font.pixelSize: 15
            color: "white"
            anchors.centerIn: parent
        }
    }
}


