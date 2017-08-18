import QtQuick 2.9

Item {
    id: root
    width: parent.width
    height: 88

    property alias text: textitem.text
    signal clicked

    Text {
        id: textitem
        color: "black"
        font.pixelSize: 32
        text: modelData
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 30
    }

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 20
        height: 1
        color: "#bfbfbf"
    }

    Image {
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        source: "qrc:/assets/icons/next.png"
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        onClicked: root.clicked()

    }
}
