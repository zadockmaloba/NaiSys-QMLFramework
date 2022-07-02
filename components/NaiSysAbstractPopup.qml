import QtQuick 2.12
import QtQuick.Controls
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12

Popup{
    id: root
    property Component cmp_delegate

    function setActicveComponent(comp){
        contentloader.sourceComponent = comp;
    }

    Loader{
        id: contentloader
        anchors.fill: parent
        sourceComponent: cmp_delegate
    }
}
