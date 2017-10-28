import QtQuick 2.9
import QtQuick.Controls 2.2
import "tools"

Page {
    id: clientPage

    property string pageTitle: swipeView.currentItem.pageTitle

    SwipeView {
        id: swipeView
        anchors.fill: parent
        interactive: false
        currentIndex: clientInterfaceSwipeViewIndex

        Movies {}
        Series {}
        Music {}
        Games {}

    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            Image {
                id: footerMoviesIcon
                source: "qrc:/assets/icons/movies.png"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Movies")
            onClicked: clientInterfaceSwipeViewIndex = 0
        }
        TabButton {
            Image {
                id: footerSeriesIcon
                source: "qrc:/assets/icons/series.png"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Series")
            onClicked: clientInterfaceSwipeViewIndex = 1
        }
        TabButton {
            Image {
                id: footerMusicIcon
                source: "qrc:/assets/icons/music.png"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Music")
            onClicked: clientInterfaceSwipeViewIndex = 2
        }
        TabButton {
            Image {
                id: footerGamesIcon
                source: "qrc:/assets/icons/games.png"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Games")
            onClicked: clientInterfaceSwipeViewIndex = 3
        }
    }
}


