import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3


ColumnLayout {
    Layout.fillWidth: true
    Layout.fillHeight: true


    Rectangle {

        Layout.fillWidth: true
        width: parent.width
        height: 60
        color: "#00000000"
        Text {
            x: 10
            verticalAlignment: Text.AlignBottom
            text: qsTr("搜索")
            font.family: window.m_font_family
            font.pixelSize: 25
        }

    }

    RowLayout {


        Layout.fillWidth: true

        TextField {        // 文本输入框
            id: search_input
            font.family: window.m_font_family
            font.pixelSize: 17
            selectByMouse: true      // 鼠标选择文本
            selectionColor: "#999999"             // 选中文本的背景色
            color: "#000000"
            placeholderText: qsTr("请输入搜索关键词")   // 提示词
            background: Rectangle {
                color: "#00000000"
                opacity: 0.5         // 不透明度
                implicitWidth: 300
                implicitHeight: 27
            }
            focus: true

            Keys.onPressed: if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) do_search()

        }

        MusicIconBotton {
            icon_source: "qrc:/images/search"
            tool_tip: "搜索"
            onClicked: do_search()
        }
    }


    MusicListView {
        id: search_list_view
        onLoad_more: do_search(offest, current_page)
//        Layout.topMargin: 10
    }



    function do_search(offset = 0, current_page = 0) {

        var key_words = search_input.text

        if (key_words.length < 1) return

        function on_reply(reply) {
            http.onReplySignal.disconnect(on_reply)   // onReplySignal  是 QNetwork 中 信号函数
            console.log(reply)
            var song_lists = JSON.parse(reply).result.songs
            var result = JSON.parse(reply).result
            var songs_list_count = result
            search_list_view.current_page = current_page
            search_list_view.all = result.songCount
            search_list_view.list = song_lists.map(item=>{
                                                       return {
                                                           id: item.id,
                                                           name: item.name,
                                                           artist: item.artists[0].name,
                                                           album: item.album.name
                                                       }
                                                   })
        }

        http.onReplySignal.connect(on_reply)
        http.connet("search?keywords=" + key_words + "&offset=" + offset + "&limit=30")
    }

}



