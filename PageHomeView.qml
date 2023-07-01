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


    Frame {

        Layout.preferredWidth: 200
        Layout.fillHeight: true
        padding: 0
//        leftInset: 0

        background: Rectangle {
            color: "#AA00AAAA"     // boarder   和  width  有冲突
        }

        ColumnLayout {             // 左边界没有 与 Frame 的左边界对齐
            anchors.fill: parent

            Item {

                Layout.fillWidth: true
                Layout.preferredHeight: 150

                MusicRoundImage {              // 头像
                    anchors.centerIn:parent
                    height: 100
                    width:100
                    border_radius: 100         // 弧度
                }

            }

//            RowLayout {
//                Item {
//                    width: -5
//                }

                ListView {   // 列表
                    id:menu_view
                    height: parent.height
                    Layout.fillHeight: true
                    Layout.fillWidth: true
//                    leftMargin: 0
    //                Layout.preferredWidth: 150
    //                visible: false            // 整个列表是往右偏了一点
    //                width: 80
                    model:ListModel {
                        id: menu_view_model
                    }
                    delegate: menu_view_delegate
                    highlight: Rectangle {
                        color: "#aa73a7ab"
                    }
                    highlightMoveDuration: 0   // 切换时间
                    highlightResizeDuration: 0  // 边框可伸缩时的平滑过度时间
                }

//                Item {
//                    width: 200
//                }
//            }

        }

        Component {     // 每个小方块
            id:menu_view_delegate
            Rectangle {                         // Rec 在 Frame 中摆放有问题
                id:menu_view_delegate_item
                height: 50
//                width: 200 // 宽度 不是  frame 的 200
                anchors.left: Frame.left               // 有效  但部分 List 属性失效
                color: "#AA00AAAA"
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
                        color: "#ffffff"
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        color = "#aa73a7ab"
                    }
                    onExited: {
                        color = "#AA00AAAA"
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
            Layout.fillHeight: true
        }
    }

}
