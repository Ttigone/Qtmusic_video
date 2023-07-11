import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQml 2.3

ScrollView {          // 自动化管理窗口
    clip: true      // 当显示页面超出窗口时，自动裁剪
//    background: Rectangle {
//        border.width: 0
//    }

    ColumnLayout {

        Rectangle {

            Layout.fillWidth: true
            width: parent.width
            height: 60
            color: "#00000000"
            Text {
                x: 10
                verticalAlignment: Text.AlignBottom
                text: qsTr("推荐内容")
                font.family: window.m_font_family
                font.pixelSize: 25
            }

        }


        MusicBannerView {
            id: banner_view
            Layout.preferredWidth: window.width - 200
            Layout.preferredHeight: (window.height - 200) * 0.5
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Rectangle {
            Layout.fillWidth: true
            width: parent.width
            height: 60
            color: "#00000000"
            Text {
                x: 10
                verticalAlignment: Text.AlignBottom
                text: qsTr("热门歌单")
                font.family: window.m_font_family
                font.pointSize: 25
            }
        }


        MusicGridHotView {
            id: hot_view
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: (window.width - 200 - 50) * 0.2 * 4 + 30 * 4 + 20
            Layout.bottomMargin: 20
        }


        Rectangle {
            Layout.fillWidth: true
            width: parent.width
            height: 60
            color: "#00000000"
            Text {
                x: 10
                verticalAlignment: Text.AlignBottom
                text: qsTr("新歌推荐")
                font.family: window.m_font_family
                font.pointSize: 25
            }
        }

        MusicGridLatestView {
            id: latest_view
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: (window.width - 200 - 30) * 0.1 * 10 + 20
            Layout.bottomMargin: 20
        }

    }

    Component.onCompleted: {
        get_banner_list()
    }

    function get_banner_list() {

        function on_reply(reply) {
//            console.log(reply)
            http.onReplySignal.disconnect(on_reply)   // onReplySignal  是 QNetwork 中 信号函数

            var banners = JSON.parse(reply).banners

            banner_view.banner_list = banners

            get_hot_list()
        }

        http.onReplySignal.connect(on_reply)
        http.connet("banner")
    }


    function get_hot_list() {

        function on_reply(reply) {
            http.onReplySignal.disconnect(on_reply)   // onReplySignal  是 QNetwork 中 信号函数

            var play_lists = JSON.parse(reply).playlists

            hot_view.list = play_lists

            get_latest_list()

        }

        http.onReplySignal.connect(on_reply)
        http.connet("top/playlist/highquality?limit=20")
    }

    function get_latest_list() {

        function on_reply(reply) {
            http.onReplySignal.disconnect(on_reply)   // onReplySignal  是 QNetwork 中 信号函数

            var latest_list = JSON.parse(reply).data

            latest_view.list = latest_list.slice(0, 30)

        }

        http.onReplySignal.connect(on_reply)
        http.connet("top/song")
    }

}

