import QtQuick 2.15
import QtQuick.Controls 2.5
//import QtQuick.Layouts 1.3
import QtQml 2.3

Item {

    property alias list: gridRepeater.model
    Grid {
        id: grid_layout
        anchors.fill: parent
        columns: 3            // 5 列
        Repeater {  //  设置  每一个 列
            id: gridRepeater

            Frame {
                padding: 5
                width: parent.width * 0.333
                height: parent.height * 0.1

                background: Rectangle {
                    id: background
                    color: "#00000000"
                }
                clip: true
                MusicRoundImage {
                    id: img
                    width: parent.width * 0.25
                    height: parent.width * 0.25
                    img_src: modelData.album.picUrl
                }

                Text {
                    id: name
                    height: 30
                    anchors {
                        left: img.right
                        verticalCenter: parent.verticalCenter
                        bottomMargin: 10
                        leftMargin: 5
                    }
                    text: modelData.artists[0].name
                    font {
                        family: window.m_font_family
                        pixelSize: 11
                    }
                    width: parent.width * 0.72
                    elide: Qt.ElideMiddle  // 超出部分自动省略  展示中间
                }

                Text {
                    height: 30
                    anchors {
                        left: img.right
                        top: name.bottom
                        verticalCenter: parent.verticalCenter
                        bottomMargin: 10
                        leftMargin: 5
                    }
                    text: modelData.name
                    font {
                        family: window.m_font_family
                    }
                    width: parent.width * 0.72
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
