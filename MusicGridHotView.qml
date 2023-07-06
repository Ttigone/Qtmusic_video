import QtQuick 2.15
import QtQuick.Controls 2.5
//import QtQuick.Layouts 1.3
import QtQml 2.3

Item {

    property alias list: gridRepeater.model
    Grid {
        id: grid_layout
        anchors.fill: parent
        columns: 5             // 5 列
        Repeater {  //  设置  每一个 列
            id: gridRepeater

            Frame {
                padding: 5
                width: parent.width * 0.2
                height: parent.height * 0.2 + 30

                background: Rectangle {
                    id: background
                    color: "#00000000"
                }
                clip: true
                MusicRoundImage {
                    id: img
                    width: parent.width
                    height: parent.width
                    img_src: modelData.coverImgUrl
                }

                Text {
                    height: 30
                    anchors {
                        top: img.bottom
                        horizontalCenter: parent.horizontalCenter
                    }
                    text: modelData.name
                    font {
                        family: window.m_font_family
    //                    pointSize: 10
                    }
                    elide: Qt.ElideMiddle  // 超出部分自动省略  展示中间
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: {
                        background.color = "#50000000"
                    }
                    onExited: {
                        background.color = "#00000000"
                    }
                }
            }

        }
    }
}
