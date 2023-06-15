import QtQuick
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ApplicationWindow {
    width: 1200
    height: 800
    visible: true
    title: qsTr(tr("music video"));


    ToolBar {
        width: parent.width     // width is parent's width
        Layout.fillWidth: true
        height: 32
//        width: 320
        RowLayout {
//            anchors.fill: parent   // average parent width to fill

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
                icon.source: "qrc:/images/music"
                width: 32
                height: 32
            }
            Item {
                Layout.fillWidth: true
                width: 32
            }
        }

    }
}

