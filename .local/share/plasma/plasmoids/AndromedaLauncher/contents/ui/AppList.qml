/*****************************************************************************
 *   Copyright (C) 2022 by Friedrich Schriewer <friedrich.schriewer@gmx.net> *
 *                                                                           *
 *   This program is free software; you can redistribute it and/or modify    *
 *   it under the terms of the GNU General Public License as published by    *
 *   the Free Software Foundation; either version 2 of the License, or       *
 *   (at your option) any later version.                                     *
 *                                                                           *
 *   This program is distributed in the hope that it will be useful,         *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of          *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           *
 *   GNU General Public License for more details.                            *
 *                                                                           *
 *   You should have received a copy of the GNU General Public License       *
 *   along with this program; if not, write to the                           *
 *   Free Software Foundation, Inc.,                                         *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .          *
 ****************************************************************************/


// Agregar condicion para que los categproes repeater solo se muestren cuando el index sea diferente a 0 para
//evitar que aparesca el listado de a b c de .. abajo de todas las aplicaciones

import Qt5Compat.GraphicalEffects

import QtQuick 2.12
import QtQuick.Controls 2.15

import QtQuick.Layouts 1.0

import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents

import org.kde.kirigami as Kirigami

import org.kde.draganddrop 2.0


ScrollView {
  id: scrollView

  anchors {
  top: parent.top
  }
  width: parent.width
  height: parent.height

  contentWidth: availableWidth //no horizontal scrolling

  property bool grabFocus: false
  property bool showDescriptions: false
  property int iconSize: Kirigami.Units.iconSizes.medium

  property var pinnedModel: [globalFavorites, rootModel.modelForRow(0), rootModel.modelForRow(1)]
  property QtObject allAppsModel

  property var currentStateIndex: Plasmoid.configuration.defaultPage

  property bool hasListener: false
  property bool isRight: true

  property var scrollpositon: 0.0
  property var scrollheight: 0.0

  property var appsCategoriesList: { 

    var categories = [];
    var categoryName;
    var categoryIcon;

    for (var i = 1; i < rootModel.count - 2; i++) {
      categoryName  = rootModel.data(rootModel.index(i, 0), Qt.DisplayRole);
      categoryIcon  = rootModel.data(rootModel.index(i, 0), Qt.DecorationRole);
      categories.push({
        name: categoryName,
        index: i,
        icon: categoryIcon
      });
    }
    scrollView.allAppsModel =  rootModel.modelForRow(1)
    return categories;
  }

  property var currentSelectedCategory: scrollView.appsCategoriesList[currentStateIndex]

  function updateModels() {
      item.pinnedModel = [globalFavorites, rootModel.modelForRow(0), rootModel.modelForRow(1)]
      item.allAppsModel = rootModel.modelForRow(1)
  }

  function reset(){
    ScrollBar.vertical.position = 0
    currentStateIndex = plasmoid.configuration.defaultPage
    currentSelectedCategory = appsCategoriesList[currentStateIndex]
    sortingLabel.text = currentSelectedCategory.name
    sortingImage.source = currentSelectedCategory.icon
  }
  function get_position(){
    return ScrollBar.vertical.position;
  }
  function get_size(){
    return ScrollBar.vertical.size;
  }
  Connections {
      target: root
      function onVisibleChanged() {
        currentStateIndex = plasmoid.configuration.defaultPage
        currentSelectedCategory = appsCategoriesList[currentStateIndex]
        sortingLabel.text = currentSelectedCategory.name
        sortingImage.source = currentSelectedCategory.icon
      }
  }
  onContentHeightChanged: {
    ScrollBar.vertical.position = scrollpositon * scrollheight / scrollView.contentHeight
  }
  Column {
    id: column
    width: parent.width
    onPositioningComplete: {
      scrollView.contentHeight = height
      if (height < appList.height) {
        scrollView.contentHeight = appList.height
      }
    }

    DropArea {
      width: flow.width
      height:flow.height
      visible: !main.showAllApps
      onDragMove: event => {

          var above = flow.childAt(event.x, event.y);

          if (above && above !== kicker.dragSource && dragSource.parent == flow) {
              repeater.model.moveRow(dragSource.itemIndex, above.itemIndex);
          }

      }
      GridLayout { //Favorites
        id: flow
        width: scrollView.width 
        columns: implicitW < parent.width ? -1 : parent.width / columnImplicitWidth
        rowSpacing: 2
        columnSpacing: 5
        anchors.horizontalCenter: scrollView.horizontalCenter

        property int columnImplicitWidth: children[0].width + columnSpacing
        property int implicitW: repeater.count * columnImplicitWidth

        visible: !main.showAllApps
        Repeater {
          id: repeater
          model: globalFavorites
          delegate:
          FavoriteItem {
            id: favitem
          }
        }
      }
    }

    Kirigami.Icon {
      id: sortingImage
      width: 15 * 1
      height: width
      visible: main.showAllApps
      source: scrollView.currentSelectedCategory.icon

      PlasmaComponents.Label {
        id: sortingLabel
        x: parent.width + 10 * 1
        anchors.verticalCenter: parent.verticalCenter
        text: i18n(scrollView.currentSelectedCategory.name)
        color: main.textColor
        font.family: main.textFont
        font.pointSize: main.textSize
      }
      MouseArea {
        id: mouseArea
        width: parent.width + sortingLabel.width + 5
        height: parent.height
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
        onClicked: {
          if (mouse.button == Qt.LeftButton) {
            isRight = false
            currentStateIndex += 1
          } else if (mouse.button == Qt.RightButton) {
            isRight = true
            currentStateIndex -= 1
          } else if (mouse.button == Qt.MiddleButton) {
            isRight = false
            currentStateIndex = plasmoid.configuration.defaultPage
          }
          if (currentStateIndex > scrollView.appsCategoriesList.length - 1) {
            currentStateIndex = 0
          } else if (currentStateIndex < 0) {
            currentStateIndex = scrollView.appsCategoriesList.length - 1
          }

          var currentCategory = scrollView.appsCategoriesList[currentStateIndex];
          var choosenRepeater = (currentStateIndex % 2 == 0) ? categoriesRepeater : categoriesRepeater2;

          sortingLabel.text = currentCategory.name;
          sortingImage.source = currentCategory.icon;
          choosenRepeater.model = rootModel.modelForRow(currentCategory.index);
        }
      }
    }
    Item { //Spacer
      id: spacer
      width: 1
      height: 10 * 1
    }

      Grid {
        id: allAppsGrid
        x: - 10 * 1
        columns: 1
        width: scrollView.width - 10 * 1
        visible: opacity > 0 && main.showAllApps
        Repeater {
          id: allAppsRepeater
          model: allAppsModel
          Repeater {
            id: repeater2
            model: allAppsRepeater.model.modelForRow(index)
           delegate:
          GenericItem {
              id: genericItem
              triggerModel: repeater2.model
            }
          }
        }
        states: [
        State {
          name: "hidden"; when: (currentStateIndex != 0)
          PropertyChanges { target: allAppsGrid; opacity: 0.0 }
          PropertyChanges { target: allAppsGrid; x: (!isRight ? -20 * 1 : 0) }
        },
        State {
          name: "shown"; when: (currentStateIndex == 0)
          PropertyChanges { target: allAppsGrid; opacity: 1.0 }
          PropertyChanges { target: allAppsGrid; x: -10 }
        }]
        transitions: [
          Transition {
            to: "hidden"
            PropertyAnimation { properties: 'opacity'; duration: 80; easing.type: Easing.InQuart}
            PropertyAnimation { properties: 'x'; from: -10 * 1; duration: 80;easing.type: Easing.InQuart}
          },
          Transition {
            to: "shown"
            PropertyAnimation { properties: 'opacity'; duration: 80; easing.type: Easing.InQuart}
            PropertyAnimation { properties: 'x'; from: (isRight ? -20 * 1 : 0); duration: 80; easing.type: Easing.InQuart}
          }
        ]
        onStateChanged: {
          if (state == 'hidden') {
            scrollpositon = scrollView.ScrollBar.vertical.position
            scrollheight = scrollView.contentHeight
          }
        }
      }
      Grid { //Categories
        id: appCategories
        columns: 1
        width: scrollView.width - 10 * 1
        visible: opacity > 0 && main.showAllApps
        Repeater {
          id: categoriesRepeater
          delegate:
          GenericItem {
            id: genericItemCat
            triggerModel: categoriesRepeater.model
          }
        }
        states: [
        State {
          name: "hidden"; when: (currentStateIndex == 0 || currentStateIndex % 2 === 1)
          PropertyChanges { target: appCategories; opacity: 0.0 }
          PropertyChanges { target: appCategories; x: (isRight ? -20 * 1 : 0) }
        },
        State {
          name: "shown"; when: (currentStateIndex != 0 && currentStateIndex % 2 === 0)
          PropertyChanges { target: appCategories; opacity: 1.0 }
          PropertyChanges { target: appCategories; x: -10 * 1 }
        }]
        transitions: [
          Transition {
            to: "hidden"
            PropertyAnimation { properties: 'opacity'; duration: 80; easing.type: Easing.InQuart}
            PropertyAnimation { properties: 'x'; from: -10 * 1; duration: 80; easing.type: Easing.InQuart}
          },
          Transition {
            to: "shown"
            PropertyAnimation { properties: 'opacity'; duration: 80; easing.type: Easing.InQuart}
            PropertyAnimation { properties: 'x'; from: (isRight ? -20 * 1 : 0); duration: 80; easing.type: Easing.InQuart}
          }
        ]
        onStateChanged: {
          if (state == 'hidden') {
            scrollpositon = scrollView.ScrollBar.vertical.position
            scrollheight = scrollView.contentHeight
          }
        }
      }

      Grid { //Categories
        id: appCategories2
        columns: 1
        width: scrollView.width - 10 * 1
        visible: opacity > 0 && main.showAllApps
        Repeater {
          id: categoriesRepeater2
          delegate:
          GenericItem {
            id: genericItemCat2
            triggerModel: categoriesRepeater2.model
          }
        }
        states: [
        State {
          name: "hidden"; when: (currentStateIndex == 0 || currentStateIndex % 2 === 0)
          PropertyChanges { target: appCategories2; opacity: 0.0 }
          PropertyChanges { target: appCategories2; x: (isRight ? -20 * 1 : 0) }
        },
        State {
          name: "shown"; when: (currentStateIndex != 0 && currentStateIndex % 2 === 1)
          PropertyChanges { target: appCategories2; opacity: 1.0 }
          PropertyChanges { target: appCategories2; x: -10  * 1}
        }]
        transitions: [
          Transition {
            to: "hidden"
            PropertyAnimation { properties: 'opacity'; duration: 80; easing.type: Easing.InQuart}
            PropertyAnimation { properties: 'x'; from: -10 * 1; duration: 80; easing.type: Easing.InQuart}
          },
          Transition {
            to: "shown"
            PropertyAnimation { properties: 'opacity'; duration: 80; easing.type: Easing.InQuart}
            PropertyAnimation { properties: 'x'; from: (isRight ? -20 * 1 : 0);duration: 80; easing.type: Easing.InQuart}
          }
        ]
        onStateChanged: {
          if (state == 'hidden') {
            scrollpositon = scrollView.ScrollBar.vertical.position
            scrollheight = scrollView.contentHeight
          }
        }
      }

    Item { //Spacer
      width: 1
      height: 20 * 1
    }
  }
}
