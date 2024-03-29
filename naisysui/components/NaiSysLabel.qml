// ************************************************
// 2022, Zadock Maloba <zadock.maloba@stream4.tech>
// ************************************************

import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root
    property string text: ""
    property string text_size: "p"
    Thx_Text {
        id: root_text
        anchors.centerIn: parent
        text: qsTr(root.text)
        text_size: root.text_size
    }
}
