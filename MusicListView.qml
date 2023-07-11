import QtQuick 2.12
import QtQuick.Shapes 1.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQml 2.3

Frame{
    property var list : []
    property int all: 0
    property int page_size: 60
    property int current_page: 0

    property bool favori_table: false
    property bool deletable: false
    property bool show_page_indicator:true

    signal load_more(int offest, int current_page)
    signal favorite_item(int index)
    signal delete_item(int index)

    onListChanged: {
        list_view_model.clear()
        list_view_model.append(list)
    }
    spacing: 0
    background: Rectangle{
//        border.width: 0
        color: "#AAffefd5"
    }
    Layout.fillWidth: true
    Layout.fillHeight: true
    padding: 0
    clip: true

    ListView {
        id:list_view
        anchors.fill: parent
        width: parent.width
        anchors.bottomMargin: 50
        clip: true
        model: ListModel {
            id:list_view_model
        }
        delegate: list_view_delegate
        ScrollBar.vertical: ScrollBar {
            anchors.right: parent.right
        }
        highlight: Rectangle{
            color: "#e9967a"        // 不起作用
        }
        highlightMoveDuration: 0
        highlightResizeDuration: 0
        header: list_view_header
    }

    Component {
        id:list_view_delegate
        Rectangle {
            id:list_view_delegate_item
            color: "#AAffefd5"
            height:45
            width: list_view.width
            Shape {               // 绘制一条边框
                anchors.fill: parent
                ShapePath {
                    strokeWidth: 0
                    strokeColor: "#00008b"
                    strokeStyle: ShapePath.SolidLine
                    startX: 0
                    startY: 45
                    PathLine {
                        x: 0
                        y: 45
                    }
                    PathLine {
                        x: list_view.width
                        y: 45
                    }
                }
            }
            MouseArea {

                RowLayout {
                    width: parent.width
                    height:parent.height
                    spacing: 15
                    x:5

                    Text {
                        text: index + 1 + page_size * current_page
                        horizontalAlignment: Qt.AlignHCenter
                        Layout.preferredWidth: parent.width * 0.05
                        font.family: window.m_font_family
                        font.pointSize: 13
                        color: "black"
                        elide: Qt.ElideRight
                    }
                    Text {
                        text: name
                        Layout.preferredWidth: parent.width * 0.4
                        font.family: window.m_font_family
                        font.pointSize: 13
                        color: "black"
                        elide: Qt.ElideRight
                    }
                    Text {
                        text: artist
                        Layout.preferredWidth: parent.width * 0.15
                        font.family: window.m_font_family
                        font.pointSize: 13
                        color: "black"
                        elide: Qt.ElideMiddle
                    }
                    Text {
                        text: album
                        Layout.preferredWidth: parent.width * 0.15
                        font.family: window.m_font_family
                        font.pointSize: 13
                        elide: Qt.ElideMiddle
                        color: "black"
                    }
                    Item {            //   最右侧的功能按键
                        z:10
                        MouseArea {
                            anchors.fill: parent
                            onClicked:{
                                delegate_item.ListView.view.currentIndex = index
                            }
                        }
                        Layout.preferredWidth: parent.width * 0.15
                        RowLayout {
                            anchors.centerIn: parent
                            MusicIconBotton {
                                icon_width: 16
                                icon_height: 16
                                icon_source: "qrc:/images/pause"
                                tool_tip: "播放"
//                                onClicked: {
//                                    layoutBottomView.playList = list
//                                    layoutBottomView.isPlayingStateCallbackDisabled = true
//                                    layoutBottomView.playMusic(index)
//                                }
                            }
                            MusicIconBotton {
                                id:favoriteButton
                                icon_width: 16
                                icon_height: 16
                                icon_source: "qrc:/images/favorite"
                                tool_tip: "喜欢"
                                onClicked:{
                                    favorite_item(index)
                                }
                            }
                            MusicIconBotton {
                                icon_width: 16
                                icon_height: 16
                                icon_source: "qrc:/images/clear"
                                tool_tip: "删除"
                                onClicked: {
                                    delete_item(index)
                                }
                            }
                        }
                    }
                }

                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor

                onEntered: {
                    color = "#ffdead"
                }
                onExited: {
                    color = "#AAffefd5"         // 设置透明色 使得能够呈现阴影
                }
//                propagateComposedEvents: true

                onClicked:{
                    list_view_delegate_item.ListView.view.currentIndex = index
                }
            }

        }
    }
    Component {
        id:list_view_header
        Rectangle {
            color: "#ffdab9"
            height:45
            width: list_view.width
            RowLayout {
                width: parent.width
                height:parent.height
                spacing: 15
                x:5
                Text{
                    text: "序号"
                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width * 0.05
                    font.family: window.m_font_family
                    font.pointSize: 13
                    color: "white"
                    elide: Qt.ElideRight
                }
                Text{
                    text: "歌曲"
                    Layout.preferredWidth: parent.width * 0.4
                    font.family: window.m_font_family
                    font.pointSize: 13
                    color: "white"
                    elide: Qt.ElideRight
                }
                Text{
                    text: "姓名"
                    Layout.preferredWidth: parent.width * 0.15
                    font.family: window.m_font_family
                    font.pointSize: 13
                    color: "white"
                    elide: Qt.ElideLeft
                }
                Text{
                    text: "专辑"
                    Layout.preferredWidth: parent.width * 0.15
                    font.family: window.m_font_family
                    font.pointSize: 13
                    color: "white"
                    elide: Qt.ElideLeft
                }
                Text{
                    text: "操作"
                    horizontalAlignment: Qt.AlignHCenter
                    Layout.preferredWidth: parent.width * 0.15
                    font.family: window.m_font_family
                    font.pointSize: 13
                    color: "white"
                    elide: Qt.ElideLeft
                }
            }
        }
    }


    Item {
        id:page_button
        visible: list.length !== 0 && all !== 0
        width: parent.width
        anchors.top: list_view.bottom
        anchors.topMargin: 10
        height: 40

        ButtonGroup {                 // 一堆按钮中只能同时选中一个
            buttons: buttons.children
        }

        RowLayout {
            id:buttons
            anchors.centerIn: parent    // 居中填充
            Repeater {
                id:repeater
                model: all / page_size > 9 ? 9 : all / page_size
                Button {
                    Text {
                        anchors.centerIn: parent
                        text:modelData + 1
                        font.family: window.m_font_family
                        font.pointSize: 14
                        color:checked ? "#497563" : "#ffffff"
                    }

                    background: Rectangle {
                        implicitWidth: 30
                        implicitHeight: 30
                        color: checked ? "#e2f0f8" : "#20e9f4ff"
                        radius: 3
                    }

                    checkable: true
                    checked: modelData === current_page
                    onClicked: {
                        if(current_page === index) return
                        load_more(current_page * page_size, index)
                    }
                }
            }
        }
    }
}

