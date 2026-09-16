import Quickshell
import Quickshell.Io
import QtQuick

ModulePill {
  id: root

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }

  Process {
    id: calProc
    command: ["gnome-calendar"]
  }

  implicitWidth: row.width + 24

  Row {
    id: row
    anchors.centerIn: parent
    spacing: 6

    Text {
      anchors.verticalCenter: parent.verticalCenter
      text: "\uf017"
      font.family: Theme.fontFamily
      font.pixelSize: Theme.fontSize
      font.bold: true
      color: Theme.text
    }

    Text {
      anchors.verticalCenter: parent.verticalCenter
      text: Qt.formatDateTime(clock.date, "ddd MMM d  HH:mm")
      font.family: Theme.fontFamily
      font.pixelSize: Theme.fontSize
      font.bold: true
      color: Theme.text
    }
  }

  onClicked: () => calProc.running = true
}
