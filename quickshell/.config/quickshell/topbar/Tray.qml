import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick
import QtQuick.Effects

Row {
  id: root
  spacing: 4

  Repeater {
    model: SystemTray.items

    delegate: ModulePill {
      id: pill

      required property var modelData

      implicitWidth: iconSource.width + 16
      implicitHeight: Theme.barHeight - 10

      MultiEffect {
        id: tint
        anchors.centerIn: parent
        width: 20
        height: 20
        source: iconSource
        colorization: 1.0
        colorizationColor: Theme.text
      }

      IconImage {
        id: iconSource
        anchors.centerIn: parent
        width: 20
        height: 20
        source: modelData.icon
      }

      onClicked: () => modelData.activate()
      onRightClicked: () => modelData.display(pill.Window.window, 0, 0)
    }
  }
}
