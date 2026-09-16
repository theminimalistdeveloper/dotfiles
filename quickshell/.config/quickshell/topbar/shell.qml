import Quickshell
import Quickshell.I3
import Quickshell.Io
import QtQuick

Scope {
  id: root

  property var bars: ({})
  property var launchers: ({})

  function findFocusedTitle(node) {
    if (!node) return ""
    if (node.focused && (node.type === "con" || node.type === "floating_con")) {
      return node.name || node.app_id || ""
    }
    if (Array.isArray(node.nodes)) {
      for (const child of node.nodes) {
        const title = root.findFocusedTitle(child)
        if (title) return title
      }
    }
    if (Array.isArray(node.floating_nodes)) {
      for (const child of node.floating_nodes) {
        const title = root.findFocusedTitle(child)
        if (title) return title
      }
    }
    return ""
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

  function applyFocusedTitleFromTree(text) {
    try {
      const tree = JSON.parse(text)
      BarState.focusedTitle = root.findFocusedTitle(tree)
    } catch (_) {}
  }

  I3IpcListener {
    subscriptions: ["window", "workspace"]
    onIpcEvent: (event) => {
      if (event.type !== "window") return
      try {
        const data = JSON.parse(event.data)
        if (data.change === "focus" && data.container && data.container.focused) {
          BarState.focusedTitle = data.container.name || data.container.app_id || ""
        }
      } catch (_) {}
    }
  }

  Process {
    id: titleInitialProc
    command: ["swaymsg", "-t", "get_tree"]
    stdout: StdioCollector {
      onStreamFinished: root.applyFocusedTitleFromTree(this.text)
    }
  }

  Timer {
    interval: 300
    running: true
    onTriggered: {
      if (!titleInitialProc.running) titleInitialProc.running = true
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
