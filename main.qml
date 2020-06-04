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
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import "vars.js" as Vars

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    Material.theme: Material.System
    Material.accent: Material.Orange
    Material.primary: Material.Amber
    font.pixelSize: 16

    title: qsTr("Wolf Series")
    Component.onCompleted: function() {
        Vars.currentSerie=0;
        Vars.currentSession=0;
        Vars.sessions = handle.data.sessions || []
        Vars.settings = handle.data.settings || {}
        if (typeof Vars.settings.rest === 'undefined')
            pageLoader.source = "settings.qml"
        else
            pageLoader.source = "home.qml"
    }
    onClosing: function() {
        handle.data = {
            settings: Vars.settings,
            sessions: Vars.sessions
        }
        handle.save();
    }
    Loader {
        id: pageLoader

    }
}
