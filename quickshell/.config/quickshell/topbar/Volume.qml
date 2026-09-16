import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

ModulePill {
  id: root

  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }

  readonly property var audioSource: Pipewire.defaultAudioSink
  readonly property var audio: audioSource ? audioSource.audio : null
  readonly property int volumePercent: audio ? Math.round(audio.volume * 100) : 0
  readonly property bool isMuted: audio ? audio.muted : false
  readonly property string icon: isMuted ? "\uf026"
                          : volumePercent < 30 ? "\uf025"
                          : volumePercent < 60 ? "\uf027"
                          : "\uf028"

  implicitWidth: row.width + 22

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
      text: root.isMuted ? "MUTE" : root.volumePercent + "%"
      font.family: Theme.fontFamily
      font.pixelSize: Theme.fontSize
      font.bold: true
      color: Theme.text
    }
  }

  onClicked: () => {
    if (root.audio) root.audio.muted = !root.audio.muted
  }

  onWheeled: (wheel) => {
    if (!root.audio) return
    const step = wheel.angleDelta.y > 0 ? 0.05 : -0.05
    root.audio.volume = Math.max(0, Math.min(1.5, root.audio.volume + step))
  }
}
