import Quickshell
import Quickshell.Io
import QtQuick

ModulePill {
  id: root

  property int cpu: 0
  property int ram: 0
  property int disk: 0
  property int sysTemp: 0
  property string gpuTemp: "--"

  readonly property string cpuIcon: "\uf2db"
  readonly property string ramIcon: "\uefc5"
  readonly property string diskIcon: "\uf0a0"
  readonly property string tempIcon: "\uf2c9"
  readonly property string gpuIcon: "\uf4bc"

  readonly property string sysTempDisplay: root.sysTemp > 0 ? root.sysTemp + "\u00b0" : "--"

  implicitWidth: row.width + 22

  Process {
    id: statsProc
    command: ["sh", "-lc", "exec \"$HOME/.config/scripts/system-stats.sh\""]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        const tokens = this.text.trim().split(/\s+/)
        root.cpu = parseInt(tokens[0], 10) || 0
        root.ram = parseInt(tokens[1], 10) || 0
        root.disk = parseInt(tokens[2], 10) || 0
        root.sysTemp = parseInt(tokens[3], 10) || 0
        const g = parseInt(tokens[4], 10)
        root.gpuTemp = Number.isFinite(g) && g > 0 ? g + "\u00b0" : "--"
      }
    }
  }

  Timer {
    interval: 5000
    running: true
    repeat: true
    onTriggered: statsProc.running = true
  }

  Row {
    id: row
    anchors.centerIn: parent
    spacing: 8

    Row {
      spacing: 3
      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: root.cpuIcon
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
        color: Theme.text
      }
      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: root.cpu + "%"
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
        color: Theme.text
      }
    }

    Row {
      spacing: 3
      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: root.ramIcon
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
        color: Theme.text
      }
      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: root.ram + "%"
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
        color: Theme.text
      }
    }

    Row {
      spacing: 3
      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: root.diskIcon
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
        color: Theme.text
      }
      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: root.disk + "%"
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
        color: Theme.text
      }
    }

    Row {
      spacing: 3
      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: root.tempIcon
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
        color: Theme.text
      }
      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: root.sysTempDisplay
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
        color: Theme.text
      }
    }

    Row {
      spacing: 3
      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: root.gpuIcon
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
        color: Theme.text
      }
      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: root.gpuTemp
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
        color: Theme.text
      }
    }
  }
}
