// ************************************************
// 2022, Zadock Maloba <zadock.maloba@stream4.tech>
// ************************************************

import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

AbstractButton {
    id: root
    property bool button_closable: true
    property string button_color: "light grey"

    anchors.topMargin: 2
    anchors.bottomMargin: 2
    anchors.rightMargin: 2
    anchors.leftMargin: 2
    background: Rectangle {
        color: root.button_color
        Thx_Label {
            anchors.fill: parent
            text: qsTr(root.text)
        }
    }
}
