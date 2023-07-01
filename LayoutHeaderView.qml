import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Window 2.12   // 导入当前系统的界面大小

ToolBar {
    width: parent.width     // width is parent's width
    Layout.fillWidth: true
    height: 32
    background: Rectangle {
        color: "#00AAAA"
    }

    RowLayout {
        anchors.fill: parent   // average parent width to fill

        MusicToolBotton {
            icon_source: "qrc:/images/music"
            tool_tip: "music-video"
            onClicked: {
                pop_about.open()
            }
        }

        MusicToolBotton {
            icon_source: "qrc:/images/about"
            tool_tip: "关于"
            onClicked: {
                Qt.openUrlExternally("https://yiyan.baidu.com")    // 打开 web 链接

            }
        }

        MusicToolBotton {
            id: small_window
            icon_source: "qrc:/images/small-window"
            tool_tip: "小窗播放"
            onClicked: {
                set_window_size(330, 650)

                small_window.visible = false
                normal_window.visible = true
            }
        }

        MusicToolBotton {
            id: normal_window
            icon_source: "qrc:/images/exit-small-window"
            tool_tip: "退出小窗播放"
            visible: false
            onClicked: {

                set_window_size()

                normal_window.visible = false // 已经恢复为正常的窗体, 退出小窗按钮隐蔽
                small_window.visible = true   // 已经恢复为正常的窗体, 小窗按钮同步恢复
            }
        }

        Item {
            Layout.fillWidth: true
            height: 32
            Text {
                anchors.centerIn: parent
                font.family: window.m_font_family
                font.pointSize: 15
                text: qsTr("css")
                color: "#ffffff"    // 文本设置为白色
            }
        }

        MusicToolBotton {
            icon_source: "qrc:/images/minimize-screen"
            tool_tip: "最小化"   // 小窗播放下 退出全屏按钮失效
            onClicked: {
                window.hide()
            }
        }


        MusicToolBotton {
            id: resize_screen
            icon_source: "qrc:/images/small-screen"
            tool_tip: "退出全屏"
            visible: false
            onClicked: {
                set_window_size()
                window.visibility = Window.AutomaticVisibility
                max_screen.visible = true
                resize_screen.visible = false
            }
        }

        MusicToolBotton {
            id: max_screen
            icon_source: "qrc:/images/full-screen"
            tool_tip: "全屏"
            onClicked: {
                window.visibility = Window.Maximized

                max_screen.visible = false
                resize_screen.visible = true
            }
        }

        MusicToolBotton {
            icon_source: "qrc:/images/power"
            tool_tip: "exit"
            onClicked: {
                Qt.quit()
            }
        }
    }

    Popup {
        id: pop_about

        parent: Overlay.overlay
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        width: 250
        height: 230

        background: Rectangle {
            color: "#e9f4ff"
            radius: 5
            border.color: "#2273a7ab"
        }

        contentItem: ColumnLayout {
            width: parent.width
            height: parent.height

            Layout.alignment: Qt.AlignHCenter
            Image {
                source: "qrc:/images/music"
                Layout.preferredHeight: 60
                Layout.fillWidth: true   // 宽度伸缩变换   默认都是 true
                fillMode: Image.PreserveAspectFit
            }

            Text {
                text: "c"
                color: "#8573a7ab"
                font.pixelSize: 16  // 固定字体尺寸
                font.family: window.m_font_family
                font.bold: true   // 斜体
//                Layout.preferredHeight: 60
                Layout.fillWidth: true   // 宽度伸缩变换   默认都是 true
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                text: "dsadjksajdksajkj"
                color: "#8573a7ab"
                font.pixelSize: 16  // 固定字体尺寸
                font.family: window.m_font_family
                font.bold: true   // 斜体
//                Layout.preferredHeight: 60
                Layout.fillWidth: true   // 宽度伸缩变换   默认都是 true
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                text: "是多久啊是的撒娇的撒觉得"
                color: "#8573a7ab"
                font.pixelSize: 16  // 固定字体尺寸
                font.family: window.m_font_family
                font.bold: true   // 斜体
//                Layout.preferredHeight: 60
                Layout.fillWidth: true   // 宽度伸缩变换   默认都是 true
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }


    function set_window_size(width = window.m_window_width, height = window.m_window_height) {
        window.width = width
        window.height = height
        window.x = (Screen.desktopAvailableWidth - window.width) / 2
        window.y = (Screen.desktopAvailableHeight - window.height) / 2

    }
}
