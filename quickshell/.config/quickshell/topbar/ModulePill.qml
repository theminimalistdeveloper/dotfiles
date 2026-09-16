import QtQuick

Item {
  id: root

  default property alias content: pillContent.data

  signal clicked(var mouse)
  signal rightClicked(var mouse)
  signal wheeled(var wheel)

  property bool hovered: false
  property bool active: false

  implicitHeight: Theme.barHeight - 12

  Item {
    id: pillContent
    anchors.fill: parent
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    onEntered: root.hovered = true
    onExited: root.hovered = false
    onClicked: (mouse) => {
      if (mouse.button === Qt.RightButton) root.rightClicked(mouse)
      else root.clicked(mouse)
    }
    onWheel: (wheel) => root.wheeled(wheel)
  }
}
