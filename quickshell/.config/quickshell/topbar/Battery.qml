import Quickshell.Services.UPower
import QtQuick

ModulePill {
  id: root

  readonly property var battery: UPower.displayDevice
  readonly property bool hasBattery: battery && battery.isLaptopBattery
  readonly property bool isCharging: battery ? battery.state === UPowerDeviceState.Charging : false
  readonly property bool isFull: battery ? battery.state === UPowerDeviceState.FullyCharged : false
  readonly property int percent: battery ? Math.round(battery.percentage) : 0

  readonly property string icon: isCharging ? "\uf0e7"
                          : percent >= 95 ? "\uf244"
                          : percent >= 70 ? "\uf243"
                          : percent >= 45 ? "\uf242"
                          : percent >= 20 ? "\uf241"
                          : "\uf240"

  readonly property bool low: hasBattery && !isCharging && percent <= 20

  visible: hasBattery
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
      text: root.percent + "%"
      font.family: Theme.fontFamily
      font.pixelSize: Theme.fontSize
      font.bold: true
      color: Theme.text
    }
  }
}
