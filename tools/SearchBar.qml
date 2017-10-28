import QtQuick 2.9
import QtQuick.Controls 2.2

Item {
    property alias placeHolder: searchBar.placeholderText
    width: parent.width
    height: parent.height

    Image {
        id: searchIcon
        source: "qrc:/assets/icons/search_dark.png"
        anchors.right: searchBar.left
        anchors.rightMargin: 5
        anchors.verticalCenter: searchBar.verticalCenter
    }
    TextField {
        id: searchBar
        anchors.centerIn: parent
        selectByMouse: true
        placeholderText: ""
    }
    Button {
        id: searchButton
        anchors.left: searchBar.right
        anchors.leftMargin: 15
        anchors.verticalCenter: searchBar.verticalCenter
        text: "Search"
        onClicked: notYet.open()
    }
}
