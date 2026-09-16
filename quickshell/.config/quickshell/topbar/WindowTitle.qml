import QtQuick

Text {
  id: root

  text: BarState.focusedTitle
  color: Theme.text
  font.family: Theme.fontFamily
  font.pixelSize: Theme.fontSize
  font.bold: true
  horizontalAlignment: Text.AlignLeft
  verticalAlignment: Text.AlignVCenter
  elide: Text.ElideRight
  clip: true
}
