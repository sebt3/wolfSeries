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
import "vars.js" as Vars

Page {
    function newExercice() {
        var cnt = Vars.sessions[Vars.currentSession].series[Vars.currentSerie].exercices.length
        Vars.sessions[Vars.currentSession].series[Vars.currentSerie].exercices[cnt] = {
            name: "",
            len: Vars.settings.exercice
        }
        exercices.model = Vars.sessions[Vars.currentSession].series[Vars.currentSerie].exercices
    }
    function updateDesc() {
        var d = qsTr("Empty serie")
        Vars.sessions[Vars.currentSession].series[Vars.currentSerie].exercices.forEach(function(e,i){
            if(i===0)
                d= e.name
            else
                d+= " / " + e.name
        })
        Vars.sessions[Vars.currentSession].series[Vars.currentSerie].desc=d
    }
    width: window.width
    height: window.height
    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                icon.source: "icons/previous.svg"
                onClicked: pageLoader.source="session.qml"
            }
            Label {
                text: qsTr("Edit a serie")
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
            ToolButton {
                icon.source: "icons/add.svg"
                onClicked: newExercice()
            }
        }
    }
    ScrollView {
        anchors.fill: parent
        clip: true
        Column {
            width: window.width
            spacing: 10

            ListView {
                id: exercices
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width-20
                height: contentHeight
                spacing: 6
                model: Vars.sessions[Vars.currentSession].series[Vars.currentSerie].exercices
                delegate: Pane {
                    Material.elevation: 6
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 40
                    height: contentHeight+20
                    ColumnLayout {
                        width: parent.width
                    RowLayout {
                        Layout.fillWidth: true
                        TextField {
                            Layout.fillWidth: true
                            placeholderText: qsTr("Enter Exercice name")
                            text: modelData.name
                            onTextChanged: function() {
                                Vars.sessions[Vars.currentSession].series[Vars.currentSerie].exercices[index].name = this.text
                                updateDesc()
                            }
                        }
                        RoundButton {
                            icon.source: "icons/delete.svg"
                            Material.background: Material.Red
                            onClicked: function() {
                                Vars.sessions[Vars.currentSession].series[Vars.currentSerie].exercices.splice(index,1)
                                updateDesc()
                                exercices.model = Vars.sessions[Vars.currentSession].series[Vars.currentSerie].exercices
                            }
                        }
                    }
                    RowLayout {
                        Layout.fillWidth: true
                        Label {
                            text: qsTr("Duration")
                            Layout.fillWidth: true
                        }
                        SpinBox {
                            textFromValue: Vars.toMinuts
                            value: modelData.len
                            onValueChanged: function() {
                                Vars.sessions[Vars.currentSession].series[Vars.currentSerie].exercices[index].len = this.value
                            }
                        }
                    }
                    }
                }
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                font.capitalization: Font.MixedCase
                Material.background: Material.Blue
                icon.source: "icons/add.svg"
                text: qsTr("Add a new exercice")
                onClicked: newExercice()
            }

            Pane {
                Material.elevation: 6
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width-20
                GridLayout {
                    columns: 2
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width
                    Label {
                        text: qsTr("Repetition count")
                        Layout.fillWidth: true
                    }
                    SpinBox {
                        value: Vars.sessions[Vars.currentSession].series[Vars.currentSerie].count
                        onValueChanged: function() {
                            Vars.sessions[Vars.currentSession].series[Vars.currentSerie].count = this.value
                        }
                    }
                    Label {
                        text: qsTr("Changing")
                        Layout.fillWidth: true
                    }
                    SpinBox {
                        textFromValue: Vars.toMinuts
                        value: Vars.sessions[Vars.currentSession].series[Vars.currentSerie].change
                        onValueChanged: function() {
                            Vars.sessions[Vars.currentSession].series[Vars.currentSerie].change = this.value
                        }
                    }
                }
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                font.capitalization: Font.MixedCase
                Material.background: Material.Red
                icon.source: "icons/delete.svg"
                text: qsTr("Delete this serie")
                onClicked: function() {
                    Vars.sessions[Vars.currentSession].series.splice(Vars.currentSerie,1)
                    pageLoader.source="session.qml"
                }
            }

        }
    }
}
