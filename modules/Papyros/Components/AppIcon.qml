/*
* Papyros Shell - The desktop shell for Papyros following Material Design
* Copyright (C) 2015 Michael Spencer <sonrisesoftware@gmail.com>
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>.
*/
import QtQuick 2.2
import QtQuick.Window 2.0
import Material 0.2
import Papyros.Desktop 0.1

Item {
    property string iconName
    property string name
    property bool hasIcon
    property alias asynchronous: icon.asynchronous

    Image {
        id: icon
        anchors.fill: parent
        source: iconSource()
        visible: status == Image.Ready
        cache: false

        function iconSource() {
            return iconName.indexOf('/') == 0 ? iconName
                                               : hasIcon ? "image://desktoptheme/" + iconName : ""
        }

        Connections {
            target: DesktopFiles
            onIconThemeChanged: {
                icon.source = ''
                icon.source = Qt.binding(function() {
                    return icon.iconSource()
                })
            }
        }

        sourceSize {
            width: Math.max(16, icon.width * Screen.devicePixelRatio)
            height: Math.max(16, icon.height * Screen.devicePixelRatio)
        }
    }

    Rectangle {
        anchors.centerIn: parent
        width: parent.width * 0.8
        height: width
        radius: width/2
        visible: !icon.visible
        color: {
            if (name === "") {
                return Palette.colors["blue"]["400"]
            }

            // Use the last character for uniqueness
            var index = name.toLowerCase().charCodeAt(name.length - 1) - "a".charCodeAt(0)

            var colorNames = [
                'red', 'blue', 'teal', 'green', 'orange', 'purple', 'deepPurple', 'indigo',
                'deepOrange', 'grey', 'blueGrey'
            ]
            var colorIndex = index % colorNames.length
            var colorName = colorNames[colorIndex]

            var color = Palette.colors[colorName]

            return color ? color["400"] : Palette.colors["blue"]["400"]
        }

        Label {
            anchors.centerIn: parent
            text: name.toUpperCase().charAt(0)
            style: "title"
            font.pixelSize: parent.width * 0.5
            color: Theme.dark.textColor
        }
    }
}
