import QtQuick 2.12
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.12
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasma5support as Plasma5Support
import org.kde.plasma.private.mpris as Mpris

PlasmoidItem {
    id: root

    Layout.minimumWidth: units.gridUnit*25
    Layout.minimumHeight: units.gridUnit*5

    Plasmoid.backgroundHints: "NoBackground"

    opacity: plasmoid.configuration.opacity/100


    Representation {
        id: fullView
        anchors.fill: parent
    }


    property string artist: mpris2Model.currentPlayer?.artist ?? ""
    property string track: mpris2Model.currentPlayer?.track
    readonly property int playbackStatus: mpris2Model.currentPlayer?.playbackStatus ?? 0
    readonly property bool isPlaying: root.playbackStatus === Mpris.PlaybackStatus.Playing


    function mediaToggle() {
        mpris2Model.currentPlayer.PlayPause();
    }
    function mediaPrev() {
        mpris2Model.currentPlayer.Previous();

    }
    function mediaNext() {
        mpris2Model.currentPlayer.Next();
    }

    Mpris.Mpris2Model {
        id: mpris2Model
    }
}
