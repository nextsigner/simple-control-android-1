import QtQuick 2.0
import QtQuick.Controls 2.0

ApplicationWindow{
    id: app
    visible: true
    width: 800
    height: 600
    property int fs: width*0.02
    color:'#666666'
    Item{
        id:xApp
        anchors.fill: parent
        Column{
            spacing: app.fs
            width: parent.width
            Row{
                id: r1
                spacing: app.fs
                anchors.horizontalCenter: parent.horizontalCenter
                height: buscador.height
                Text{
                    id: labelBuscar
                    text:'Buscar'
                    font.pixelSize: app.fs
                    anchors.verticalCenter: parent.verticalCenter
                    color: 'white'
                }
                TextField{
                    id: buscador
                    font.pixelSize: app.fs
                    width:app.width-labelBuscar.width-app.fs*2
                    onTextChanged: actualizarLista()
                }
            }
            Text {
                id: cant
                text: 'Resultados: 0'
                font.pixelSize: app.fs
                color: 'white'
            }
            ListView{
                id: lv
                model: lm
                delegate: del
                spacing: app.fs*0.5
                width: parent.width
                height: xApp.height-r1.height-app.fs*2-cant.height
                clip: true
            }
        }
    }
    ListModel{
        id: lm
        function addProd(pid, pnom, pfecha, pprec, pprov){
            return{
                vid: pid,
                vnom: pnom,
                vfecha:pfecha,
                vprec: pprec,
                vprov: pprov
            }
        }
    }
    Component{
        id: del
        Rectangle{
            width: parent.width-app.fs*0.5
            height: txt.contentHeight+app.fs
            radius: app.fs*0.1
            border.width: 2
            anchors.horizontalCenter: parent.horizontalCenter
            color: parseInt(vid)!==-10?'white':'red'
            Text{
                id: txt
                color:parseInt(vid)!==-10?'black':'white'
                font.pixelSize: app.fs
                text: parseInt(vid)!==-10? '<b>id:</b> '+vid+'<br><b>Nombre:</b> '+vnom+'<br><b>Precio:</b> $'+vprec+' <b>Fecha:</b>'+vfecha+'<br><b>Proveedor:</b>'+vprov :'<b>Resultados con palabra:</b> '+vnom
                textFormat: Text.RichText
                width: parent.width-app.fs
                wrapMode: Text.WordWrap
                anchors.centerIn: parent
            }
        }
    }
    Component.onCompleted: {
        console.log('Conectando a '+pws+'/productos.sqlite')
        console.log('Existe archivo sqlite: '+unik.fileExist(pws+'/productos.sqlite'))
        unik.sqliteInit(pws+'/productos.sqlite')
    }
    function actualizarLista(){
        lm.clear()

        var p1=buscador.text.split(' ')
        lm.append(lm.addProd('-10', buscador.text, '', '',''))
        var b='nombre like \'%'
        for(var i=0;i<p1.length;i++){
            b+=p1[i]+'%'
        }
        b+='\''
        var sql='select distinct * from productos where '+b+''
        console.log('Sql: '+sql)

        var rows=unik.getSqlData(sql)
        //console.log('Sql count result: '+rows.length)
        cant.text='Resultados: '+rows.length
        for(i=0;i<rows.length;i++){
            lm.append(lm.addProd(rows[i].col[0], rows[i].col[1], rows[i].col[2], rows[i].col[3], rows[i].col[4]))
        }

        b=''
        for(var i=0;i<p1.length;i++){
            /*if(i===0){
                b+='nombre like \'%'+p1[i]+'%\' '
            }else{
                b+='or nombre like \'%'+p1[i]+'%\' '
            }*/
            lm.append(lm.addProd('-10', p1[i], '', '',''))
            sql='select distinct * from productos where nombre like \'%'+p1[i]+'%\''
            console.log('Sql 2: '+sql)
            var rows2=unik.getSqlData(sql)
            //console.log('Sql count result: '+rows.length)
            //cant.text='Resultados: '+parseInt(rows.length+rows2.length)
            for(var i2=0;i2<rows2.length;i2++){
                lm.append(lm.addProd(rows2[i2].col[0], rows2[i2].col[1], rows2[i2].col[2], rows2[i2].col[3], rows2[i2].col[4]))
            }
        }
    }
}
