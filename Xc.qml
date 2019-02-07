import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    y: tiUrlBd.focus?0-tiUrlBd.y:0
    onVisibleChanged: {
        tiUrlBd.text=appSettings.urlBd
    }
    MouseArea{
        anchors.fill: parent
        onClicked: r.focus=true
    }
    Column{
        spacing: app.fs*0.5
        anchors.top: parent.top
        anchors.topMargin: app.fs*3
        anchors.horizontalCenter: parent.horizontalCenter
        Text{
            text: '<b>Configurar</b>'
            font.pixelSize: app.fs*1.4
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Item{width: 1; height: app.fs*3}
        Text{
            text: 'Ubicaciòn del Archivo Sqlite'
            font.pixelSize: app.fs
        }
        TextField{
            id: tiUrlBd
            font.pixelSize: app.fs
            width: r.width-app.fs
        }
        Button{
            enabled: appSettings.urlBd!==tiUrlBd.text
            opacity: enabled?1.0:0.5
            text: 'Iniciar'
            onClicked: {
                r.visible=false
                appSettings.urlBd=tiUrlBd.text
                app.iniciarBb()
                app.actualizarLista()
                tiUrlBd.focus=false
            }
        }
        Item{width: 1; height: app.fs}
        Button{
            text: 'Iniciar al inicar Unik'
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                var cfgData='{"arg0" : "-folder='+pws+'/'+app.moduleName+'"}'
                var cfgFile=''+pws+'/cfg.json'
                unik.setFile(cfgFile, cfgData)
                unik.restartApp()
            }
        }
    }

    Rectangle{
        width: app.fs*5
        height: app.fs*1.2
        anchors.left: parent.left
        anchors.leftMargin: app.fs*0.5
        anchors.top: parent.top
        anchors.topMargin:  app.fs*0.5
        border.width: 1
        Text {
            id: txtAtras
            text: ' < Atras'
            textFormat: Text.PlainText
            font.pixelSize: parent.width*0.1
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                r.visible=false
            }
        }
    }
}

