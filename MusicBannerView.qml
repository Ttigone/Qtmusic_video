import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQml 2.3

Frame {

    property int current: 0
    property alias banner_list: banner_view.model

    background: Rectangle {
        color: "#00000000"
    }
/*
//    MouseArea {                     // 进入时 鼠标形状发生改变
//        anchors.fill: parent
//        cursorShape: Qt.PointingHandCursor
//        hoverEnabled: true
//        onEntered: {
//            banner_timer.stop()          // 区域 ？
//        }
//        onExited: {
//            banner_timer.start()
//        }
//    }

//    MusicRoundImage {
//        id: left_image
//        width: parent.width * 0.6
//        height: parent.height * 0.8
//        anchors {
//            left: parent.left
//            bottom: parent.bottom
//            bottomMargin: 20
//        }

//        img_src: get_left_image_src()

//        onImg_srcChanged: {
//            left_image_anim.start()
//        }

//        NumberAnimation {
//            id: left_image_anim
//            target: left_image
//            property: "scale"
//            from: 0.8
//            to: 1.0
//            duration: 200
//        }

//        MouseArea {
//            anchors.fill: parent
//            cursorShape: Qt.PointingHandCursor
//            onClicked: {
//                if (banner_list.length > 0) {
//                    current = current == 0 ? banner_list.length - 1 : current - 1
//                }
//            }
//        }
//    }

//    MusicRoundImage {
//        id: center_image
//        width: parent.width * 0.6
//        height: parent.height
//        z: 2                   // z 轴，  垂直与 屏幕 向外
//        anchors.centerIn: parent
//        img_src: get_center_image_src()
//        MouseArea {
//            anchors.fill: parent
//            cursorShape: Qt.PointingHandCursor
//        }

//        onImg_srcChanged: {
//            center_image_anim.start()
//        }

//        NumberAnimation {
//            id: center_image_anim
//            target: center_image
//            property: "scale"
//            from: 0.8
//            to: 1.0
//            duration: 200
//        }

//    }

//    MusicRoundImage {
//        id: right_image
//        width: parent.width * 0.6
//        height: parent.height * 0.8
//        anchors {
//            right: parent.right
//            bottom: parent.bottom
//            bottomMargin: 20
//        }
//        img_src: get_right_image_src()

//        onImg_srcChanged: {
//            right_image_anim.start()
//        }

//        MouseArea {
//            anchors.fill: parent
//            cursorShape: Qt.PointingHandCursor
//            onClicked: {
//                if (banner_list.length > 0) {
//                    current = current == banner_list.length - 1 ? 0  : current + 1
//                }
//            }
//        }

//        NumberAnimation {
//            id: right_image_anim
//            target: right_image
//            property: "scale"
//            from: 0.8
//            to: 1.0
//            duration: 200
//        }
//    }

//    PageIndicator {
//        anchors {
//            top: center_image.bottom
//            horizontalCenter: parent.horizontalCenter
//        }

//        count: banner_list.length
//        interactive: true

//        onCurrentIndexChanged: {
//            current = currentIndex
//        }

//        delegate: Rectangle {
//            width: 20
//            height: 5
//            radius: 5
//            color: (current == index) ? "balck" : "grey"
//            MouseArea {
//                anchors.fill: parent
//                cursorShape: Qt.PointingHandCursor
//                hoverEnabled: true
//                onEntered: {
//                    banner_timer.stop()
//                    current = index
//                }
//                onExited: {
//                    banner_timer.start()
//                }
//            }
//        }
//    }

//    Timer {
//        id: banner_timer
//        running: true
//        interval: 1000
//        repeat: true
//        onTriggered: {
//            if (banner_list > 0) {
//                current = current == banner_list.length ? 0 : current + 1
//            }
//        }
//    }

//    function get_left_image_src() {
//        return banner_list.length ? banner_list[(current - 1 + banner_list.length) % banner_list.length].imageUrl : ""
//    }

//    function get_center_image_src() {
//        return banner_list.length ? banner_list[current].imageUrl : ""
//    }

//    function get_right_image_src() {
//        return banner_list.length ? banner_list[(current + 1 + banner_list.length) % banner_list.length].imageUrl  : ""
//    }
*/
    PathView {
        id: banner_view
        width: parent.width
        height: parent.height

        clip: true

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onEntered: {
                banner_timer.stop()
            }
            onExited: {
                banner_timer.start()
            }
        }

        delegate: Item {
            id: delegate_item

            width: banner_view.width * 0.7
            height: banner_view.height
            z: PathView.z ? PathView.z : 0
            scale: PathView.scale ? PathView.scale : 1.0

            MusicRoundImage {
                id: image
                img_src: modelData.imageUrl
                width: delegate_item.width
                height: delegate_item.height
            }

            MouseArea {                        // 点击  图片改变次序
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    if (banner_view.currentIndex === index) {
                        var item = banner_view.model[index]
                        var targetId = item.targetId + ""
                        var targetType = item.targetType + ""       // 1: 单曲   10: 专辑   1000: 歌单
                        switch(targetType) {
                            case "1":    // 播放单曲
                                break
                            case "10":   // 打开专辑
                                break
                            case "1000":
                                PageHomeView.showPlayList(targetId, targetType)           // BUG
                                break
                        }
                        console.log(targetId, targetType)
                    } else {
                        banner_view.currentIndex = index
                    }
                }
            }

        }

        pathItemCount: 3
        path: banner_path
        preferredHighlightBegin: 0.5         // 高亮开始于 左边 0.5
        preferredHighlightEnd: 0.5           // 高亮结束于 右边 0.5

    }
    Path {
        id: banner_path
        startX: 0
        startY: banner_view.height / 2 - 10

        PathAttribute { name: "z"; value: 0 }        //  z: 0 - 2 - 0
        PathAttribute { name: "scale"; value: 0.6 }   //  scale: 0.6 - 0.85 - 0.6

        PathLine {
            x: banner_view.width / 2
            y: banner_view.height / 2 - 10
        }

        PathAttribute { name: "z"; value: 2 }
        PathAttribute { name: "scale"; value: 0.85 }

        PathLine {
            x: banner_view.width
            y: banner_view.height / 2 - 10
        }


        PathAttribute { name: "z"; value: 0 }
        PathAttribute { name: "scale"; value: 0.6 }

    }

    PageIndicator {    // 索引
        id: indicator
        anchors {
            top: banner_view.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: -10
        }
        count: banner_view.count
        currentIndex: banner_view.currentIndex
        spacing: 10
        delegate: Rectangle {    // 下面索引框的布局
            width: 20
            height: 5
            radius: 5
            color: index === banner_view.currentIndex ? "balck" : "grey"
            Behavior on color {

                ColorAnimation {
                    duration: 200
                }

            }
            MouseArea {            // 移动到对应的索引
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: {
                    banner_view.currentIndex = index
                    banner_timer.stop()
                }
                onExited: {
                    banner_timer.start()
                }
            }
        }

    }

    Timer {
        id: banner_timer
        running: true
        repeat: true
        interval: 2000
        onTriggered: {
            if (banner_view.count > 0) {
                banner_view.currentIndex = (banner_view.currentIndex + 1) % banner_view.count
            }

        }
    }

}

