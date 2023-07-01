import QtQuick 2.15
import QtQuick.Controls 2.5

ToolButton {

    property string icon_source: ""

    property string tool_tip: ""

    property bool is_checkable: false
    property bool is_checked: false


    id: self

    icon.source: icon_source

    background: Rectangle {   // 按钮按动的变化
        color: self.down || (is_checkable && self.checked) ? "#eeeeee" : "#00000000"    // 三目表达式
        radius: 3
    }

    icon.color: self.down || (is_checkable && self.checked) ? "#00000000" : "#eeeeee"    // 三目表达式

    ToolTip.visible: hovered
    ToolTip.text: tool_tip    // 气泡提示框

    checkable: is_checkable

    checked: is_checked
}
