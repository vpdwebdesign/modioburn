import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
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


    property int clientInterfaceSwipeViewIndex
    property bool loggedIn: false
    property string userName

    header: MainToolBar {
        id: toolBarTitle
        currentPageTitle: mainView.currentItem ? mainView.currentItem.pageTitle : qsTr("Welcome")
    }

    StackView {
        id: mainView
        focus: true
        anchors.fill: parent
        initialItem: Login {}

        // Javascript functions from Ekke's Stacked Pages tutorial

        // go one level back in stack
        function popOnePage() {
            if(mainView.depth == 1) {
                return
            }
            // check if target page already is on the stack
            var targetIsUninitialized = false
            if(!mainView.get(mainView.depth-2)) {
                targetIsUninitialized = true
            }
            var page = pop()
            if(targetIsUninitialized) {
                mainView.currentItem.init()
            }
            // do cleanup from previous page
            page.cleanup()
        } // popOnePage

        function pushOnePage(pageComponent) {
            var page = push(pageComponent)
            page.init()
        }

        function pushNextPage() {
            switch(mainView.depth) {
            case 1:
                pushOnePage(pageTwo)
                break;
            case 2:
                pushOnePage(pageThree)
                break;
            default:
                // nothing - 3 is max
            }
        } // pushNextPage

        function findPage(pageName) {
            var targetPage = find(function(item) {
                return item.name == pageName;
            })
            if(targetPage) {
                return targetPage.StackView.index
            } else {
                console.log("Page not found in StackView: "+pageName)
                return -1
            }
        }

        function goUpTo(pageNumber) {
            var count = pageNumber-mainView.depth
            var pages = new Array (count)
            for(var i = 0; i < count; i++) {
                var thePageNumber = mainView.depth+i+1
                switch(thePageNumber) {
                case 1:
                    pages[i] = pageOne
                    break;
                case 2:
                    pages[i] = pageTwo
                    break;
                case 3:
                    pages[i] = pageThree
                    break;
                default:
                    // nothing
                    return
                }
            }
            var page = push(pages)
            page.init()
        } // goUpTo

        function goDownTo(pageNumber) {
            // check if cleanup must be done for popped pages
            var count = mainView.depth-pageNumber
            for(var i = 0; i < count; i++) {
                if(mainView.get(mainView.depth-i-1)) {
                    mainView.get(mainView.depth-i-1).cleanup()
                }
            }
            // pop all pages until targetPage will be on top
            // check if target page already is on the stack
            var targetIsUninitialized = false
            if(!mainView.get(pageNumber-1)) {
                targetIsUninitialized = true
            }
            // don't forget to set StackView.ForceLoad
            // otherwise if get() is null and get(null) means jump to root
            pop(mainView.get(pageNumber-1, StackView.ForceLoad))
            if(targetIsUninitialized) {
                mainView.get(pageNumber-1).init()
            }
        } // goDownTo

        function goToPage(pageNumber) {
            if(pageNumber == mainView.depth) {
                // it's the current page
                return
            }
            if(pageNumber > mainView.depth) {
                goUpTo(pageNumber)
                return
            }
            goDownTo(pageNumber)
        } // goToPage
    }

    Component {
        id: pageOne
        Login {
            id: page
            // we only need this for initialItem
            // items on stack will init() after push()
            Component.onCompleted: {
                page.init()
            }
        }
    } // pageOne

    Component {
        id: pageTwo
        Home {
        }
    } // pageTwo

    Component {
        id: pageThree
        Client {
        }
    }


    Dialog {
        id: notYet

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        title: "Functionality Not Yet Available"

        Label {
            text: "This functionality has not yet been built.\n
Click anywhere outside this dialog box to continue."
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
            mainView.goToPage(1);
        }
        onRejected: {
            logoutDialog.close()
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
                text: "Thank you for using Modio Burn. Enjoy your purchases, "
                    + "and come back soon."
                wrapMode: Label.Wrap
            }
        }
    }
}
