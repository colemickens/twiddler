import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2

ApplicationWindow {
    title: qsTr("Twiddler")
    width: 1024
    height: 768
    visible: true
    property int margin: 8

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem {
                text: qsTr("&Open")
                onTriggered: messageDialog.show(qsTr("Open action triggered"));
            }
            MenuItem {
                text: qsTr("E&xit")
                onTriggered: Qt.quit();
            }
        }
    }

    ToolBar {
        id: toolbar
        width: parent.width

        Label {
            id: switchLabel
            text: "Capture Traffic"
            anchors.left: parent.left
            anchors.leftMargin: 8
            anchors.verticalCenter: parent.verticalCenter
        }
        Switch {
            id: enabledSwitch
            checked: true
            anchors.left: switchLabel.right
            anchors.leftMargin: 8
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    SplitView {
        anchors.top: toolbar.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom:  statusBar.top
        anchors.margins: 8
        TabView {
            Tab {
                title: "Requests"
                TableView {
                        model: requestsModel
                        anchors.margins: 12
                        anchors.fill: parent
                        frameVisible: true
                        headerVisible: true
                        alternatingRowColors: true
                        TableViewColumn {
                            role: "requestNumber"
                            title: "#"
                            width: 30
                        }
                        TableViewColumn {
                            role: "status"
                            title: "Status"
                            width: 60
                        }
                        TableViewColumn {
                            role: "host"
                            title: "Host"
                            width: 100
                        }
                        TableViewColumn {
                            role: "path"
                            title: "Path"
                            width: 200
                        }
                        TableViewColumn {
                            role: "size"
                            title: "Size"
                            width: 50
                        }
                    }
            }
        }
        TabView {
            Tab {
                title: "Compose"
                ColumnLayout {
                    id: mainLayout
                    anchors.fill: parent
                    anchors.margins: margin
                    
                    RowLayout {
                        GroupBox {
                            id: methodRowBox
                            title: "Method"
                            Layout.fillWidth: true

                            RowLayout {
                                id: methodRowLayout

                                ExclusiveGroup { id: methodGroup }
                                RadioButton {
                                    text: "GET"
                                    checked: true
                                    exclusiveGroup: methodGroup
                                }
                                RadioButton {
                                    text: "POST"
                                    exclusiveGroup: methodGroup
                                }
                                RadioButton {
                                    text: "HEAD"
                                    exclusiveGroup: methodGroup
                                }
                                RadioButton {
                                    text: "OPTIONS"
                                    exclusiveGroup: methodGroup
                                }
                            }
                        }

                        GroupBox {
                            id: protocolGroupBox
                            title: "Protocol"
                            Layout.fillWidth: true

                            RowLayout {
                                id: protocolRowLayout

                                ExclusiveGroup { id: protocolGroup }
                                RadioButton {
                                    text: "HTTP/1.0"
                                    exclusiveGroup: protocolGroup
                                }
                                RadioButton {
                                    text: "HTTP/1.1"
                                    checked: true
                                    exclusiveGroup: protocolGroup
                                }
                            }
                        }
                    }
                    GroupBox {
                        id: pathGroupBox
                        title: "Host+Path"
                        Layout.fillWidth: true

                        RowLayout {
                            anchors.fill: parent
                            TextField {
                                id: pathTextField
                                text: "http://displaycatalog.md.mp.microsoft.com/products/search?language=en&market=us"
                                Layout.fillWidth: true
                            }
                        }
                    }

                    GroupBox {
                        id: headersGroupBox
                        title: "Headers"
                        Layout.fillWidth: true

                        RowLayout {
                            anchors.fill: parent
                            TextArea {
                               Layout.fillWidth: true
                               text: "MS-Contract-Version: 5\r\nAccept-Encoding: text/json"
                            }
                        }
                    }
                    GroupBox {
                        id: bodyGroupBox
                        title: "Body"
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        RowLayout {
                            anchors.fill: parent
                            TextArea {
                               Layout.fillWidth: true
                               Layout.fillHeight: true
                            }
                        }
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        Button {
                            text: "Make Request"
                            Layout.fillWidth: true
                        }
                    }
                }
            }
            Tab {
                    title: "Raw"
                    Rectangle { color: "blue" }
            }
        }
    }

    StatusBar {
        id: statusBar
        anchors.bottom: parent.bottom
        RowLayout {
            anchors.fill: parent
            Label { text: "Read Only" }
        }
    }

    MessageDialog {
        id: messageDialog
        title: qsTr("May I have your attention, please?")

        function show(caption) {
            messageDialog.text = caption;
            messageDialog.open();
        }
    }
}
