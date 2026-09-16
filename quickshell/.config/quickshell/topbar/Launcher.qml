import Quickshell
import QtQuick
import QtQuick.Controls

FloatingWindow {
  id: root

  implicitWidth: 640
  implicitHeight: root.popupHeight
  color: "transparent"
  visible: false
  title: "Launcher"

  property var hostBar: null
  property string query: searchField.text
  property var results: []

  readonly property int padding: 16
  readonly property int searchHeight: 48
  readonly property int rowHeight: 44
  readonly property int maxRows: 8
  readonly property int listSpacing: 10

  readonly property int resultListHeight: Math.min(root.results.length, root.maxRows) * root.rowHeight
  readonly property int popupHeight: root.resultListHeight + root.searchHeight + root.padding * 2 + root.listSpacing * 2 + 1

  readonly property string searchIcon: "\uf002"

  function refresh() {
    const q = root.query.trim().toLowerCase()
    const apps = DesktopEntries.applications.values
    const out = []
    for (const entry of apps) {
      if (entry.noDisplay) continue
      const name = (entry.name || "").toLowerCase()
      const generic = (entry.genericName || "").toLowerCase()
      const comment = (entry.comment || "").toLowerCase()
      const keywords = (entry.keywords || []).join(" ").toLowerCase()
      if (!q || name.includes(q) || generic.includes(q) || comment.includes(q) || keywords.includes(q)) {
        out.push(entry)
      }
    }
    out.sort((a, b) => {
      const an = (a.name || "").toLowerCase()
      const bn = (b.name || "").toLowerCase()
      if (q && an.startsWith(q) !== bn.startsWith(q)) return an.startsWith(q) ? -1 : 1
      return an.localeCompare(bn)
    })
    root.results = out.slice(0, root.maxRows)
    resultList.currentIndex = 0
  }

  function open(bar) {
    root.hostBar = bar
    searchField.clear()
    root.refresh()
    root.visible = true
    searchField.forceActiveFocus()
  }

  function close() {
    root.visible = false
    searchField.clear()
  }

  function toggle(bar) {
    if (root.visible) root.close()
    else root.open(bar)
  }

  function launch(entry) {
    root.close()
    if (!entry) return
    if (entry.runInTerminal) {
      Quickshell.execDetached({
        command: ["ghostty", "-e"].concat(entry.command),
        workingDirectory: entry.workingDirectory,
      })
    } else {
      entry.execute()
    }
  }

  function selectedEntry() {
    if (root.results.length === 0) return null
    const index = Math.min(resultList.currentIndex, root.results.length - 1)
    return root.results[index]
  }

  Connections {
    target: DesktopEntries
    function onApplicationsChanged() {
      root.refresh()
    }
  }

  onQueryChanged: root.refresh()

  FocusScope {
    id: ui
    anchors.fill: parent

    Rectangle {
      id: capsule
      anchors.fill: parent
      radius: 18
      color: Theme.base
      opacity: 0.88
      border.width: 1
      border.color: Qt.rgba(1, 1, 1, 0.08)
      clip: true

      Column {
        id: contentColumn
        anchors.fill: parent
        anchors.margins: root.padding
        spacing: root.listSpacing

        Row {
          width: parent.width
          height: root.searchHeight
          spacing: 10

          Text {
            anchors.verticalCenter: parent.verticalCenter
            text: root.searchIcon
            font.family: Theme.fontFamily
            font.pixelSize: 18
            font.bold: true
            color: Theme.subtext0
          }

          TextField {
            id: searchField
            width: parent.width - 28
            height: parent.height
            placeholderText: "Spotlight Search"
            placeholderTextColor: Theme.subtext0
            color: Theme.text
            font.family: Theme.fontFamily
            font.pixelSize: 18
            selectByMouse: true
            selectionColor: Theme.lavender
            selectedTextColor: "#ffffff"
            focus: true
            background: Rectangle {
              radius: 10
              color: "transparent"
            }

            Keys.onPressed: (event) => {
              if (event.key === Qt.Key_Escape) {
                root.close()
                event.accepted = true
              } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                root.launch(root.selectedEntry())
                event.accepted = true
              } else if (event.key === Qt.Key_Down) {
                if (resultList.currentIndex < root.results.length - 1) resultList.incrementCurrentIndex()
                event.accepted = true
              } else if (event.key === Qt.Key_Up) {
                if (resultList.currentIndex > 0) resultList.decrementCurrentIndex()
                event.accepted = true
              }
            }
          }
        }

        Rectangle {
          width: parent.width
          height: 1
          color: Theme.surface1
        }

        ListView {
          id: resultList
          width: parent.width
          height: root.resultListHeight
          model: root.results
          currentIndex: 0

          delegate: Item {
            id: row
            required property var modelData
            width: resultList.width
            height: root.rowHeight

            property bool isCurrent: row === resultList.currentItem
            property string iconName: row.modelData.icon && row.modelData.icon.charAt(0) !== "/" ? row.modelData.icon : ""
            property string iconPath: row.modelData.icon && row.modelData.icon.charAt(0) === "/" ? row.modelData.icon : ""
            property bool iconVisible: !!(row.iconName || row.iconPath)

            Rectangle {
              id: rowBackground
              anchors.fill: parent
              radius: 10
              color: row.isCurrent ? Theme.lavender : "transparent"
              opacity: row.isCurrent ? 0.9 : 1.0
            }

            Text {
              id: initial
              visible: !row.iconVisible
              anchors.left: parent.left
              anchors.leftMargin: 18
              anchors.verticalCenter: parent.verticalCenter
              text: (row.modelData.name || "?")[0].toUpperCase()
              font.family: Theme.fontFamily
              font.pixelSize: 16
              font.bold: true
              color: row.isCurrent ? "#ffffff" : Theme.subtext0
            }

            ToolButton {
              id: iconButton
              visible: row.iconVisible
              anchors.left: parent.left
              anchors.leftMargin: 12
              anchors.verticalCenter: parent.verticalCenter
              width: 28
              height: 28
              icon.name: row.iconName
              icon.source: row.iconPath
              icon.width: 22
              icon.height: 22
              display: AbstractButton.IconOnly
              flat: true
              hoverEnabled: false
              focusPolicy: Qt.NoFocus
              background: Item {}
            }

            Text {
              id: rowText
              anchors.left: row.iconVisible ? iconButton.right : initial.right
              anchors.right: parent.right
              anchors.leftMargin: 12
              anchors.rightMargin: 16
              anchors.verticalCenter: parent.verticalCenter
              text: row.modelData.name || ""
              elide: Text.ElideRight
              font.family: Theme.fontFamily
              font.pixelSize: 16
              font.bold: true
              color: row.isCurrent ? "#ffffff" : Theme.text
            }

            MouseArea {
              anchors.fill: parent
              hoverEnabled: true
              onEntered: {
                if (row.index !== undefined) resultList.currentIndex = row.index
              }
              onClicked: root.launch(row.modelData)
            }
          }
        }
      }
    }
  }
}
