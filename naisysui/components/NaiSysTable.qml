import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import Qt.labs.qmlmodels 1.0

Item {
    id: root

    function mdlToKeyArray(_mdl){
        var jsarr = [];
        var _count = 0;
        if(_mdl){
            jsarr.push(_mdl.get(0));
            var _keys = jsarr.map(function(element){return Object.keys(element)});
            console.log(_keys[0].length);
            root.columnCount = _keys[0].length;
            return _keys[0];
        }
    }

    function mdlToJsonArr(_mdl){
        var jsarr = [];
        for (var i = 0; i < _mdl.count; ++i) jsarr.push(_mdl.get(i));
        return jsarr;
    }

    function mdlToJsonObj(_mdl){
        var jsarr = {}
        for (var i = 0; i < _mdl.count; ++i) jsarr += (_mdl.get(i));
        return jsarr;
    }

    function formatValues(lbl, val){
        for(var i = 0; i < map_format.count; ++i){
            var mdl = map_format.get(i)
            if(mdl["label"] === lbl){
                return mdl["callback"](val);
            }
        }
        return val;
    }

    property var locale: Qt.locale()
    property string title: "TABLE"
    property int columnCount: 0

    //When using manual headers you will also have to set the column ciunt manually
    property bool automaticHeader: false
    property ListModel mdl_header : ListModel{
        ListElement{label: "First Col."; value: "data1"}
        ListElement{label: "Second Col."; value: "data2"}
        ListElement{label: "Third Col."; value: "data3"}
    }

    property ListModel mdl_data : ListModel{
        ListElement{data1: "abcd"; data2: "abcd"; data3: "abcd"}
        ListElement{data1: "efgh"; data2: "efgh"; data3: "efgh"}
    }

    property bool showRowNumber: false
    property ListModel map_format : ListModel{
        ListElement{label: "data2"; callback: (str)=>{return str.toUpperCase()}}
    }

    Column{
        anchors.fill: parent
        Item{
            id: root_header
            width: parent.width
            height: parent.height * 0.08
            Text {
                anchors.centerIn: parent
                text: qsTr(root.title)
                font.pointSize: 12
                font.bold: true
                font.family: "Arial"
            }
        }
        Item{
            id: root_body
            width: parent.width
            height: parent.height - root_header.height
            Rectangle{
                id: root_body_tableHeader
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: 25
                gradient: Gradient{
                    GradientStop{position: 0; color: "light grey"}
                    GradientStop{position: 1; color: "grey"}
                }
                Row{
                    anchors.fill: parent
                    Repeater{
                        model: automaticHeader ? mdlToKeyArray(mdl_data) : mdl_header
                        delegate: Item {
                            height: parent.height
                            width: parent.width / root.columnCount
                            Text {
                                anchors.centerIn: parent
                                text: automaticHeader ? modelData : qsTr(model["label"])
                                font.family: "Arial"
                                font.pointSize: 10
                                font.bold: true
                            }
                        }
                    }
                }
            }
            Item{
                id: root_body_tableDiv
                anchors.topMargin: root_body_tableHeader.height
                anchors.fill: parent

                ScrollView{
                    anchors.fill: parent
                    ListView{
                        anchors.fill: parent
                        clip: true
                        spacing: 2
                        model: mdl_data
                        delegate: Row{
                            id: rowDelegate
                            property QtObject _mdl: model
                            height: 30
                            width: root_body_tableDiv.width
                            spacing: 2
                            Repeater{
                                model: automaticHeader ? mdlToKeyArray(mdl_data) : mdl_header
                                delegate: Rectangle{
                                    height: parent.height
                                    width: parent.width / root.columnCount
                                    Text {
                                        property string displayLabel:automaticHeader ? modelData : model["value"]
                                        property string displayText: rowDelegate._mdl[displayLabel]
                                        anchors.centerIn: parent
                                        Component.onCompleted: {
                                            var temp = displayText;
                                            displayText = root.formatValues(displayLabel, temp);
                                        }
                                        text: displayText
                                    }
                                }
                            }
                        }
                    }
                }
            }
            //--------------
        }
    }
}
