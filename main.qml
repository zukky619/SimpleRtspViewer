import QtQuick 2.15
import QtQuick.Window 2.15
import QtMultimedia 5.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    id: rootId
    width: 1920
    height: 1080
    minimumWidth: 640
    minimumHeight: 480

    visible: true
    title: qsTr("Simple Rtsp Viewer")

    property bool isPlaying : false
    property string rtspUri : "rtsp://127.0.0.1:8554/test"

    MediaPlayer {
        id: videoPlayer
        source: rtspUri
        muted: true
    }

    Column {
        spacing: 5

        Row {
            spacing : 30

            Button {
                id: playButtonId
                text: (isPlaying) ? "Stop" : "Play"
                onClicked: {
                    if (isPlaying === true) {
                        camera1.visible = false
                        videoPlayer.stop()
                        isPlaying = false
                    } else {
                        camera1.visible = true
                        videoPlayer.seek(0)
                        videoPlayer.play()
                        isPlaying = true
                    }
                }
            }

            Button {
                id: urlSetButtonId
                text: "Set"
                onClicked: {
                    rtspUri = urlId.displayText
                }
            }

            Label {
                id: label1Id
                anchors.verticalCenter: parent.verticalCenter
                text: "rtsp url : "
            }

            TextField {
                id: urlId
                text: rtspUri
                width: 400
            }
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: camera1.implicitWidth
            height: camera1.implicitHeight
            color: "gray"

            VideoOutput {
                id: camera1
                anchors.horizontalCenter: parent.horizontalCenter
                height: parent.height

                source: videoPlayer
                visible: false
            }
        }


    }
}
