import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Rectangle {
// 底部工具栏
    Layout.fillWidth: true
    height: 60
//            color: "#CCFFFF"
    color: "#BBBFBF"
    RowLayout {
        anchors.fill: parent
        Item {
            Layout.preferredWidth: parent.width / 10
            Layout.fillWidth: true
        }
        Item {
            Layout.preferredWidth: parent.width / 2
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.topMargin: 25
            Text {
                id: singer_name
                anchors.left: player_slider.left
                anchors.bottom: player_slider.top
                anchors.leftMargin: 5
                text: qsTr("蔡韶山")
                font.family: "方正舒体"
                font.pointSize: 13
                color: "#CCFFFF"
            }
            Text {
                id: song_time
                anchors.right: player_slider.right
                anchors.bottom: player_slider.top
                anchors.rightMargin: 5
                text: qsTr("00:00/05:30")
                font.family: "方正舒体"
                font.pointSize: 13
                color: "#CCFFFF"
            }
            Slider {
                id: player_slider
                width: parent.width
                Layout.fillHeight: true
                Layout.fillWidth: true
                height: 25

                background: Rectangle {   // 覆写进度条
                    x: player_slider.leftPadding
                    y: player_slider.topPadding + (player_slider.availableHeight - height)/ 2
                    width: player_slider.availableWidth
                    height: 4   // 进度条的宽度
                    radius: 2
                    color: "#e9f4ff"
                    Rectangle {
                        width: player_slider.visualPosition * parent.width
                        height: parent.height
                        color: "#FFC0CB"   // 已经播放进度条的颜色
                        radius: 2
                    }
                }

                handle: Rectangle {    // 重写滑块
                    x: player_slider.leftPadding + (player_slider.availableWidth - width) * player_slider.visualPosition
                    y: player_slider.topPadding + (player_slider.availableHeight - height) / 2
                    width: 15
                    height: 15
                    radius: 5
                    color: "#FFC0a1"   // 滑块的填充颜色
                    border.color: "#73a7ab"  // 滑块的边框颜色
                    border.width: 0.5
                }
            }
        }
        MusicIconBotton {
//            Layout.preferredWidth: 50
            icon_source: "qrc:/images/previous"
            icon_width: 32
            icon_height: 32
            tool_tip: "上一首"
        }
        MusicIconBotton {
//            Layout.preferredWidth: 50
            icon_source: "qrc:/images/stop"
            icon_width: 32
            icon_height: 32
            tool_tip: "停止"
        }
        MusicIconBotton {
//            Layout.preferredWidth: 50
            icon_source: "qrc:/images/next"
            icon_width: 32
            icon_height: 32
            tool_tip: "下一首"
        }
        MusicIconBotton {
//            Layout.preferredWidth: 50
            icon_source: "qrc:/images/favorite"
            icon_width: 32
            icon_height: 32
            tool_tip: "最爱"
        }
        MusicIconBotton {
//            Layout.preferredWidth: 50
            icon_source: "qrc:/images/repeat"
            icon_width: 32
            icon_height: 32
            tool_tip: "重复"
        }
        Item {
            Layout.preferredWidth: parent.width / 10
            Layout.fillWidth: true
        }
    }
}
