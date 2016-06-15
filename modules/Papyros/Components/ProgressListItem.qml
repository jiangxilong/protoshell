/*
 * Papyros Shell - The desktop shell for Papyros following Material Design
 * Copyright (C) 2015 Michael Spencer
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
import QtQuick 2.0
import Material 0.2
import Material.ListItems 0.1

BaseListItem {
        id: listItem

        height: dp(72)

        property alias text: label.text

        property alias value: progressBar.value
        property alias valueText: valueLabel.text

        property alias action: actionItem.children
        property alias secondaryItem: secondaryItem.children

        Item {
                id: actionItem

                anchors {
                        left: parent.left
                        leftMargin: listItem.margins
                        verticalCenter: parent.verticalCenter
                }

                height: width
                width: dp(40)
        }

        dividerInset: actionItem.children.length == 0 ? 0 : listItem.height

    Column {
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            right: parent.right
            rightMargin: listItem.margins
            leftMargin: actionItem.children.length == 0 ? listItem.margins : listItem.margins + dp(56)
        }

        spacing: dp(3)

        Item {
            width: parent.width
            height: childrenRect.height
            Label {
                id: label

                elide: Text.ElideRight
                style: "subheading"

                width: valueLabel.text || secondaryItem.children.length > 0
                       ? Math.min(implicitWidth, parent.width * 0.8) : parent.width
            }

            Label {
                id: valueLabel

                color: Theme.light.subTextColor
                elide: Text.ElideRight
                anchors.left: label.right
                anchors.leftMargin: dp(16)
                anchors.right: parent.right
                horizontalAlignment: Text.AlignRight

                style: "body1"
                visible: text != ""
            }

            Item {
                id: secondaryItem
                anchors.right: parent.right
                height: parent.height
                width: parent.width * 0.2
            }
        }

        Item {
            width: parent.width
            height: progressBar.height > 0 ? dp(20) : 0

            ProgressBar {
                id: progressBar

                width: parent.width
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
