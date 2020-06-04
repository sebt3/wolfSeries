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
#include <QFile>
#include <QDir>
#include <QJsonDocument>
#include <QStandardPaths>
#include "datahandler.h"

dataHandler::dataHandler()
{
    QString path = QStandardPaths::standardLocations(QStandardPaths::AppDataLocation)[0];
    QDir d = path;
    if (! d.exists(path))
        d.mkpath(path);
    fileName = path + "/data.json";
    load();
}
void dataHandler::load() {
    QFile file;
    file.setFileName(fileName);
    if (file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QJsonDocument d = QJsonDocument::fromJson(file.readAll());
        file.close();
        data = d.object();
    } else {
        QJsonDocument d = QJsonDocument::fromJson("{}");
        data = d.object();
    }
}
void dataHandler::save() {
    QFile file;
    QJsonDocument d(data);
    file.setFileName(fileName);
    file.open(QIODevice::WriteOnly | QIODevice::Text);
    file.seek(0);
    file.resize(0);
    file.write(d.toJson());
    file.close();
}
QJsonObject dataHandler::getData() const {
    return data;
}
void dataHandler::setData(const QJsonObject &o) {
    data=o;
}

