import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item {
    id: root
    function newTab(m_name, m_source){
      stackModel.append({m_name, m_source});
    }
    function removeTab(m_index) {
        // body...
    }

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
              onClicked{
                root_body_loader.source = model["source"];
              }
            }
          }
        }
      }
      Item{
        id: root_body
        height: parent.height - headerHeight
        width: parent.width
        Loader{
          id: root_body_loader
          anchors.fill: parent
        }
      }
    }
}
