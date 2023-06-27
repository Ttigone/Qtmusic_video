import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Button {

    property string icon_source: ""

    property string tool_tip: ""

    property bool is_checkable: false
    property bool is_checked: false

    property int icon_width: 32
    property int icon_height: 32


    id: self

    icon.source: icon_source
    icon.width: icon_width
    icon.height: icon_height

    background: Rectangle {   // 按钮按动的变化
        color: self.down || (is_checkable && self.checked) ? "#497563" : "#20e9f4ff"    // 三目表达式
        radius: 3
    }

    icon.color: self.down || (is_checkable && self.checked) ? "#ffffff" : "#e2f0f0"    // 三目表达式

    ToolTip.visible: hovered
    ToolTip.text: tool_tip    // 气泡提示框

    checkable: is_checkable

    checked: is_checked
}
