import Quickshell
import Quickshell.Io
import QtQuick

ModulePill {
  id: root

  property string mode: "off"
  property int signal: 0
  property string ssid: ""

  readonly property string icon: root.mode === "wifi" ? "\uf1eb"
                        : root.mode === "ethernet" ? "\uef44"
                        : "\uf071"

  readonly property string statusText: root.mode === "wifi" ? root.signal + "%"
                          : root.mode === "ethernet" ? root.ssid
                          : "OFF"

  implicitWidth: row.width + 22

  Process {
    id: statusProc
    command: ["sh", "-lc", "exec \"$HOME/.config/scripts/network-status.sh\""]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        const tokens = this.text.trim().split(/\s+/)
        root.mode = tokens[0] || "off"
        root.signal = parseInt(tokens[1], 10) || 0
        root.ssid = tokens.slice(2, tokens.length - 1).join(" ")
      }
    }
  }

  Timer {
    interval: 5000
    running: true
    repeat: true
    onTriggered: statusProc.running = true
  }

  Process {
    id: nmProc
    command: ["ghostty", "-e", "nmtui"]
  }

  Row {
    id: row
    anchors.centerIn: parent
    spacing: 6

    Text {
      anchors.verticalCenter: parent.verticalCenter
      text: root.icon
      font.family: Theme.fontFamily
      font.pixelSize: Theme.fontSize
      font.bold: true
      color: Theme.text
    }

    Text {
      anchors.verticalCenter: parent.verticalCenter
      text: root.statusText
      font.family: Theme.fontFamily
      font.pixelSize: Theme.fontSize
      font.bold: true
      color: Theme.text
    }

    Text {
      anchors.verticalCenter: parent.verticalCenter
      visible: root.mode === "wifi"
      text: root.ssid
      font.family: Theme.fontFamily
      font.pixelSize: Theme.fontSize
      font.bold: true
      color: Theme.text
    }
  }

  onClicked: () => nmProc.running = true
}
