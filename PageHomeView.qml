import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQml 2.12

RowLayout {

    property var qml_list: [
        { icon: "recommend-white", value: "推荐内容", qml: "DetailRecommendPageView" },
        { icon: "cloud-white", value: "搜索音乐", qml: "DetailSearchPageView" },
        { icon: "local-white", value: "本地音乐", qml: "DetailLocalPageView" },
        { icon: "history-white", value: "播放历史", qml: "DetailHistoryPageView" },
        { icon: "favorite-big-white", value: "我喜欢的", qml: "DetailFavoritePageView" }
    ]


    // 左边
    Frame {

//        Layout.preferredWidth: 200
        Layout.fillHeight: true
        padding: 0
        width: 200
        Layout.margins: 0
//        radius: 0
//        leftInset: 0

        background: Rectangle {
            color: "powderblue"     // boarder   和  width  有冲突
            radius: 0
            border.width: 0
            Layout.margins: 0
        }

//        background: color = "#AA00GGGG"


        ColumnLayout {             // 左边界没有 与 Frame 的左边界对齐
            anchors.fill: parent

            Item {

                Layout.preferredWidth: 200
                Layout.preferredHeight: 150

                MusicRoundImage {              // 头像
                    anchors.centerIn:parent
                    height: 100
                    width:100
                    border_radius: 100         // 弧度
                }

            }

            ListView {   // 列表
                id:menu_view
                height: parent.height
                Layout.fillHeight: true
//                anchors.fill: parent
//                anchors.leftChanged: 0
//                Layout.preferredWidth: 200
//                Layout.fillWidth: true

//                width: parent.width    // 右偏
//                width: 200
//                leftMargin: 0
//                Layout.preferredWidth: 150
//                visible: false            // 整个列表是往右偏了一点
//                width: 80
                model:ListModel {
                    id: menu_view_model
                }
                delegate: menu_view_delegate
                highlight: Rectangle {
                    color: "blue"          // 背景的亮光色
                }
                highlightMoveDuration: 0   // 切换时间
                highlightResizeDuration: 0  // 边框可伸缩时的平滑过度时间
            }

        }

        Component {     // 每个小方块
            id:menu_view_delegate
//            Layout.leftMargin: 0
//            Layout.preferredWidth: true
            Rectangle {                         // Rec 在 Frame 中摆放有问题
                id:menu_view_delegate_item
                height: 50
//                anchors.left: Frame.left               // 有效  但部分 List 属性失效
//                anchors.centerIn: parent
                width: 200 // 宽度 不是  frame 的 200
                color: "#AAb0e0e6"           // 方框原本的颜色
                RowLayout {              // 小方块中的列排列元素       no
                    anchors.fill: parent
                    anchors.centerIn: parent
                    spacing:15
                    Item {
                        width: 30
                    }

                    Image {
                        source: "qrc:/images/" + icon
                        Layout.preferredHeight: 20
                        Layout.preferredWidth: 20
                    }

                    Text {
                        text:value
                        Layout.fillWidth: true
                        height:50
                        font.family: window.m_font_family
                        font.pointSize: 12
                        color: "Coral"
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        color = "skyblue"           // 会  和 方框原本的颜色重叠在一起
                    }
                    onExited: {
                        color = "#AAb0e0e6"
                    }
                    onClicked: {
                        repeater.itemAt(menu_view_delegate_item.ListView.view.currentIndex).visible = false  // 将当前的页面设置为 false
//                        repeater.itemAt(menu_view_delegate_item.ListView.view.currentIndex).color = "#00BBBB" // 将当前的页面设置为 false
                        menu_view_delegate_item.ListView.view.currentIndex = index
                        var loader = repeater.itemAt(index)
                        loader.visible = true
                        loader.source = qml_list[index].qml + ".qml"
//                        Rectangle: {
//                            color = "#00BBBB"
//                        }

//                        menu_view_delegate_item.ListView.view.color = "#00AAAA"
                    }
                }
            }
        }

        Component.onCompleted: {    // 一开始是第一个页面
            menu_view_model.append(qml_list)
            var loader = repeater.itemAt(0)  // 取第一个页面
            loader.visible = true
            loader.source = qml_list[0].qml + ".qml"
        }
    }

    Repeater {   // 页面重叠
        id: repeater
        model: qml_list.length

        Loader {
            visible: false    // 默认为 false 方便切换的时候显示不同的页面
            Layout.fillWidth: true
//            Layout.preferredWidth: true
            Layout.fillHeight: true
        }
    }

}
