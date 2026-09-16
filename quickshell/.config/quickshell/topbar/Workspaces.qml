import Quickshell.I3
import QtQuick

Row {
  id: root
  spacing: 6

  Gradient {
    id: activeGradient
    GradientStop { position: 0.0; color: "#99F5F5F7" }
    GradientStop { position: 0.4; color: "#59F5F5F7" }
    GradientStop { position: 0.8; color: "#33F5F5F7" }
    GradientStop { position: 1.0; color: "#14F5F5F7" }
  }

  Repeater {
    model: I3.workspaces

    delegate: Rectangle {
      id: pill

      required property var modelData
      property bool hovered: false

      height: Theme.barHeight - 12
      width: Math.max(30, numberLabel.width + 22)
      radius: 10
      clip: true

      gradient: modelData.focused ? activeGradient : undefined
      color: modelData.focused ? "transparent"
           : modelData.urgent ? Theme.red
           : hovered ? Theme.surface0
           : "transparent"

      Text {
        id: numberLabel
        anchors.centerIn: parent
        text: modelData.number
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
        color: Theme.text
      }

      MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: pill.hovered = true
        onExited: pill.hovered = false
        onClicked: modelData.activate()
      }
    }
  }
}
