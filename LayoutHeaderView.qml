import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ToolBar {
    width: parent.width     // width is parent's width
    Layout.fillWidth: true
    height: 32
    background: Rectangle {
        color: "#00AAAA"
    }

    RowLayout {
        anchors.fill: parent   // average parent width to fill

        ToolButton {
            icon.source: "qrc:/images/music"
            width: 32
            height: 32
        }
        ToolButton {
            icon.source: "qrc:/images/music"
            width: 32
            height: 32
        }
        ToolButton {
            icon.source: "qrc:/images/local"
            width: 32
            height: 32
        }
        Item {
            Layout.fillWidth: true
            height: 32
            Text {
                anchors.centerIn: parent
                font.family: "宋k体"
                font.pointSize: 14
                text: qsTr("css")
            }
        }
        ToolButton {
            icon.source: "qrc:/images/minimize-screen"
            width: 32
            height: 32
        }
        ToolButton {
            icon.source: "qrc:/images/small-screen-white"
            width: 32
            height: 32
        }
        ToolButton {
            icon.source: "qrc:/images/clear"
            width: 32
            height: 32
        }
    }
}
