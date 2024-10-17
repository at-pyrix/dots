import QtQuick 2.15
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15
import org.kde.kirigami as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents3


RowLayout {
    id: fullView
    focus: true

    // loading fonts

     FontLoader {
        id: antonio_Bold
        source: "../fonts/Antonio-Bold.ttf"
    }
    FontLoader {
        id: aller_Lt
        source: "../fonts/Aller_Lt.ttf"
    }
    FontLoader {
        id: aller_Bd
        source: "../fonts/Aller_Bd.ttf"
    }

    Keys.onReleased: {
        if (!event.modifiers) {
            event.accepted = true
            if (event.key === Qt.Key_Space || event.key === Qt.Key_K) {
                root.mediaToggle()
            } else if (event.key === Qt.Key_P) {
                root.mediaPrev()
            } else if (event.key === Qt.Key_N) {
                root.mediaNext()
            } else {
                event.accepted = false
            }
        }
    }

    ColumnLayout {
        Layout.fillWidth: true
        id: fullwidget
        PlasmaComponents3.Label {
            id: title
            text: track
            Layout.fillWidth: true
            font.pixelSize: 20
            font.family: aller_Bd.name
            color: "white"
            lineHeight: 0.8
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
            }
            Rectangle {
                id: separator
                height: 1
                color: "white"
                width: !title.height ? title.height/2 : 100
                anchors.horizontalCenter: parent.horizontalCenter
                       }

            PlasmaComponents3.Label {
                font.family: aller_Lt.name
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                Layout.maximumWidth: 300
                Layout.fillWidth: true
                text: artist
                font.pixelSize: 16
                color: "white"
                lineHeight: 0.8
                elide: Text.ElideRight
                }
            MouseArea {
        // Layout.alignment: Qt.AlignRight
        id: mediaControlsMouseArea
        height: title.height
        Layout.fillWidth: true
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        hoverEnabled: true
                RowLayout {
                id: mediaControls
                opacity: mediaControlsMouseArea.containsMouse
                anchors.horizontalCenter: parent.horizontalCenter
                Behavior on opacity {
                    PropertyAnimation {
                        easing.type: Easing.InOutQuad
                        duration: 150
                    }
                }
                Button {
                    Layout.preferredWidth: fullwidget.height/2
                    Layout.preferredHeight: fullwidget.height/1.5
                    contentItem: Kirigami.Icon {
                        source: "media-skip-backward"
                        color: "white"
                    }
                    padding: 0
                    background: null
                    onClicked: {
                        root.mediaPrev()
                        console.log("prev clicked")
                    }
                }
                Button {
                    Layout.preferredWidth: fullwidget.height/2
                    Layout.preferredHeight: fullwidget.height/1.5
                    id: playButton
                    contentItem: Kirigami.Icon {
                        source: root.playbackStatus === 0 ? "media-playback-pause" : "media-playback-start"
                        color: "white"
                    }
                    padding: 0
                    background: null
                    onClicked: {
                        root.mediaToggle()
                        console.log("pause clicked")
                    }
                }
                Button {
                    Layout.preferredWidth: fullwidget.height/2
                    Layout.preferredHeight: fullwidget.height/1.5
                    contentItem: Kirigami.Icon {
                        source: "media-skip-forward"
                        color: "white"
                    }
                    onClicked: {
                        root.mediaNext()
                        console.log(mediaSource.playbackStatus)
                        console.log("next clicked")
                    }
                    padding: 0
                    background: null
                }
            }
                }
    }
}
