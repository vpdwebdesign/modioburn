import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "tools"

ApplicationWindow {
    id: mainWindow
    visible: true
    visibility: "Maximized"

    property int screenHeight: Screen.desktopAvailableHeight
    property int screenWidth: Screen.desktopAvailableWidth

    width: screenWidth
    height: screenHeight

    title: qsTr("Modio Burn 1.0")

    property string userName: "Guest"
    property string userRole: "Guest"
    property int userAccessLevel: 0
    property bool loggedIn: false
    property bool switchedRoles: false
    property string selectedRole: "norole"
    property bool away: false

    property var mbUsers:
    {
        "kitindi": {
            pwd: "kitindi",
            role: "super-administrator",
            accesslevel: 5
        },
        "victor": {
            pwd: "victor",
            role: "super-administrator",
            accesslevel: 5
        },
        "john": {
            pwd: "john",
            role: "administrator",
            accesslevel: 4
        },
        "henry": {
            pwd: "henry",
            role: "manager",
            accesslevel: 3
        },

        "esther": {
            pwd: "esther",
            role: "attendant",
            accesslevel: 2
        },
        "jacob": {
            pwd: "jacob",
            role: "customer",
            accesslevel: 1
        }
    }

    property string signOutMessageCustomer: "Thank you for using ModioBurn. Enjoy your purchases and come back again soon."

    property string signOutMessageOthers: "Thank you for using ModioBurn to manage your entertainment business."

    header: MainToolBar {
        currentPageTitle: mainView.currentItem.pageTitle
    }

    StackView {
        id: mainView
        focus: true
        anchors.fill: parent
        initialItem: Login {}

    Dialog {
        id: notYet

        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        width: 400
        height: 150
        modal: true
        standardButtons: Dialog.Close

        title: "Functionality Not Yet Available"

        Label {
            width: parent.width
            text: "This functionality has not yet been built. Click anywhere outside this dialog box to continue."
            wrapMode: Label.Wrap
        }
    }

    Dialog {
        id: logoutDialog
        x: Math.round((parent.width - width) / 2)
        y: Math.round(parent.height / 6)
        width: 480
        modal: true
        focus: true
        title: "Modio Burn Logout"

        Label {
            text: qsTr("Are you sure you want to logout?")
        }

        standardButtons: Dialog.No | Dialog.Yes
        onAccepted: {
            thankYou.open()
            loggedIn = false;
            userRole = "norole";
            selectedRole = userRole;
            switchedRoles = false;

            mainView.pop(null);
        }
        onRejected: {
            logoutDialog.close()
        }        
    }

    Dialog {
        id: shutdownWait
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: 400
        height: 200
        parent: ApplicationWindow.overlay

        modal: true
        title: "Shutting down Modio Burn"
        onAboutToShow: shutdownWaitTextChangeTimer.start()

        ColumnLayout {
            spacing: 20
            Text {
                id: shutdownWaitText
                color: "#f3f3f4"
                text: "Beginning shutdown sequence. Please wait..."
            }

            Timer {
                id: shutdownWaitTextChangeTimer
                property int nextItem: 0
                property var shutdownSequenceList: [
                "Beginning shutdown sequence. Please wait...",
                "Logging out users...",
                "Logging out users...",
                "Disconnecting client devices...",
                "Disconnecting client devices...",
                "Transferring log data to Modio Burn Central Server...",
                "Transferring log data to Modio Burn Central Server...",
                "Transferring log data to Modio Burn Central Server...",
                "Shutting down...",
                "Shutting down..."
                ]
                interval: 1000
                repeat: true
                running: false
                onTriggered: function() {
                    shutdownWaitText.text = shutdownSequenceList[nextItem];
                    nextItem++;
                }
            }
        }

        ProgressBar {
            id: shutdownWaitProgress
            anchors.centerIn: parent
            indeterminate: true
        }
    }

    Timer {
        id: shutdownWaitTimer
        interval: 10000
        running: false
        onTriggered: function() {
            shutdownWait.close();
            Qt.quit()
        }
    }

    Dialog {
        id: shutdownDialog
        x: Math.round((parent.width - width) / 2)
        y: Math.round(parent.height / 6)
        width: 480
        modal: true
        focus: true
        title: "Shutdown Modio Burn"

        Label {
            text: qsTr("Are you sure you want to shutdown Modio Burn?\n\n")
                + qsTr("This will log you out and any clients currently logged in!")
        }

        standardButtons: Dialog.No | Dialog.Yes

        onAccepted: {
            loggedIn = false;
            shutdownWait.open();
            shutdownWaitTimer.start();

        }
        onRejected: {
            shutdownDialog.close()
        }
    }

    Dialog {
        id: thankYou
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: 320
        parent: ApplicationWindow.overlay

        modal: true
        title: "Thank You"
        standardButtons: Dialog.Close

        Column {
            id: column
            spacing: 20
            width: parent.width

            Image {
                id: logo
                width: parent.width / 2
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                source: "qrc:/assets/icons/logo2.png"
            }

            Label {
                width: parent.width
                text: userRole.toLowerCase() === "customer" ? signOutMessageCustomer : signOutMessageOthers
                wrapMode: Label.Wrap
            }
        }
    }
    }
}
