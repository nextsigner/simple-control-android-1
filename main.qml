import QtQuick 2.0
import QtQuick.Controls 2.0

ApplicationWindow{
	id: app
	visible: true
	property int fs: width*0.02
	color:'white'
	Item{
		id:xApp
		anchors.fill: app
		Row{
			spacing: app.fs
		Text{
			id: labelBuscar
			text:'Buscar'
			font.pixelSize: app.fs
			
		}
		TextField{
			id: buscador
			font.pixelSize: app.fs
			width:app.width-labelBuscar.width-app.fs
		}
		}
	}
}
