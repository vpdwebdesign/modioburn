import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "tools"

Page {

    property string pageTitle: qsTr("Games")

    Text {
        id: gamesLoadingText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: gamesLoadingIndicator.top
        anchors.bottomMargin: 30
        font.pixelSize: 30
        color: "#595959"
        text: qsTr("Modio Burn is checking the system's game database. Please wait...")
    }

    BusyIndicator {
        id: gamesLoadingIndicator
        anchors.centerIn: parent
        running: true
    }
}
