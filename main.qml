import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3

Window {
    id: window
    visible: true
    width: 800
    height: 600
    title: qsTr("Dark Switch")
    color: "#2c2b30"
    //color: "white"

    DarkAnnotation{
        id: darkSwitch
        anchors.centerIn: parent
    }
}
