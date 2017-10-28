import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.XmlListModel 2.0
import "tools"

Page {

    id: sellItemsPage

    property string pageTitle: qsTr("Sell")
    property int itemDisplayRectWidth: 170
    property int purchasesDisplayRectWidth: Math.round(itemDisplayRectWidth / 1.5)
    property color serialNoTextColor: "#90a4ae"
    property int stockItemsViewWidth: Math.round(sellItemsPage.width / 1.6)

    property string selectedStockItem
    property int selectedStockItemIndex
    property int selectedStockItemTotalQuantity
    property int selectedStockItemCost
    property int selectedStockItemTotalCost
    property int selectedStockItemQuantity
    property int selectedItemRemaining
    property int purchasesListTotalCost: 0

    RowLayout {
        id: controlsRow
        anchors.top: parent.top
        anchors.topMargin: 20
        width: Math.round(parent.width / 1.5)
        anchors.horizontalCenter: parent.horizontalCenter
        height: 100

        Label {
            id: comboBoxLabel
            anchors.left: parent.left
            anchors.leftMargin: 20
            color: "#90a4ae"
            font.pixelSize: 15
            text: "Select Item"
        }

        ComboBox {
            id: availableStockItems
            anchors.left: comboBoxLabel.right
            anchors.leftMargin: 20
            implicitWidth: 200
            model: XmlListModel {
                source: "qrc:/stock.xml"
                query: "/stock/item"

                XmlRole { name: "name"; query: "name/string()" }
            }
            textRole: "name"
            onActivated: function() {
                quantityTextField.focus = true;
                selectedStockItem = currentText;
                selectedStockItemIndex = currentIndex;
                selectedStockItemTotalQuantity = stockItemsModel.get(currentIndex).quantity;
                selectedStockItemCost = stockItemsModel.get(currentIndex).cost;

                quantityTextField.clear();
                totalQuantityLabel.text = "";
                selectedItemTotalCostLabel.text = "";
                totalQuantityLabel.text = selectedStockItemTotalQuantity.toString();

                console.log(currentIndex, " ", selectedStockItem);
            }

        }

        Label {
            id: quantityTextFieldLabel
            anchors.left: availableStockItems.right
            anchors.leftMargin: 40
            color: "#90a4ae"
            font.pixelSize: 15
            text: "Quantity"
        }

        TextField {
            id: quantityTextField
            implicitWidth: 30
            anchors.left: quantityTextFieldLabel.right
            anchors.leftMargin: 20
            placeholderText: "0"
            validator: IntValidator {
                bottom: 0
                top: selectedStockItemTotalQuantity
            }
            onTextChanged: function() {
                selectedStockItemTotalCost = parseInt(quantityTextField.text) * selectedStockItemCost;
                if ( quantityTextField.text.length > 0 )  {
                    selectedItemTotalCostLabel.text = "Ksh " + selectedStockItemTotalCost;
                } else {
                    selectedItemTotalCostLabel.text = "Ksh 0";
                }
                selectedStockItemQuantity = parseInt(quantityTextField.text);
            }
            onAccepted: function() {
                selectedStockItemTotalCost = parseInt(quantityTextField.text) * selectedStockItemCost;
                selectedStockItemQuantity = parseInt(quantityTextField.text);
            }

        }

        Label {
            id: quantitySeparatorLabel
            anchors.left: quantityTextField.right
            anchors.leftMargin: 10
            color: "#90a4ae"
            font.pixelSize: 15
            text: "/"
        }

        Label {
            id: totalQuantityLabel
            anchors.left: quantitySeparatorLabel.right
            anchors.leftMargin: 5
            font.pixelSize: 15
            text: "0"
        }

        Label {
            id: totalCostLabel
            anchors.left: totalQuantityLabel.right
            anchors.leftMargin: 40
            font.pixelSize: 12
            text: "TOTAL"
        }

        Rectangle {
            id: totalCostRectangle
            anchors.left: totalCostLabel.right
            anchors.leftMargin: 5
            height: 30
            width: 100
            color: "transparent"
            border.width: 1
            border.color: "#90a4ae"
            Label {
                id: selectedItemTotalCostLabel
                anchors.centerIn: parent
                font.pixelSize: 15
            }
        }

        Button {
            id: sellButton
            anchors.left: totalCostRectangle.right
            anchors.leftMargin: 40
            text: "ADD TO PURCHASES"
            enabled: parseInt(quantityTextField.text) > 0 ? true : false
            onClicked: function() {
                selectedItemRemaining = selectedStockItemTotalQuantity - selectedStockItemQuantity;
                purchasesListTotalCost = purchasesListTotalCost + selectedStockItemTotalCost;

                var purchasesListObject = {
                    itemName: selectedStockItem,
                    itemQty: selectedStockItemQuantity,
                    itemCost: selectedStockItemTotalCost
                };

                purchasesListModel.append(purchasesListObject);

                purchasesTotalCost.text = "Ksh " + purchasesListTotalCost.toString();

            }
        }
    }

    RowLayout {
        id: titleRow
        anchors.left: parent.left
        anchors.top: controlsRow.bottom
        anchors.topMargin: 50
        width: stockItemsViewWidth
        height: 60

        Label {
            anchors.centerIn: parent
            color: "#f3f3f4"
            font.pixelSize: 25
            text: "Current Stock"
        }
    }

    SellToolBar {
        id: sellToolBarRow
        headerRectWidth: itemDisplayRectWidth
        width: stockItemsViewWidth
        height: 20
        anchors.left: parent.left
        anchors.top: titleRow.bottom
        anchors.topMargin: 20

    }

    ListView {
        id: stockItemsView
        clip: true
        width: stockItemsViewWidth
        height: Math.round(parent.height / 1.8)
        anchors.top: sellToolBarRow.bottom
        anchors.topMargin: 20
        anchors.left: parent.left
        model: stockItemsModel
        delegate: stockItemsDelegate
        ScrollBar.vertical: ScrollBar {
            active: true
        }
    }

    XmlListModel {
        id: stockItemsModel
        source: "qrc:/stock.xml"
        query: "/stock/item"

        XmlRole { name: "serialNo"; query: "sNo/string()" }
        XmlRole { name: "name"; query: "name/string()" }
        XmlRole { name: "description"; query: "description/string()" }
        XmlRole { name: "model"; query: "model/string()" }
        XmlRole { name: "quantity"; query: "quantity/number()" }
        XmlRole { name: "cost"; query: "cost/number()" }
    }

    Component {
        id: stockItemsDelegate

        Item {
            width: parent.width
            height: 60
            RowLayout {
                height: parent.height - 2
                width: parent.width

                Rectangle {
                    id: itemSerialNoDisplayRect
                    height: parent.height
                    width: Math.round(itemDisplayRectWidth / 5)
                    color: "transparent"
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    Rectangle {
                        anchors.centerIn: parent
                        height: numberText.font.pixelSize + 10
                        width: numberText.font.pixelSize + 10
                        color: "transparent"
                        border.width: 1
                        border.color: serialNoTextColor
                        Text {
                            id: numberText
                            anchors.centerIn: parent
                            font.pixelSize: 15
                            color: serialNoTextColor
                            text: serialNo
                            wrapMode: Text.WordWrap
                        }
                    }
                }

                Rectangle {
                    id: itemNameDisplayRect
                    height: parent.height
                    width: itemDisplayRectWidth
                    color: "transparent"
                    anchors.left: itemSerialNoDisplayRect.right
                    anchors.leftMargin: 20
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: 15
                        color: "#f3f3f4"
                        text: name
                        width: parent.width - 20
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: itemDescDisplayRect
                    height: parent.height
                    width: itemDisplayRectWidth
                    color: "transparent"
                    anchors.left: itemNameDisplayRect.right
                    anchors.leftMargin: 20
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: 15
                        color: "#f3f3f4"
                        text: description
                        width: parent.width - 20
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: itemModelDisplayRect
                    height: parent.height
                    width: Math.round(itemDisplayRectWidth / 2)
                    color: "transparent"
                    anchors.left: itemDescDisplayRect.right
                    anchors.leftMargin: 20
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: 15
                        color: "#f3f3f4"
                        text: model
                        width: parent.width - 20
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: itemQtyDisplayRect
                    height: parent.height
                    width: Math.round(itemDisplayRectWidth / 2)
                    color: "transparent"
                    anchors.left: itemModelDisplayRect.right
                    anchors.leftMargin: 20
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: 15
                        color: "#f3f3f4"
                        text: quantity
                        width: parent.width - 20
                        wrapMode: Text.WordWrap
                    }
                }

                Rectangle {
                    id: itemCostDisplayRect
                    height: parent.height
                    width: Math.round(itemDisplayRectWidth / 2)
                    color: "transparent"
                    anchors.left: itemQtyDisplayRect.right
                    anchors.leftMargin: 20
                    Text {
                        anchors.centerIn: parent
                        font.pixelSize: 15
                        color: "#f3f3f4"
                        text: cost
                        width: parent.width - 20
                        wrapMode: Text.WordWrap
                    }
                }
            }

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                height: 1
                color: "white"
                opacity: 0.5
            }
        }
    }

    RowLayout {
        id: purchasesListRowTitle
        anchors.right: parent.right
        anchors.top: controlsRow.bottom
        anchors.topMargin: 80
        width: parent.width - (stockItemsViewWidth + 20)
        height: 70

        Label {
            id: shoppingCartLabel
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            color: "#f3f3f4"
            font.pixelSize: 20
            text: "Shopping Cart"
        }

        Image {
            id: shoppingCart
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.Pad
            source: "qrc:/assets/icons/cart2.png"
        }

        NotificationIcon {
            id: shoppingCartItemNumber
            x: shoppingCart.x + (shoppingCart.width - 5)
            y: shoppingCart.y + 10
            z: 1
            runTimer: false
            iconSize: 20
            iconBgColor: "#78add2"
            visible: purchasesListModel.count > 0
            notificationNum: String(purchasesListModel.count)
        }

    }



    Rectangle {
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: purchasesListRowTitle.bottom
        anchors.topMargin: 20
        width: parent.width - (stockItemsViewWidth + 40)
        height: Math.round(parent.height / 1.8)
        color: Qt.rgba(0, 0, 0, 0.5)

        PurchasesListToolBar {
            id: purchasesListToolBarRow
            headerRectWidth: purchasesDisplayRectWidth
            width: parent.width
            height: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter

        }

        ListView {
            id: purchasesListView
            visible: purchasesListModel.count > 0 ? true : false
            width: parent.width
            anchors.top: purchasesListToolBarRow.bottom
            anchors.topMargin: 20
            height: Math.round(parent.height / 1.7)
            clip: true
            model: purchasesListModel
            delegate: purchasesListDelegate
            ScrollIndicator.vertical: ScrollIndicator { }
        }

        ListModel {
            id: purchasesListModel
        }

        Component {
            id: purchasesListDelegate

            Item {
                width: parent.width
                height: 60

                RowLayout {
                    height: parent.height - 2
                    width: parent.width

                    Rectangle {
                        id: itemNoDisplayRect
                        height: parent.height
                        width: Math.round(purchasesDisplayRectWidth / 5)
                        color: "transparent"
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        Rectangle {
                            anchors.centerIn: parent
                            height: numberText.font.pixelSize + 10
                            width: numberText.font.pixelSize + 10
                            color: "transparent"
                            border.width: 1
                            border.color: serialNoTextColor
                            Text {
                                id: numberText
                                anchors.centerIn: parent
                                font.pixelSize: 14
                                color: serialNoTextColor
                                text: (index + 1).toString()
                                wrapMode: Text.WordWrap
                            }
                        }
                    }

                    Rectangle {
                        id: itemDisplayRect
                        height: parent.height
                        width: purchasesDisplayRectWidth
                        color: "transparent"
                        anchors.left: itemNoDisplayRect.right
                        anchors.leftMargin: 20
                        Text {
                            anchors.centerIn: parent
                            font.pixelSize: 14
                            color: "#f3f3f4"
                            text: itemName
                            width: parent.width - 20
                            wrapMode: Text.WordWrap
                        }
                    }

                    Rectangle {
                        id: itemQDisplayRect
                        height: parent.height
                        width: Math.round(purchasesDisplayRectWidth / 2)
                        color: "transparent"
                        anchors.left: itemDisplayRect.right
                        anchors.leftMargin: 20
                        Text {
                            anchors.centerIn: parent
                            font.pixelSize: 14
                            color: "#f3f3f4"
                            text: itemQty
                            width: parent.width - 20
                            wrapMode: Text.WordWrap
                        }
                    }

                    Rectangle {
                        id: itemCstDisplayRect
                        height: parent.height
                        width: Math.round(purchasesDisplayRectWidth / 2)
                        color: "transparent"
                        anchors.left: itemQDisplayRect.right
                        anchors.leftMargin: 20
                        Text {
                            anchors.centerIn: parent
                            font.pixelSize: 14
                            color: "#f3f3f4"
                            text: itemCost
                            width: parent.width - 20
                            wrapMode: Text.WordWrap
                        }
                    }

                    Button {
                        id: removePurchasedItemButton
                        anchors.left: itemCstDisplayRect.right
                        anchors.leftMargin: 20
                        text: "Remove"
                        onClicked: function() {
                            purchasesListTotalCost = purchasesListTotalCost - purchasesListModel.get(index).itemCost;
                            purchasesListModel.remove(index);
                            purchasesTotalCost.text = "Ksh " + purchasesListTotalCost.toString();
                        }
                    }

                }

                Rectangle {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 20
                    anchors.rightMargin: 20
                    height: 1
                    color: "yellow"
                    opacity: 0.5
                }
            }
        }


        Rectangle {
            id: purchasesTotalCostDisplayRect
            height: 30
            width: parent.width - 40
            anchors.top: purchasesListView.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            color: Qt.rgba(255, 0, 0, 0.3)

            Label {
                id: purchasesTotalCostLabel
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                color: "#f3f3f3"
                text: "TOTAL"
            }

            Label {
                id: purchasesTotalCost
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                color: "#90a4ae"
                text: "Ksh " + purchasesListTotalCost.toString()
            }
        }

        Button {
            id: cancelPurchasesButton
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            anchors.right: okPurchasesButton.left
            anchors.rightMargin: 10
            text: "Cancel"
            onClicked: function() {
                if (purchasesListModel.count > 0) {
                    cancelPurchasesDialog.open();
                } else {
                    console.log("No purchases. Doing nothing.");
                }
            }
        }

        Button {
            id: okPurchasesButton
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            anchors.right: purchasesTotalCostDisplayRect.right
            text: "OK"
            onClicked: function() {
                if (purchasesListModel.count > 0) {
                    okPurchasesDialog.open();
                } else {
                    console.log("No purchases. Doing nothing.");
                }
            }
        }
    }

    Dialog {
        id: cancelPurchasesDialog
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        width: Math.round(parent.width / 3)
        parent: ApplicationWindow.overlay
        modal: true
        focus: true
        title: "CANCEL PURCHASES?"

        standardButtons: Dialog.No | Dialog.Yes

        Label {
            width: parent.width
            text: qsTr("Are you sure you want to cancel these purchases?\n\n")
                + qsTr("NB: This attempt will still be recorded.")
            wrapMode: Label.Wrap
        }

        onAccepted: function () {
            purchasesListModel.clear();
            purchasesListTotalCost = 0;
            purchasesTotalCost.text = "Ksh 0";
            quantityTextField.clear();
            selectedItemTotalCostLabel.text = "";
        }
        onRejected: function() {
            cancelPurchasesDialog.close();
        }
    }

    Dialog {
        id: okPurchasesDialog
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        width: Math.round(parent.width / 3)
        parent: ApplicationWindow.overlay

        modal: true
        title: "TRANSACTION COMPLETED"
        standardButtons: Dialog.Close
        onClosed: function() {
            purchasesListModel.clear();
            purchasesListTotalCost = 0;
            purchasesTotalCost.text = "Ksh 0";
            quantityTextField.clear();
            selectedItemTotalCostLabel.text = "";
        }

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
                text: "You have sold Ksh " + purchasesListTotalCost.toString()
                    + " worth of items."
                wrapMode: Label.Wrap
            }

            Label {
                width: parent.width
                color: "#90a4ae"
                text: "Thank you for choosing Modio Burn to manage your "
                    + "entertainment business."
                wrapMode: Label.Wrap
            }
        }
    }
}
