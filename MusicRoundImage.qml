import QtQuick 2.15
import QtQuick.Controls 2.5
import Qt5Compat.GraphicalEffects
Item {

    property string img_src: "qrc:/images/player"

    property int border_radius: 5

    Image {
        id: image
        anchors.centerIn: parent
        source: img_src
        smooth: true
        visible: false
        width: parent.width
        height: parent.height
        antialiasing: true
    }

    Rectangle {
        id: mask
        color: "black"
        anchors.fill: parent
        radius: border_radius   // 弧度
        visible: false
        smooth: true
        antialiasing: true
    }


    OpacityMask {
        anchors.fill: image
        source: image
        maskSource: mask
        visible: true
        antialiasing: true
    }
}
