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
    function newSerie() {
        Vars.currentSerie = Vars.sessions[Vars.currentSession].series.length
        Vars.sessions[Vars.currentSession].series[Vars.currentSerie] = {
            exercices:  [],
            count:      Vars.settings.count,
            change:     Vars.settings.change,
            desc:       qsTr("Empty serie")
        }
        pageLoader.source="serie.qml"
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
                text: qsTr("Edit a session")
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
            ToolButton {
                icon.source: "icons/add.svg"
                onClicked: newSerie()
            }
        }
    }
    ScrollView {
        anchors.fill: parent
        clip: true
        Column {
            width: window.width
            spacing: 10

            Pane {
                Material.elevation: 6
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width-20
                TextField {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width
                    placeholderText: qsTr("Enter session name")
                    text: Vars.sessions[Vars.currentSession].name
                    onTextChanged: function() {
                        Vars.sessions[Vars.currentSession].name = this.text
                    }
                }
            }

            ListView {
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width-20
                height: contentHeight
                spacing: 6
                model: Vars.sessions[Vars.currentSession].series
                delegate: Pane {
                    Material.elevation: 6
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 40
                    height: contentHeight+60
                    Label {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: modelData.desc
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: function() {
                            Vars.currentSerie = index
                            pageLoader.source="serie.qml"
                        }
                    }
                }
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                font.capitalization: Font.MixedCase
                Material.background: Material.Blue
                icon.source: "icons/add.svg"
                text: qsTr("Add a new serie")
                onClicked: newSerie()
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
                        text: qsTr("Warm up")
                        Layout.fillWidth: true
                    }
                    SpinBox {
                        to: 500
                        stepSize: 5
                        textFromValue: Vars.toMinuts
                        value: Vars.sessions[Vars.currentSession].warmup
                        onValueChanged: function() {
                            Vars.sessions[Vars.currentSession].warmup = this.value
                        }
                    }
                    Label {
                        text: qsTr("Stretching")
                        Layout.fillWidth: true
                    }
                    SpinBox {
                        to: 500
                        stepSize: 5
                        textFromValue: Vars.toMinuts
                        value: Vars.sessions[Vars.currentSession].stretching
                        onValueChanged: function() {
                            Vars.sessions[Vars.currentSession].stretching = this.value
                        }
                    }
                    Label {
                        text: qsTr("Rest between series")
                        Layout.fillWidth: true
                    }
                    SpinBox {
                        to: 500
                        stepSize: 5
                        textFromValue: Vars.toMinuts
                        value: Vars.sessions[Vars.currentSession].rest
                        onValueChanged: function() {
                            Vars.sessions[Vars.currentSession].rest = this.value
                        }
                    }
                }
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                font.capitalization: Font.MixedCase
                Material.background: Material.Red
                icon.source: "icons/delete.svg"
                text: qsTr("Delete this session")
                onClicked: function() {
                    Vars.sessions.splice(Vars.currentSession,1)
                    pageLoader.source="home.qml"
                }
            }
        }
    }
}
