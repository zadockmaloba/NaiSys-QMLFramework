import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item {
    function openNewTab(a_name, appsource)
    {
        active_tabs.append({name: a_name, src: appsource})
    }
    function closeCurrTab(m_indx) {
        if(m_indx > 0){
            active_tabs.remove(m_indx)
            renderArea.currentIndex = (m_indx - 1)
        }
    }
    function isTabHome(m_index){
        return m_index !== 0
    }
    Connections{
        function onOpenNewTab(m_name, m_src){
            openNewTab(m_name, m_src)
        }
    }
    //=============================================================
    property ListModel tab_button_model
    property int tab_count
    property string newTabName
    //=============================================================
    ListModel{//MainAppletsArray
        id : apparray
    }
    ListModel{//ActiveTabsArray
        id: active_tabs
        ListElement{name:"Home"; src: "TabHome.qml"}
    }

    id: tabWidg
    Item{
        id: tabRow
        anchors.left: parent.left
        anchors.leftMargin: 2
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: 2
        height: 30
        RowLayout{
            id: mainTab
            anchors.fill: parent
            Repeater{
                model: active_tabs
                ToolButton{
                    //text: active_tabs.get(index).name
                    onClicked:renderArea.currentIndex = index
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Button{
                        id: closetab_btn
                        visible: isTabHome(index)
                        onClicked: closeCurrTab(index)
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 5
                        width: 12
                        height: 12
                        background: Rectangle{
                            radius: 6
                            color: "red"
                        }
                    }
                    background: Rectangle{
                        color: "#eeeeee"
                        radius: 5
                        Text{
                            anchors.centerIn: parent
                            text: model.name
                        }
                    }
                }
            }
        }
    }
    StackLayout{
        id: renderArea
        anchors.top: tabRow.bottom
        anchors.topMargin: 2
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        currentIndex: 0
        Repeater{
            model: active_tabs
            Loader{
                Layout.fillHeight: true; Layout.fillWidth: true
                source: model.src
            }
        }
    }
}
