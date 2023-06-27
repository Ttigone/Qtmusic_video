import QtQuick 2. 15
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

ApplicationWindow {
    width: 1200
    height: 800
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

