import QtQuick 2. 15
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ApplicationWindow {

    id: window

    property int m_window_width: 1200
    property int m_window_height: 800

    property string m_font_family: "宋体"

    width: m_window_width
    height: m_window_height
    visible: true
    title: qsTr("music video");



    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        LayoutHeaderView {
            id: layout_head_view
        }

        PageHomeView {
            id: page_home_view
        }

        LayoutBottonView {
            id: layout_botton_view
        }
    }
}

