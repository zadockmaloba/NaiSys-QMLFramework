import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12

Item{
    id: root

    property Component cmp_body
    property string cardColor: "light grey"
    property double cardOpacity: 0.8
    property ListModel mdl_header : ListModel{
        ListElement{title:"Employees On Duty"; data:""}
        ListElement{title:"Employees On Leave"; data:""}
        ListElement{title:"Active Job Openings"; data:""}
        ListElement{title:"Active Job Applications"; data:""}
    }

    Item {
        id: root_header
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height * 0.15
        anchors.leftMargin: 2
        anchors.topMargin: 2
        anchors.bottomMargin: 2
        anchors.rightMargin: 2
        RowLayout{
            anchors.fill: parent
            spacing: 2
            Repeater{
                model: mdl_header
                Rectangle{
                    color: cardColor
                    Layout.fillHeight: true; Layout.fillWidth: true
                    opacity: cardOpacity
                    radius: 5
                    Column{
                        anchors.fill: parent
                        Item {
                            width: parent.width
                            height: parent.height * 0.2
                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                text: model["title"]
                                font.pointSize: 12
                                font.family: "Arial"
                                font.bold: true
                                color: "white"
                            }
                        }
                        Item {
                            width: parent.width
                            height: parent.height * 0.8
                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr("text")
                            }
                        }
                    }
                }
            }
        }
    }
    Item{
        id: root_body
        anchors.top: root_header.bottom
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.topMargin: 2
        anchors.leftMargin: 2
        anchors.rightMargin: 2
        anchors.bottomMargin: 2
        Loader{
            id: root_body_loader
            anchors.fill: parent
            sourceComponent: cmp_body
        }
    }
}
