import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

ColumnLayout {

    property string targetId: ""
    property string targetType: "10"//album,playlist/detail
    property string name: "-"

    onTargetIdChange: {
        console.log("221")
        if (targetType == "10") {
            load_album()
        } else if (targetType == "1000") {
            load_play_list()
        }

    }


    Rectangle {

        Layout.fillWidth: true
        width: parent.width
        height: 60
        color: "#00000000"
        Text {
            x: 10
            verticalAlignment: Text.AlignBottom
            text: qsTr(targetType == "10" ? "专辑" : "歌单") + name
            font.family: window.m_font_family
            font.pixelSize: 25
        }

    }

    RowLayout {
        height: 200
        width: parent.width
        MusicRoundImage {
            id: play_list_cover
            width: 180
            height: 180
            Layout.leftMargin: 10
        }

        Item {
            Layout.fillHeight: true
            height: parent.height

            Text {
                id: play_list_desc
                width: parent.width * 0.95
                anchors.centerIn: parent
                wrapMode: Text.WrapAnywhere
                font {
                    family: window.m_font_family
                    pixelSize: 14
                }
                maximumLineCount: 4
                elide: Text.ElideRight
                lineHeight: 1.5
            }
        }
    }

    MusicListView {
        id: play_list_list_view
    }

    function load_album() {
//        var url = "playlist/detail?id=" + (target_id.length < 1 ? "32311" : target_id)

        var url = "album?id=" + (targetId.length < 1 ? "32311" : targetId)
        function on_reply(reply) {
            http.onReplySignal.disconnect(on_reply)   // onReplySignal  是 QNetwork 中 信号函数

            var album = JSON.parse(reply).album

            var songs = JSON.parse(reply).songs

            play_list_cover.img_src = album.blurPicUrl

            play_list_desc.text = album.description

            name = "-" + album.name

            play_list_list_view.list = songs.map(item=>{
                                                    return {
                                                         id: item.id,
                                                         name: item.name,
                                                         artist: item.ar[0].name,
                                                         album: item.al.name
                                                     }
                                                 })

        }

        http.onReplySignal.connect(on_reply)
        http.connet(url)
    }

    function load_play_list() {

        var url = "playlist/detail?id=" + (targetId.length < 1 ? "32311" : targetId)

        function on_song_detail_reply(reply) {
            http.onReplySignal.disconnect(on_song_detail_reply)   // onReplySignal  是 QNetwork 中 信号函数

            var songs = JSON.parse(reply).songs

            play_list_list_view.list = songs.map(item=>{
                                                    return {
                                                         id: item.id,
                                                         name: item.name,
                                                         artist: item.ar[0].name,
                                                         album: item.al.name
                                                     }
                                                 })
        }

        function on_reply(reply) {
            http.onReplySignal.disconnect(on_reply)   // onReplySignal  是 QNetwork 中 信号函数

            var play_list = JSON.parse(reply).playlist

            play_list_cover.img_src = play_list.coverImgUrl

            play_list_desc.text = play_list.description

            name = "-" + play_list.name

            var ids = play_list.trackIds.map(item=>item.id).join(",")

            http.onReplySignal.connect(on_song_detail_reply)
            http.connet("song/detail?ids=" + ids)
        }

        http.onReplySignal.connect(on_reply)
        http.connet(url)
    }


}


