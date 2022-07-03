import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item {
    id: root
    function newTab(name, source){}

    property int headerHeight: 35
    property ListModel stackModel: ListModel{
      ListElement{name: "Home"; source: ""}
      ListElement{name: "Settings"; source: ""}
    }
    Column{
      id: root_layout
      anchors.fill: parent
      Item{
        id: root_header
        height:headerHeight
        width: parent.width
        Row{
          id: root_header_layout
          anchors.fill: parent
          Repeater{
            model: stackModel
            delegate: Button{
              height: parent.height
              width: 120
              text: model["name"]
            }
          }
        }
      }
      Item{
        id: root_body
        height: parent.height - headerHeight
        width: parent.width
        StackLayout{
          id: root_body_stack
          anchors.fill: parent
        }
      }
    }
}
