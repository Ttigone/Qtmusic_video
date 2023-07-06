import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

Rectangle {

    Layout.fillWidth: true
    width: parent.width
    height: 60
    color: "#00000000"
    Text {
        x: 10
        verticalAlignment: Text.AlignBottom
        text: qsTr("搜索")
        font.family: window.m_font_family
        font.pixelSize: 25
    }

}
