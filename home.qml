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
    function newSession() {
        Vars.currentSession = Vars.sessions.length
        Vars.sessions[Vars.currentSession] = {
            series:     [],
            name:       qsTr("Session %1").arg(Vars.currentSession+1),
            warmup:     Vars.settings.warmup,
            stretching: Vars.settings.stretching,
            rest:       Vars.settings.rest
        }
        pageLoader.source="session.qml"
    }
    width: window.width
    height: window.height
    header: ToolBar {
        id: toolbar
        RowLayout {
            anchors.fill: parent
            ToolButton {
                icon.source: "icons/menu.svg"
                onClicked: menu.open()
                Menu {
                    id: menu
                    y: toolbar.height
                    Action {
                        text: qsTr("&Settings")
                        onTriggered: pageLoader.source="settings.qml"
                    }
                }
            }
            Label {
                text: qsTr("Available sessions")
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
            ToolButton {
                icon.source: "icons/add.svg"
                onClicked: newSession()
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
                width: parent.width
                height: contentHeight
                spacing: 10
                model: Vars.sessions
                delegate: Pane {
                    Material.elevation: 6
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 40
                    height: contentHeight+20

                    RowLayout {
                        anchors.fill: parent
                        RoundButton {
                            icon.source: "icons/start.svg"
                            onClicked: function() {
                                Vars.currentSession = index
                                pageLoader.source="play.qml"
                            }
                        }
                        Label {
                            text: modelData.name
                            elide: Label.ElideRight
                            horizontalAlignment: Qt.AlignHCenter
                            verticalAlignment: Qt.AlignVCenter
                            Layout.fillWidth: true
                            MouseArea {
                                anchors.fill: parent
                                onClicked: function() {
                                    Vars.currentSession = index
                                    pageLoader.source="session.qml"
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
                text: qsTr("Add a new session")
                onClicked: newSession()
            }
        }
    }
}
