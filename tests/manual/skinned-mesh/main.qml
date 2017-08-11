/****************************************************************************
**
** Copyright (C) 2017 Klaralvdalens Datakonsult AB (KDAB).
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Qt3D module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import Qt3D.Core 2.10
import Qt3D.Render 2.10
import Qt3D.Input 2.0
import Qt3D.Extras 2.10
import QtQuick 2.9

DefaultSceneEntity {
    id: scene

    SkinnedPbrEffect {
        id: skinnedPbrEffect
    }

    SkinnedEntity {
        id: riggedFigure
        effect: skinnedPbrEffect
        source: "qrc:/assets/gltf/2.0/RiggedFigure/RiggedFigure.gltf"
    }

    SkinnedEntity {
        id: riggedSimple
        effect: skinnedPbrEffect
        source: "qrc:/assets/gltf/2.0/RiggedSimple/RiggedSimple.gltf"
        baseColor: "blue"
        transform.scale: 0.05
        transform.translation: Qt.vector3d(0.5, 0.25, 0.0)
        createJointsEnabled: true

        onRootJointChanged: {
            var animation = animationComp.createObject(rootJoint)
            var targetJoint = rootJoint.childJoints[0]
            animation.target = targetJoint
            animation.neutralPos = targetJoint.translation
            animation.running = true
        }

        Component {
            id: animationComp
            SequentialAnimation {
                id: sequentialAnimation
                property variant target: null
                property vector3d neutralPos: Qt.vector3d(0, 0, 0)
                property real dx: 1.0
                loops: Animation.Infinite

                Vector3dAnimation {
                    target: sequentialAnimation.target
                    property: "translation"
                    from: sequentialAnimation.neutralPos.plus(Qt.vector3d(-sequentialAnimation.dx, 0.0, 0.0))
                    to: sequentialAnimation.neutralPos.plus(Qt.vector3d(sequentialAnimation.dx, 0.0, 0.0))
                    duration: 500
                }
                Vector3dAnimation {
                    target: sequentialAnimation.target
                    property: "translation"
                    from: sequentialAnimation.neutralPos.plus(Qt.vector3d(sequentialAnimation.dx, 0.0, 0.0))
                    to: sequentialAnimation.neutralPos.plus(Qt.vector3d(-sequentialAnimation.dx, 0.0, 0.0))
                    duration: 500
                }
            }
        }
    }
}