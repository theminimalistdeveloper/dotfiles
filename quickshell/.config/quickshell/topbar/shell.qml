import Quickshell
import Quickshell.I3
import Quickshell.Io
import QtQuick

Scope {
  id: root

  property var bars: ({})
  property var launchers: ({})

  function handleRawEvent(event) {
    if (event.type !== "window") return
    const data = event.data
    if (!data || !data.container) return
    if (data.change === "focus" && data.container.focused) {
      BarState.focusedTitle = data.container.name || ""
    }
  }

  function focusedBar() {
    const monitor = I3.focusedMonitor
    if (monitor && root.bars[monitor.name]) return root.bars[monitor.name]
    const keys = Object.keys(root.bars)
    return keys.length > 0 ? root.bars[keys[0]] : null
  }

  function toggleLauncher() {
    const bar = root.focusedBar()
    if (!bar) return

    let anyOpen = false
    for (const name of Object.keys(root.launchers)) {
      if (root.launchers[name].visible) {
        anyOpen = true
        root.launchers[name].close()
      }
    }
    if (!anyOpen) root.launchers[bar.screen.name].open(bar)
  }

  Connections {
    target: I3
    function onRawEvent(event) {
      root.handleRawEvent(event)
    }
  }

  IpcHandler {
    target: "topbar"
    function toggleLauncher(): void {
      root.toggleLauncher()
    }
  }

  Variants {
    model: Quickshell.screens
    delegate: Scope {
      required property var modelData

      Bar {
        id: bar
        screen: modelData
        Component.onCompleted: root.bars[modelData.name] = bar
        Component.onDestruction: delete root.bars[modelData.name]
      }

      Launcher {
        id: launcher
        Component.onCompleted: root.launchers[modelData.name] = launcher
        Component.onDestruction: delete root.launchers[modelData.name]
      }
    }
  }
}
