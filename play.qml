/*
 * BSD 3-Clause License
 *
 * Copyright (c) 2020, Sébastien Huss
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * * Redistributions of source code must retain the above copyright notice, this
 *   list of conditions and the following disclaimer.
 *
 * * Redistributions in binary form must reproduce the above copyright notice,
 *   this list of conditions and the following disclaimer in the documentation
 *   and/or other materials provided with the distribution.
 *
 * * Neither the name of the copyright holder nor the names of its
 *   contributors may be used to endorse or promote products derived from
 *   this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtMultimedia 5.12
import "vars.js" as Vars

Page {
    Component.onCompleted: function() {
        Vars.run=[]
        Vars.rid=0
        var all = Vars.sessions[Vars.currentSession]
        var gr = Material.color(Material.Green)
        var or = Material.color(Material.Orange)
        var rd = Material.color(Material.Red)
        if (all.warmup>0)
            Vars.run.push({
                name: qsTr("Warm up"),
                len: all.warmup,
                color: gr
            })
        all.series.forEach(function(s,i) {
            if (i>0 && all.rest>0)
                Vars.run.push({
                    name: qsTr("Rest"),
                    len: all.rest,
                    color: gr
                })
            else if (i>0 && s.change>0)
                Vars.run.push({
                    name: qsTr("Changing"),
                    len: s.change,
                    color: rd
                })
            for(var j=0;j<s.count;j++) {
                s.exercices.forEach(function(e,k){
                    if(s.change>0 && (j>0||k>0))
                        Vars.run.push({
                            name: qsTr("Changing"),
                            len: s.change,
                            color: rd
                        })
                    Vars.run.push({
                        name: e.name,
                        len: e.len,
                        color: or
                    })

                })
            }
        })
        if (all.stretching>0)
            Vars.run.push({
                name: qsTr("Stretching"),
                len: all.stretching,
                color: gr
            })
        updateText()
    }
    function updateText() {
        curName.text= Vars.run[Vars.rid].name
        main.color  = Vars.run[Vars.rid].color
        curTime.text= Vars.toMinuts(Vars.run[Vars.rid].len,Qt.locale())
        if (Vars.rid<Vars.run.length-1 &&  Vars.run[Vars.rid+1].color === Material.color(Material.Orange))
            nextName.text = Vars.run[Vars.rid+1].name
        else if (Vars.rid<Vars.run.length-2 &&  Vars.run[Vars.rid+2].color === Material.color(Material.Orange))
            nextName.text = Vars.run[Vars.rid+2].name
        else
            nextName.text = ""
    }
    width: window.width
    height: window.height
    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                icon.source: "icons/previous.svg"
                onClicked: pageLoader.source="home.qml"
            }
            Label {
                text: Vars.sessions[Vars.currentSession].name
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
            ToolButton {
                icon.source: "icons/start.svg"
                onClicked: function() {
                    timer.running = ! timer.running
                    if (timer.running)
                        this.icon.source="qrc:/icons/pause.svg"
                    else
                        this.icon.source="qrc:/icons/start.svg"
                }
            }
        }
    }
    Timer {
        id: timer
        repeat: true
        onTriggered: function() {
            Vars.run[Vars.rid].len--;
            if(Vars.run[Vars.rid].len===0)
                bip.play()
            if(Vars.run[Vars.rid].len<0)
                Vars.rid++
            updateText()
        }
    }
    SoundEffect {
        id: bip
        source: "sounds/pipe.wav"
    }

    Column {
        anchors.fill: parent
        spacing: 10

        Rectangle {
            id: main
            width: parent.width
            height: parent.height*2/3
            color: Material.color(Material.Green)
            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: parent.height/10
                Text {
                    id: curName
                    font.pixelSize: Math.floor(parent.height/3)
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Text {
                    id: curTime
                    font.bold: true
                    font.pixelSize: Math.floor(parent.height/3)
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
        Rectangle {
            width: parent.width
            height: parent.height/3 - 10
            color: Material.color(Material.Blue)
            Text {
                id: nextName
                font.bold: true
                font.pixelSize: parent.height - 20
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
