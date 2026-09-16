import Quickshell
import QtQuick

PanelWindow {
  id: bar

  implicitHeight: Theme.barHeight
  color: "transparent"
  anchors {
    top: true
    left: true
    right: true
  }
  exclusiveZone: implicitHeight

  Rectangle {
    id: capsuleBg

    anchors.fill: parent
    radius: Theme.radius
    color: Theme.base
    opacity: Theme.barOpacity
    border.width: 0
  }

  Workspaces {
    anchors.left: parent.left
    anchors.leftMargin: 16
    anchors.verticalCenter: parent.verticalCenter
  }

  WindowTitle {
    anchors.centerIn: parent
    width: bar.width * 0.4
  }

  Row {
    id: rightSide
    anchors.right: parent.right
    anchors.rightMargin: 16
    anchors.verticalCenter: parent.verticalCenter
    spacing: 6

    Tray {}
    Network {}
    Volume {}
    Battery {}
    SystemStats {}
    Clock {}
  }
}
