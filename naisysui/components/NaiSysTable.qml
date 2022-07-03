import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import Qt.labs.qmlmodels 1.0

Item {
    id: root

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

    property var locale: Qt.locale()
    property string title: "TABLE"
    property ListModel mdl_data
    property ListModel mdl_header
    property bool showRowNumber: false

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
                        model: mdl_header
                        delegate: Item {
                            height: parent.height
                            width: parent.width / mdl_header.count
                            Text {
                                anchors.centerIn: parent
                                text: qsTr(model["_label"])
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
                                model: mdl_header
                                delegate: Rectangle{
                                    height: parent.height
                                    width: parent.width / mdl_header.count
                                    Text {
                                        //anchors.verticalCenter: parent.verticalCenter
                                        property string displayText: rowDelegate._mdl[model["_val"]]
                                        anchors.centerIn: parent
                                        Component.onCompleted: {
                                            if(model["_label"] === "Date")
                                            {
                                                var _d = Date.fromLocaleString(locale, rowDelegate._mdl[model["_val"]], "yyyyMMddhhmmss");
                                                var _txt = _d.toLocaleString(locale, "dd-MMMM-yyyy");
                                                displayText = _txt;
                                            }
                                            else if(model["_label"] === "Time")
                                            {
                                                var _t = Date.fromLocaleString(locale, rowDelegate._mdl[model["_val"]], "yyyyMMddhhmmss");
                                                var _txtT = _t.toLocaleString(locale, "hh:mm:ss");
                                                displayText = _txtT;
                                            }
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
