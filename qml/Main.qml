import QtQuick 2.7
import Ubuntu.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.3

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'exemple-progress-bar.yourname'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    Page {
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('Progress Bar')
        }

    Text {
        id: label1
        text: qsTr("Download...")
        color: "#5E2750"
        anchors{
            verticalCenterOffset: -units.gu(4)
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: units.gu(1)
            right: parent.right
        }
        font.pixelSize: units.gu(2)
        }
    
    Rectangle {
        height: units.gu(5)
        color: "white"
        anchors
        {
        verticalCenter: parent.verticalCenter
        right: parent.right
        left: parent.left
        }
        Rectangle {
            color: "#AEA79F"
            anchors.fill: parent
            border.width: units.gu(1)
            radius: units.gu(1.5)
            border.color: "white"
        }    
        Rectangle {
            id: progressbar1
            color: "#E95420"
            property real value: 50
            anchors{
                rightMargin: parent.width/100*(100-value)
                fill: parent
            }
            border.width: units.gu(1)
            radius: units.gu(1.5)
            border.color: "white"
        }
    }
    }

    Python {
        id: python

        Component.onCompleted: {
        addImportPath(Qt.resolvedUrl('../src/'));
        setHandler('progress', function(ratio) {
            progressbar1.value = ratio;
        });
        setHandler('finished', function() {
            label1.text = qsTr("Download complete");
            progressbar1.color = "#5E2750";
        });

        importModule('example', function () {
           startDownload();
        });
        }
        function startDownload() {
            progressbar1.value = 0.0;
            call('example.downloader.download', function() {});
        }

        onError: {
            console.log('python error: ' + traceback);
        }
    }
}
