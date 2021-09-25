# Action Sheet
This package provides a material bottom sheet with actions, replicating the one seen in Google Drive.

Based on `showBottomSheet`.

## Preview

## Getting Started
Add the package to your pubspec.yaml:

```yaml
action_sheet: ^1.0.0
```
Import the package in your dart file:

```dart
import 'package:sheet_actions_test/action_sheet.dart';
```

Use `showBottomActionSheet` to return the bottom action sheet.


## Basic Usage
Required Arguments:
* context: for building
* children: widgets to display as actions
* actions: function called on press


```dart
Widget build(BuildContext context) {
   return Center(
     child: ElevatedButton(
       child: Text("showBottomActionSheet"),
       onPressed: () {
         showBottomActionSheet(
           context: context,
           widgetPositioning: WidgetPositioning.mainAxis,
           children: [
             Icon(
               Icons.class_,
               color: Colors.white,
             ),
             Icon(
               Icons.folder,
               color: Colors.white,
             ),
             Icon(
               Icons.note_add,
               color: Colors.white,
             ),
           ],
           descriptions: [
             Text("Class"),
             Text("Folder"),
             Text("Note"),
           ],
           actions: [],
           titleText: Text(
             "Create New",
             style: TextStyle(fontSize: 25),
           ),
         );
       },
     ),
   );
 }
```

## Parameters (Optional)
* `descriptions`: `Text()` beneath actions
* `descriptionsPadding`
* `titleText`
* `titlePadding`
* `widgetPositioning`:
  * `WidgetPostioning.leftBound`: positions widgets in a grid from left to right
  * `WidgetPositioning.mainAxis`: positions widgets in a grid depending on `mainAxisAlignment`
* `widgetBorderRadius`: radius for all borders around widgets
* `maxPerRow`: maximum amount of widgets/actions in each row, unless given adjusts to number of widgets given
* `widgetBorderSize`: size of all borders surrounding the widgets
* `widgetSplashRadius`
* `widgetBorderWidth`
* `widgetPadding`
* `rowGap`: gap between each row
* `mainAxisAlignment
* `sheetPadding`
* `constraints`
* `visualDensity`
* `backgroundColor`: defaults to canvas color specified in current theme
* `elevation`
* `shape`: defaults to a rectangle with rounded borders
* `clipBehaviour`: clips everything outside of the specified shape
* `barrierColor`: color of background when selected
* `isSrollControlled`
* `useRootNavigator`
* `isDimissible`
* `enableDrag`
* `routeSettings`
* `transitionAnimationController`
