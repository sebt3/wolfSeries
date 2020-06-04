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
    width: window.width
    height: window.height
    Component.onCompleted: function() {
        Vars.settings.warmup    = Vars.settings.warmup      || 180
        Vars.settings.stretching= Vars.settings.stretching  || 180
        Vars.settings.rest      = Vars.settings.rest        || 60
        Vars.settings.count     = Vars.settings.count       || 3
        Vars.settings.exercice  = Vars.settings.exercice    || 30
        Vars.settings.change    = Vars.settings.change      || 5
    }
    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton {
                icon.source: "icons/previous.svg"
                onClicked: pageLoader.source="home.qml"
            }
            Label {
                text: qsTr("Settings")
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
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
                height: contentHeight+60

                Label {
                    text: qsTr("Warm up")
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                }
                SpinBox {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    to: 500
                    stepSize: 5
                    textFromValue: Vars.toMinuts
                    value: Vars.settings.warmup || 180
                    onValueChanged: function() {
                        Vars.settings.warmup= this.value
                    }
                }
            }

            Pane {
                Material.elevation: 6
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width-20
                height: contentHeight+60

                Label {
                    text: qsTr("Stretching")
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                }
                SpinBox {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    to: 500
                    stepSize: 5
                    textFromValue: Vars.toMinuts
                    value: Vars.settings.stretching || 180
                    onValueChanged: function() {
                        Vars.settings.stretching= this.value
                    }
                }
            }

            Pane {
                Material.elevation: 6
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width-20
                height: contentHeight+60

                Label {
                    text: qsTr("Rest between series")
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                }
                SpinBox {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    to: 500
                    stepSize: 5
                    textFromValue: Vars.toMinuts
                    value: Vars.settings.rest || 60
                    onValueChanged: function() {
                        Vars.settings.rest= this.value
                    }
                }
            }

            Pane {
                Material.elevation: 6
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width-20
                height: contentHeight+60

                Label {
                    text: qsTr("Repetition count")
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                }
                SpinBox {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    value: Vars.settings.count || 3
                    onValueChanged: function() {
                        Vars.settings.count= this.value
                    }
                }
            }

            Pane {
                Material.elevation: 6
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width-20
                height: contentHeight+60

                Label {
                    text: qsTr("Exercices")
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                }
                SpinBox {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    to: 500
                    stepSize: 5
                    textFromValue: Vars.toMinuts
                    value: Vars.settings.exercice || 30
                    onValueChanged: function() {
                        Vars.settings.exercice= this.value
                    }
                }
            }

            Pane {
                Material.elevation: 6
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width-20
                height: contentHeight+60

                Label {
                    text: qsTr("Changing")
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                }
                SpinBox {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    to: 60
                    textFromValue: Vars.toMinuts
                    value: Vars.settings.change || 5
                    onValueChanged: function() {
                        Vars.settings.change= this.value
                    }
                }
            }

        }
    }
}
