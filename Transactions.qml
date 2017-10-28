import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3
import QtQuick.XmlListModel 2.0

import "tools"

Page {

    property string pageTitle: qsTr("Transactions")

    property int delegateHeight: 90
    property int transactionsRectangleWidth: 170
    property int transactionsRectangleHeight: delegateHeight
    property string transactionsRectangleColor: "transparent"
    property real transactionsRectangleOpacity: 1.0
    property int transactionsCostTimeRectangleWidth: Math.round(transactionsRectangleWidth / 1.4)
    property int transactionsFontSize: 16

    // For use in displaying transaction details
    property string selectedCustomerID
    property string selectedCustomerThumb
    property string selectedTransactionDescription
    property string selectedTransactionCost
    property string selectedTransactionTime

    RowLayout {
        id: searchBarRow
        width: parent.width
        height: 80
        SearchBar {
            id: search
            Layout.alignment: Qt.AlignHCenter
            placeHolder: qsTr("Customer ID, name, phone number, task type")
        }

        SortTransactions {
            anchors.right: parent.right
            anchors.rightMargin: 30
            comboBoxWidth: 140
            optionsList: ["Pending", "Completed", "Held", "Cancelled"]
        }

    }

    Item {
        id: sortBarRow
        height: 30
        anchors.top: searchBarRow.bottom
        SortBarTransactions {
        }

    }

    ListView {
        id: transactionsView
        clip: true
        anchors.top: sortBarRow.bottom
        anchors.topMargin: 20
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        model: transactionsModel
        delegate: transactionsDelegate
        ScrollBar.vertical: ScrollBar {
            id: transactionsScrollbar
            active: true
            contentItem: Rectangle {
                width: 8
                radius: 4
                color: transactionsScrollbar.pressed ? "#b61616" : "#ea5354"
            }
        }
    }

    XmlListModel {
        id: transactionsModel
        source: "qrc:/transactions.xml"
        query: "/transactions/transaction"

        XmlRole { name: "number"; query: "number/string()" }
        XmlRole { name: "thumb"; query: "thumb/string()" }
        XmlRole { name: "customerID"; query: "customerID/string()" }
        XmlRole { name: "description"; query: "description/string()" }
        XmlRole { name: "cost"; query: "cost/string()" }
        XmlRole { name: "time"; query: "time/string()" }
        XmlRole { name: "action"; query: "action/string()" }
    }


    Component {
        id: transactionsDelegate

        Item {
            width: parent.width
            height: delegateHeight

            RowLayout {
                id: transactionDataRow
                width: parent.width
                height: parent.height - 4

                Rectangle {
                    id: numberDisplayRect
                    height: parent.height
                    width: 60
                    color: transactionsRectangleColor
                    anchors.left: parent.left
                    Rectangle {
                        anchors.centerIn: parent
                        height: numberText.font.pixelSize + 15
                        width: numberText.font.pixelSize + 15
                        color: "transparent"
                        border.width: 2
                        border.color: "#cccccc"
                        Text {
                            id: numberText
                            anchors.centerIn: parent
                            font.pixelSize: 20
                            color: "#f3f3f4"
                            text: number
                            wrapMode: Text.WordWrap
                        }
                    }
                }

                Rectangle {
                    id: customerProfilePicDisplayRect
                    height: parent.height
                    width: Math.round(transactionsRectangleWidth / 1.4)
                    color: transactionsRectangleColor
                    anchors.left: numberDisplayRect.right
                    Image {
                        id: customerProfilePic
                        anchors.centerIn: parent
                        source: thumb
                        width: 70
                        height: 70
                        property bool rounded: true

                        layer.enabled: rounded
                        layer.effect: OpacityMask {

                            property bool adapt: false
                            maskSource: Item {
                                width: customerProfilePic.width
                                height: customerProfilePic.height
                                Rectangle {
                                    anchors.centerIn: parent
                                    width: adapt ? customerProfilePic.width : Math.min(customerProfilePic.width, customerProfilePic.height)
                                    height: adapt ? customerProfilePic.height : width
                                    radius: Math.min(width, height)
                                }
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: customerProfilePic
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: notYet.open()
                    }
                }

                Rectangle {
                    id: customerIDDisplayRect
                    height: parent.height
                    width: transactionsRectangleWidth
                    color: transactionsRectangleColor
                    anchors.left: customerProfilePicDisplayRect.right
                    anchors.leftMargin: 10
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: 16
                        color: "#f3f3f4"
                        text: customerID
                        width: parent.width - 20
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: descriptionDisplayRect
                    height: parent.height
                    width: transactionsRectangleWidth
                    color: transactionsRectangleColor
                    anchors.left: customerIDDisplayRect.right
                    anchors.leftMargin: 10
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: 16
                        color: "#f3f3f4"
                        text: description
                        width: parent.width - 15
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: costDisplayRect
                    height: parent.height
                    width: transactionsCostTimeRectangleWidth
                    color: transactionsRectangleColor
                    anchors.left: descriptionDisplayRect.right
                    anchors.leftMargin: 10
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: 16
                        color: "#f3f3f4"
                        text: cost
                        width: parent.width - 15
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: timeDisplayRect
                    height: parent.height
                    width: transactionsCostTimeRectangleWidth
                    color: transactionsRectangleColor
                    anchors.left: costDisplayRect.right
                    anchors.leftMargin: 10
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: 16
                        color: "#f3f3f4"
                        text: time
                        width: parent.width - 15
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: actionDisplayRect
                    height: parent.height
                    width: transactionsRectangleWidth
                    color: transactionsRectangleColor
                    anchors.left: timeDisplayRect.right
                    anchors.leftMargin: 10

                    Button {
                        id: actionButton
                        anchors.centerIn: parent
                        text: action
                        onClicked: function() {
                            selectedCustomerID = customerID
                            selectedCustomerThumb = thumb
                            selectedTransactionDescription = description
                            selectedTransactionCost = cost
                            selectedTransactionTime = time

                            if (String(action).toLowerCase() == "burn dvd") {
                                burnDVD.open()
                            } else if (String(action).toLowerCase() == "burn cd") {
                                burnCD.open()
                            } else {
                                copyToDisk.open()
                            }
                        }
                    }
                }

                Rectangle {
                    id: optionsDisplayRect
                    height: parent.height
                    width: transactionsRectangleWidth
                    color: transactionsRectangleColor
                    anchors.left: actionDisplayRect.right
                    anchors.leftMargin: 10

                    Button {
                        id: optionHoldButton
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Hold"
                        onClicked: notYet.open()
                    }

                    Button {
                        id: optionCancelButton
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Cancel"
                        onClicked: notYet.open()
                    }
                }


            }

            Rectangle {
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.right: parent.right
                anchors.rightMargin: 20
                height: 1
                color: "#bfbfbf"
                opacity: 0.5
            }
        }


    }

    Dialog {
        id: burnDVD
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        width: Math.round(parent.width / 1.2)
        height: Math.round(parent.height / 1.1)
        standardButtons: Dialog.Close
        title: "BURN DVD"

        Image {
            id: burnDVDIcon
            source: "qrc:/assets/icons/burn_dvd.png"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
        }

        RowLayout {
            id: transactionDataDetailsRow
            width: parent.width
            height: 75
            anchors.top: burnDVDIcon.bottom

            Image {
                id: customerThumb
                source: selectedCustomerThumb
                width: 70
                height: 70
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter

                property bool rounded: true

                layer.enabled: rounded
                layer.effect: OpacityMask {

                    property bool adapt: false
                    maskSource: Item {
                        width: customerThumb.width
                        height: customerThumb.height
                        Rectangle {
                            anchors.centerIn: parent
                            width: adapt ? customerThumb.width : Math.min(customerThumb.width, customerThumb.height)
                            height: adapt ? customerThumb.height : width
                            radius: Math.min(width, height)
                        }
                    }
                }
            }

            Column {
                height: parent.height
                spacing: 5
                anchors.left: customerThumb.right
                anchors.leftMargin: 30

                Text {
                    id: customerName
                    font.pixelSize: 15
                    color: "#e0e0e0"
                    text: selectedCustomerID
                }

                Text {
                    id: transactiondesc
                    font.pixelSize: 15
                    color: "#e0e0e0"
                    text: "Bought " + selectedTransactionDescription
                }
            }

            Column {
                spacing: 5
                height: parent.height
                Layout.fillWidth: true

                Rectangle {
                    id: transactionCostRect
                    color: "transparent"
                    border.color: "#f3f3f4"
                    radius: 4
                    height: 18
                    width: transactionsCost.width + 10

                    Text {
                        id: transactionsCost
                        anchors.centerIn: parent
                        font.pixelSize: 14
                        color: "#ffffff"
                        text: "Total: " + selectedTransactionCost
                    }

                }

                Rectangle {
                    id: transactionTimeRect
                    color: "transparent"
                    border.color: "#f3f3f4"
                    radius: 4
                    height: 18
                    width: transactionTime.width + 10

                    Text {
                        id: transactionTime
                        anchors.centerIn: parent
                        font.pixelSize: 14
                        color: "#ffffff"
                        text: "Time: " + selectedTransactionTime
                    }

                }
            }
        }

        Rectangle {
            id: topRule
            height: 1
            color: "#e0e0e0"
            opacity: 0.5
            width: parent.width
            anchors.top: transactionDataDetailsRow.bottom
            anchors.topMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 40
            anchors.left: parent.left
            anchors.leftMargin: 120
        }

        RowLayout {
            id: columnHeadingsRow
            width: parent.width
            height: 30
            anchors.top: topRule.bottom
            spacing: 50

            Text {
                id: titleHeading
                anchors.left: parent.left
                anchors.leftMargin: 120
                color: "#e0e0e0"
                text: "Movie Title"
            }

            Text {
                id: costHeading
                anchors.left: titleHeading.right
                anchors.leftMargin: 200
                color: "#e0e0e0"
                text: "Cost (Ksh)"
            }

            Text {
                id: actionHeading
                anchors.left: costHeading.right
                anchors.leftMargin: 120
                color: "#e0e0e0"
                text: "Action"
            }
        }

        Rectangle {
            id: bottomRule
            height: 1
            color: "#e0e0e0"
            opacity: 0.5
            anchors.right: parent.right
            anchors.rightMargin: 40
            anchors.left: parent.left
            anchors.leftMargin: 120
            anchors.top: columnHeadingsRow.bottom
        }


        ListView {
            id: burnDVDListView
            clip: true
            anchors.top: bottomRule.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.margins: 20
            model: burnDVDListModel
            delegate: burnDVDDelegate
            ScrollBar.vertical: ScrollBar {
                id: burnDVDListViewScrollbar
                active: true
                contentItem: Rectangle {
                    implicitWidth: 5
                    radius: Math.round(width / 2)
                    color: burnDVDListViewScrollbar.pressed ? "#b61616" : "#ea5354"
                }
            }
        }

        XmlListModel {
            id: burnDVDListModel
            source: "qrc:/transactiondetails.xml"
            query: "/tdetails/detail1/item"

            XmlRole {
                name: "title"
                query: "title/string()"
            }
            XmlRole {
                name: "thumb"
                query: "thumb/string()"
            }
            XmlRole {
                name: "cost"
                query: "cost/string()"
            }
        }

        Component {
            id: burnDVDDelegate
            Item {
                height: 120
                width: parent.width

                RowLayout {
                    id: burnDVDTasksRow
                    height: parent.height - 5
                    width: parent.width

                    Rectangle {
                        id: thumbRect
                        width: 70
                        height: parent.height
                        color: "transparent"

                        Image {
                            source: thumb
                            height: 100
                            width: 68
                            anchors.centerIn: parent
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: notYet.open()
                        }
                    }

                    Rectangle {
                        id: titleRect
                        height: parent.height
                        width: 250
                        anchors.left: thumbRect.right
                        anchors.leftMargin: 30
                        color: "transparent"

                        Text {
                            anchors.centerIn: parent
                            color: "#e0e0e0"
                            text: title
                            wrapMode: Text.WordWrap
                            width: parent.width - 10
                        }
                    }

                    Rectangle {
                        id: costRect
                        anchors.left: titleRect.right
                        anchors.leftMargin: 20
                        height: parent.height
                        width: 100
                        color: "transparent"

                        Text {
                            anchors.centerIn: parent
                            color: "#e0e0e0"
                            text: cost
                            width: parent.width - 10
                        }
                    }

                    Rectangle {
                        id: actionRect
                        anchors.left: costRect.right
                        anchors.leftMargin: 70
                        height: parent.height
                        width: 150
                        color: "transparent"

                        Button {
                            anchors.centerIn: parent
                            text: "Burn DVD"
                            onClicked: notYet.open()
                        }
                    }

                }

                Rectangle {
                    id: horizontalRule
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 1
                    color: "#e0e0e0"
                    opacity: 0.5

                }
            }


        }
    }

    Dialog {
        id: burnCD
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        width: Math.round(parent.width / 1.2)
        height: Math.round(parent.height / 1.1)
        standardButtons: Dialog.Close
        title: "BURN CD"

        Image {
            id: burnCDIcon
            source: "qrc:/assets/icons/burn_cd.png"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
        }

        RowLayout {
            id: transactionDataDetailsRowCD
            width: parent.width
            height: 75
            anchors.top: burnCDIcon.bottom

            Image {
                id: customerThumbCD
                source: selectedCustomerThumb
                width: 70
                height: 70
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter

                property bool rounded: true

                layer.enabled: rounded
                layer.effect: OpacityMask {

                    property bool adapt: false
                    maskSource: Item {
                        width: customerThumbCD.width
                        height: customerThumbCD.height
                        Rectangle {
                            anchors.centerIn: parent
                            width: adapt ? customerThumbCD.width : Math.min(customerThumbCD.width, customerThumbCD.height)
                            height: adapt ? customerThumbCD.height : width
                            radius: Math.min(width, height)
                        }
                    }
                }
            }

            Column {
                height: parent.height
                spacing: 5
                anchors.left: customerThumbCD.right
                anchors.leftMargin: 30

                Text {
                    font.pixelSize: 15
                    color: "#e0e0e0"
                    text: selectedCustomerID
                }

                Text {
                    font.pixelSize: 15
                    color: "#e0e0e0"
                    text: "Bought " + selectedTransactionDescription
                }
            }

            Column {
                spacing: 5
                height: parent.height
                Layout.fillWidth: true

                Rectangle {
                    id: transactionCostRectCD
                    color: "transparent"
                    border.color: "#f3f3f4"
                    radius: 4
                    height: 18
                    width: transactionsCostCD.width + 10

                    Text {
                        id: transactionsCostCD
                        anchors.centerIn: parent
                        font.pixelSize: 14
                        color: "#ffffff"
                        text: "Total: " + selectedTransactionCost
                    }

                }

                Rectangle {
                    id: transactionTimeRectCD
                    color: "transparent"
                    border.color: "#f3f3f4"
                    radius: 4
                    height: 18
                    width: transactionTimeCD.width + 10

                    Text {
                        id: transactionTimeCD
                        anchors.centerIn: parent
                        font.pixelSize: 14
                        color: "#ffffff"
                        text: "Time: " + selectedTransactionTime
                    }

                }
            }
        }

        Rectangle {
            id: topRuleCD
            height: 1
            color: "#e0e0e0"
            opacity: 0.5
            width: parent.width
            anchors.top: transactionDataDetailsRowCD.bottom
            anchors.topMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 40
            anchors.left: parent.left
            anchors.leftMargin: 150
        }

        RowLayout {
            id: columnHeadingsRowCD
            width: parent.width
            height: 30
            anchors.top: topRuleCD.bottom
            spacing: 50

            Text {
                id: titleHeadingCD
                anchors.left: parent.left
                anchors.leftMargin: 160
                color: "#e0e0e0"
                text: "Title"
            }

            Text {
                id: artistHeadingCD
                anchors.left: titleHeadingCD.right
                anchors.leftMargin: 200
                color: "#e0e0e0"
                text: "Artist"
            }

            Text {
                id: costHeadingCD
                anchors.left: artistHeadingCD.right
                anchors.leftMargin: 150
                color: "#e0e0e0"
                text: "Cost (Ksh)"
            }

            Text {
                id: actionHeadingCD
                anchors.left: costHeadingCD.right
                anchors.leftMargin: 150
                color: "#e0e0e0"
                text: "Action"
            }
        }

        Rectangle {
            id: bottomRuleCD
            height: 1
            color: "#e0e0e0"
            opacity: 0.5
            anchors.right: parent.right
            anchors.rightMargin: 40
            anchors.left: parent.left
            anchors.leftMargin: 150
            anchors.top: columnHeadingsRowCD.bottom
        }


        ListView {
            id: burnCDListView
            clip: true
            anchors.top: bottomRuleCD.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.margins: 20
            model: burnCDListModel
            delegate: burnCDDelegate
            ScrollBar.vertical: ScrollBar {
                id: burnCDListViewScrollbar
                active: true
                contentItem: Rectangle {
                    implicitWidth: 5
                    radius: Math.round(width / 2)
                    color: burnCDListViewScrollbar.pressed ? "#b61616" : "#ea5354"
                }
            }
        }

        XmlListModel {
            id: burnCDListModel
            source: "qrc:/transactiondetails.xml"
            query: "/tdetails/detail2/item"

            XmlRole {
                name: "title"
                query: "title/string()"
            }
            XmlRole {
                name: "artist"
                query: "artist/string()"
            }
            XmlRole {
                name: "thumb"
                query: "thumb/string()"
            }
            XmlRole {
                name: "cost"
                query: "cost/string()"
            }
        }

        Component {
            id: burnCDDelegate
            Item {
                height: 120
                width: parent.width

                RowLayout {
                    id: burnCDTasksRow
                    height: parent.height - 5
                    width: parent.width

                    Rectangle {
                        id: thumbRectCD
                        width: 110
                        height: parent.height
                        color: "transparent"

                        Image {
                            source: thumb
                            height: 100
                            width: 100
                            anchors.centerIn: parent
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: notYet.open()
                        }
                    }

                    Rectangle {
                        id: titleRectCD
                        height: parent.height
                        width: 230
                        anchors.left: thumbRectCD.right
                        anchors.leftMargin: 20
                        color: "transparent"

                        Text {
                            anchors.centerIn: parent
                            color: "#e0e0e0"
                            text: title
                            wrapMode: Text.WordWrap
                            width: parent.width - 10
                        }
                    }

                    Rectangle {
                        id: artistRectCD
                        height: parent.height
                        width: 180
                        anchors.left: titleRectCD.right
                        anchors.leftMargin: 5
                        color: "transparent"

                        Text {
                            anchors.centerIn: parent
                            color: "#e0e0e0"
                            text: artist
                            wrapMode: Text.WordWrap
                            width: parent.width - 10
                        }
                    }

                    Rectangle {
                        id: costRectCD
                        anchors.left: artistRectCD.right
                        anchors.leftMargin: 20
                        height: parent.height
                        width: 100
                        color: "transparent"

                        Text {
                            anchors.centerIn: parent
                            color: "#e0e0e0"
                            text: cost
                            width: parent.width - 10
                        }
                    }

                    Rectangle {
                        id: actionRectCD
                        anchors.left: costRectCD.right
                        anchors.leftMargin: 70
                        height: parent.height
                        width: 150
                        color: "transparent"

                        Button {
                            anchors.centerIn: parent
                            text: "Burn CD"
                            onClicked: notYet.open()
                        }
                    }

                }

                Rectangle {
                    id: horizontalRuleCD
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 1
                    color: "#e0e0e0"
                    opacity: 0.5

                }
            }


        }
    }

    Dialog {
        id: copyToDisk
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        width: Math.round(parent.width / 1.2)
        height: Math.round(parent.height / 1.1)
        standardButtons: Dialog.Close
        title: "COPY TO DISK"

        Image {
            id: copyToDiskIcon
            source: "qrc:/assets/icons/copy_to_disk.png"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
        }

        RowLayout {
            id: transactionDataDetailsRowDisk
            width: parent.width
            height: 75
            anchors.top: copyToDiskIcon.bottom

            Image {
                id: customerThumbDisk
                source: selectedCustomerThumb
                width: 70
                height: 70
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter

                property bool rounded: true

                layer.enabled: rounded
                layer.effect: OpacityMask {

                    property bool adapt: false
                    maskSource: Item {
                        width: customerThumbDisk.width
                        height: customerThumbDisk.height
                        Rectangle {
                            anchors.centerIn: parent
                            width: adapt ? customerThumbDisk.width : Math.min(customerThumbDisk.width, customerThumbDisk.height)
                            height: adapt ? customerThumbDisk.height : width
                            radius: Math.min(width, height)
                        }
                    }
                }
            }

            Column {
                height: parent.height
                spacing: 5
                anchors.left: customerThumbDisk.right
                anchors.leftMargin: 30

                Text {
                    id: customerNameDisk
                    font.pixelSize: 15
                    color: "#e0e0e0"
                    text: selectedCustomerID
                }

                Text {
                    font.pixelSize: 15
                    color: "#e0e0e0"
                    text: "Bought " + selectedTransactionDescription
                }
            }

            Column {
                spacing: 5
                height: parent.height
                Layout.fillWidth: true

                Rectangle {
                    id: transactionCostRectDisk
                    color: "transparent"
                    border.color: "#f3f3f4"
                    radius: 4
                    height: 18
                    width: transactionsCostDisk.width + 10

                    Text {
                        id: transactionsCostDisk
                        anchors.centerIn: parent
                        font.pixelSize: 14
                        color: "#ffffff"
                        text: "Total: " + selectedTransactionCost
                    }

                }

                Rectangle {
                    id: transactionTimeRectDisk
                    color: "transparent"
                    border.color: "#f3f3f4"
                    radius: 4
                    height: 18
                    width: transactionTimeDisk.width + 10

                    Text {
                        id: transactionTimeDisk
                        anchors.centerIn: parent
                        font.pixelSize: 14
                        color: "#ffffff"
                        text: "Time: " + selectedTransactionTime
                    }

                }
            }
        }

        Rectangle {
            id: topRuleDisk
            height: 1
            color: "#e0e0e0"
            opacity: 0.5
            width: parent.width
            anchors.top: transactionDataDetailsRowDisk.bottom
            anchors.topMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 40
            anchors.left: parent.left
            anchors.leftMargin: 120
        }

        RowLayout {
            id: columnHeadingsRowDisk
            width: parent.width
            height: 30
            anchors.top: topRuleDisk.bottom
            spacing: 50

            Text {
                id: titleHeadingDisk
                anchors.left: parent.left
                anchors.leftMargin: 120
                color: "#e0e0e0"
                text: "Title"
            }

            Text {
                id: costHeadingDisk
                anchors.left: titleHeadingDisk.right
                anchors.leftMargin: 200
                color: "#e0e0e0"
                text: "Cost (Ksh)"
            }

            Text {
                id: actionHeadingDisk
                anchors.left: costHeadingDisk.right
                anchors.leftMargin: 120
                color: "#e0e0e0"
                text: "Action"
            }
        }

        Rectangle {
            id: bottomRuleDisk
            height: 1
            color: "#e0e0e0"
            opacity: 0.5
            anchors.right: parent.right
            anchors.rightMargin: 40
            anchors.left: parent.left
            anchors.leftMargin: 120
            anchors.top: columnHeadingsRowDisk.bottom
        }


        ListView {
            id: copyToDiskListView
            clip: true
            anchors.top: bottomRuleDisk.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.margins: 20
            model: copyToDiskListModel
            delegate: copyToDiskDelegate
            ScrollBar.vertical: ScrollBar {
                id: copyToDiskListViewScrollbar
                active: true
                contentItem: Rectangle {
                    implicitWidth: 5
                    radius: Math.round(width / 2)
                    color: copyToDiskListViewScrollbar.pressed ? "#b61616" : "#ea5354"
                }
            }
        }

        XmlListModel {
            id: copyToDiskListModel
            source: "qrc:/transactiondetails.xml"
            query: "/tdetails/detail3/item"

            XmlRole {
                name: "title"
                query: "title/string()"
            }
            XmlRole {
                name: "thumb"
                query: "thumb/string()"
            }
            XmlRole {
                name: "cost"
                query: "cost/string()"
            }
        }

        Component {
            id: copyToDiskDelegate
            Item {
                height: 120
                width: parent.width

                RowLayout {
                    id: copyToDiskTasksRow
                    height: parent.height - 5
                    width: parent.width

                    Rectangle {
                        id: thumbRectDisk
                        width: 70
                        height: parent.height
                        color: "transparent"

                        Image {
                            source: thumb
                            height: 100
                            width: 68
                            anchors.centerIn: parent
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: notYet.open()
                        }
                    }

                    Rectangle {
                        id: titleRectDisk
                        height: parent.height
                        width: 230
                        anchors.left: thumbRectDisk.right
                        anchors.leftMargin: 30
                        color: "transparent"

                        Text {
                            anchors.centerIn: parent
                            color: "#e0e0e0"
                            text: title
                            wrapMode: Text.WordWrap
                            width: parent.width - 10
                        }
                    }

                    Rectangle {
                        id: costRectDisk
                        anchors.left: titleRectDisk.right
                        anchors.leftMargin: 20
                        height: parent.height
                        width: 100
                        color: "transparent"

                        Text {
                            anchors.centerIn: parent
                            color: "#e0e0e0"
                            text: cost
                            width: parent.width - 10
                        }
                    }

                    Rectangle {
                        id: actionRectDisk
                        anchors.left: costRectDisk.right
                        anchors.leftMargin: 50
                        height: parent.height
                        width: 150
                        color: "transparent"

                        Button {
                            anchors.centerIn: parent
                            text: "Copy to Disk"
                            onClicked: notYet.open()
                        }
                    }

                }

                Rectangle {
                    id: horizontalRuleDisk
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 1
                    color: "#e0e0e0"
                    opacity: 0.5

                }
            }


        }
    }
}
