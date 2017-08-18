import QtQuick 2.9
import QtQuick.Controls 2.2

Page {
    id: clientpage

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: clientInterfaceSwipeViewIndex

        Movies {}
        Music {}
        Games {}

    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            Image {
                id: footermoviesicon
                source: "qrc:/assets/icons/movies.png"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Movies")
            onClicked: [clientInterfaceSwipeViewIndex = 0, pagetitle.text = qsTr("Movies")]
        }
        TabButton {
            Image {
                id: footermusicicon
                source: "qrc:/assets/icons/music.png"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Music")
            onClicked: [clientInterfaceSwipeViewIndex = 1, pagetitle.text = qsTr("Music")]
        }
        TabButton {
            Image {
                id: footergamesicon
                source: "qrc:/assets/icons/games.png"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Games")
            onClicked: [clientInterfaceSwipeViewIndex = 2, pagetitle.text = qsTr("Games")]
        }
    }

}


