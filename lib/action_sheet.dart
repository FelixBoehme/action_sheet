library action_sheet;

import 'package:flutter/material.dart';

/// Determines the position of the Widgets per Row.
/// - [leftBound] All Widgets are positioned the same.
//
/// - [mainAxis] Widgets are postioned according to the number of Widgets.
enum WidgetPositioning {
  /// Widgets are laid out like a table or grid from left to right (leftbound), to achieve a symmetric look.
  leftBound,

  /// If the amount of Widgets in a Row matches [maxPerRow], Widgets are laid out like [WidgetPositioning.leftBound].
  ///
  /// For Rows where the amount of Widgets are smaller than [maxPerRow], the Layout of the Widgets is according to [mainAxisAlignment], defaulting to a mainAxis look.
  mainAxis,
}

/// Shows a material design bottom sheet with actions.
///
/// It is based on Flutter's Bottom Sheet providing an easy template for using it with actions.
///
/// A modal bottom sheet is an alternative to a menu or a dialog and prevents
/// the user from interacting with the rest of the app.
///
/// A closely related widget is a persistent bottom sheet, which shows
/// information that supplements the primary content of the app without
/// preventing the use from interacting with the app. Persistent bottom sheets
/// can be created and displayed with the [showBottomSheet] function or the
/// [ScaffoldState.showBottomSheet] method.
///
/// The `children` argument specifies all widgets/actions to be displayed
/// in the bottom sheet.
///
/// The `actions` argument specifies the function for each widget/action.
///
/// The `descriptions` parameter can be used to give actions a [Text]
/// subtitle to describe it.
///
/// The 'title' parameter is used to display a given [Text] as a title or
/// heading for the bottom action sheet.
///
/// The `titlePadding` parameter defines the padding around a given title.
///
/// The `widgetPositioning` parameter is used to specify how the widgets/actions
/// in each row are laid out.
///
/// The `maxPerRow` parameter defines the maximum amount of widgets/actions per row.
/// If no value is provided it tries to choose to most suitable one.
///
/// The `widgetBorderSize` parameter specifies the width and height used for
/// every widget/action. Defaults to 24.0
///
/// The `widgetPadding` defines the padding used around every widget/action.
/// Defaults to EdgeInsets.all(8.0).
///
/// The `rowGap` is used to define to gap between each row.
/// Defaults to 14.0
///
/// The `mainAxisAlignment` specifies the mainAxisAlignment for every row
/// of widgets/actions shown.
///
/// The `sheetPadding` defines the padding surrounding the action sheet.
/// Defaults to EdgeInsets.fromLTRB(20, 20, 20, 15).
///
/// The `context` argument is used to look up the [Navigator] and [Theme] for
/// the bottom sheet. It is only used when the method is called. Its
/// corresponding widget can be safely removed from the tree before the bottom
/// sheet is closed.
///
/// The `isScrollControlled` parameter specifies whether this is a route for
/// a bottom sheet that will utilize [DraggableScrollableSheet]. If you wish
/// to have a bottom sheet that has a scrollable child such as a [ListView] or
/// a [GridView] and have the bottom sheet be draggable, you should set this
/// parameter to true.
///
/// The `useRootNavigator` parameter ensures that the root navigator is used to
/// display the [BottomSheet] when set to `true`. This is useful in the case
/// that a modal [BottomSheet] needs to be displayed above all other content
/// but the caller is inside another [Navigator].
///
/// The [isDismissible] parameter specifies whether the bottom sheet will be
/// dismissed when user taps on the scrim.
///
/// The [enableDrag] parameter specifies whether the bottom sheet can be
/// dragged up and down and dismissed by swiping downwards.
///
/// The optional [backgroundColor], [elevation], [shape], [clipBehavior],
/// [constraints] and [transitionAnimationController]
/// parameters can be passed in to customize the appearance and behavior of
/// modal bottom sheets (see the documentation for these on [BottomSheet]
/// for more details).
///
/// The [transitionAnimationController] controls the bottom sheet's entrance and
/// exit animations if provided.
///
/// The optional `routeSettings` parameter sets the [RouteSettings] of the modal bottom sheet
/// sheet. This is particularly useful in the case that a user wants to observe
/// [PopupRoute]s within a [NavigatorObserver].
///
/// Returns a `Future` that resolves to the value (if any) that was passed to
/// [Navigator.pop] when the modal bottom sheet was closed.
///
/// ```dart
/// Widget build(BuildContext context) {
///    return Center(
///      child: ElevatedButton(
///        child: Text("showBottomActionSheet"),
///        onPressed: () {
///          showBottomActionSheet(
///            context: context,
///            widgetPositioning: WidgetPositioning.mainAxis,
///            children: [
///              Icon(
///                Icons.class_,
///                color: Colors.white,
///              ),
///              Icon(
///                Icons.folder,
///                color: Colors.white,
///              ),
///              Icon(
///                Icons.note_add,
///                color: Colors.white,
///              ),
///            ],
///            descriptions: [
///              Text("Class"),
///              Text("Folder"),
///              Text("Note"),
///            ],
///            actions: [],
///            titleText: Text(
///              "Create New",
///              style: TextStyle(fontSize: 25),
///            ),
///          );
///        },
///      ),
///    );
///  }
/// ```

Future<T?> showBottomActionSheet<T>({
  required BuildContext context,
  required List<Widget> children,
  required List<VoidCallback?> actions,
  List<Text?>? descriptions,
  EdgeInsetsGeometry descriptionsPadding = const EdgeInsets.only(top: 5),
  Text? titleText,
  EdgeInsetsGeometry titlePadding = const EdgeInsets.only(top: 5, bottom: 35),
  WidgetPositioning widgetPositioning = WidgetPositioning.leftBound,
  BorderRadius? widgetBorderRadius,
  Color? widgetBorderColor,
  int? maxPerRow,
  double widgetBorderSize = 24.0,
  double? widgetSplashRadius,
  double? widgetBorderWidth = 1,
  EdgeInsetsGeometry widgetPadding = const EdgeInsets.all(8.0),
  double? rowGap = 14.0,
  MainAxisAlignment? mainAxisAlignment = MainAxisAlignment.spaceAround,
  EdgeInsetsGeometry sheetPadding = const EdgeInsets.fromLTRB(20, 20, 20, 15),
  BoxConstraints? constraints,
  VisualDensity? visualDensity,
  Color? backgroundColor,
  double? elevation,
  ShapeBorder shape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(16),
    ),
  ),
  Clip clipBehaviour = Clip.antiAliasWithSaveLayer,
  Color? barrierColor,
  bool isScrollControlled = false,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  RouteSettings? routeSettings,
  AnimationController? transitionAnimationController,
}) {
  /// Minimum logical pixel size of the IconButton.
  const double _kMinButtonSize = kMinInteractiveDimension;

  final VisualDensity effectiveVisualDensity =
      visualDensity ?? Theme.of(context).visualDensity;

  final BoxConstraints unadjustedConstraints = constraints ??
      const BoxConstraints(
        minWidth: _kMinButtonSize,
        minHeight: _kMinButtonSize,
      );

  final BoxConstraints adjustedConstraints =
      effectiveVisualDensity.effectiveConstraints(unadjustedConstraints);

  /// Automatically set [maxPerRow] to provide a good layout, unless a custom value is given.
  /// Max Widgets - 5 , Min Widgets - 2
  /// Chooses a value where [neededRows] * [maxPerRow] = number of Children, if possible.
  /// If mutiple values can apply the smallest number that is greater than [neededRows] is choosen.
  /// If no value applies, the smallest number that is still greater than [neededRows] is choosen.
  if (maxPerRow == null) {
    for (var nmb = 5; nmb > 1; nmb--) {
      if (children.length % nmb == 0) {
        if ((children.length / nmb).ceil() <= nmb) {
          maxPerRow = nmb;
        }
      }
    }
    if (maxPerRow == null) {
      for (var nmb = 5; nmb > 1; nmb--) {
        if ((children.length / nmb).ceil() <= nmb) {
          maxPerRow = nmb;
        }
      }
    }
  }

  /// Number of Rows needed to fit every given Widget according to [maxPerRow].
  int neededRows = (children.length / maxPerRow!).ceil();

  /// Number of (non visible) Widgets missing to maintain Layout.
  /// = Rows needed * max Items per Row [maxPerRow] - given Widgets [childre.length].
  int missingWidgets = neededRows * maxPerRow - children.length;

  /// When no descriptions have been defined, given Widgets will be given a null value.
  /// This results in no descriptions at all.
  if (descriptions == null) {
    descriptions = [];
    for (var i = 0; i < children.length; i++) {
      descriptions.add(null);
    }
  }

  /// Alters [children], [actions] and [descriptions] to match WidgetPositioning.mainAxis.
  if (widgetPositioning == WidgetPositioning.leftBound) {
    /// When the amount of given Widgets doesn't match the needed amount,
    /// add "Invisible" Container.
    /// Amount specified by [missingWidgets].
    if (children.length < neededRows * maxPerRow) {
      for (var i = 0; i < missingWidgets; i++) {
        children.add(Container());
      }
    }

    /// When no actinos have been specified, add empty funtion bodys.
    /// This is in order to make the button clickable even without purpose.
    /// Empty function bodys will be added for every given Widget [children.length].
    if (actions.length == 0) {
      for (var i = 0; i < children.length - missingWidgets; i++) {
        actions.add(() {});
      }
    }

    /// When some actions are given but not enough, every Widget in [children] receives a value of null.
    /// This also applies to the potentially added Containers in order to avoid them being clickable.
    if (actions.length < children.length) {
      for (var i = 0; i < missingWidgets; i++) {
        actions.add(null);
      }
    }

    /// When some descriptions have been defined but not for ever given Widget,
    /// the remaining Widgets will recevíve a null value, in order to not show anything.
    if (descriptions.length < children.length) {
      for (var i = 0; i < children.length - descriptions.length + i; i++) {
        descriptions.add(null);
      }
    }
  }

  /// Alters [children], [actions] and [descriptions] to match WidgetPositioning.leftBound.
  else {
    for (var i = 0; i < children.length; i++) {
      actions.add(() {});

      descriptions.add(null);
    }
  }

  /// List with Widget-Sublists for every Row.
  final List<List<Widget>> widgetList = [];

  /// Sublist with Widgets per Row.
  List<Widget> widgets = [];

  /// List with Actions/Function-Sublists for every Row.
  final List<List<VoidCallback?>> onPressedList = [];

  /// Sublist with Actions/Functions per Row.
  List<VoidCallback?> onPressed = [];

  /// List with Description-Sublists for every Row.
  final List<List<Text?>> textList = [];

  /// Sublist with Descriptions per Row.
  List<Text?> texts = [];

  /// Count till [maxPerRow] has been reached.
  /// Used to generate List with Widgets of each row.
  /// Gets reset afterwards.
  int index = 0;

  /// For each parameter [children], [actions] and [descriptions], Lists are created.
  /// These Lists contain a Sublist for every row and contain the corresponding Information.
  /// It loops through the indices 0 to [children.length].
  /// Seperately the variable [index] is increased till it reaches [maxPerRow].
  /// After it hits its maximum the Sublist gets added to the final Lists and [index] is reset.
  for (var i = 0; i < children.length; i++) {
    if (index <= maxPerRow) {
      index += 1;
      widgets.add(children[i]);

      onPressed.add(actions[i]);

      texts.add(descriptions[i]);
      if (index == maxPerRow) {
        widgetList.addAll([widgets]);
        widgets = [];

        onPressedList.addAll([onPressed]);
        onPressed = [];

        textList.addAll([texts]);
        texts = [];
        index = 0;
      }
    }
  }

  /// Adds the Sublists, that haven't been added because they have less Widgets than [maxPerRow] to their accroding main List.
  if (widgetPositioning == WidgetPositioning.mainAxis) {
    widgetList.addAll([widgets]);

    onPressedList.addAll([onPressed]);

    textList.addAll([texts]);
  }

  /// Contains every Row to be shown.
  List<Widget> rowList = [];

  /// Creates a new Row for every needed Row.
  /// Every Row also returns a Column including all Widgets from the Sublist,
  /// according to [row] and [widgetIndex].
  /// A border is only shown if a function has been provided through [actions].
  /// Unless given the BorderColor defaults to black or white depending on [Brightness].
  /// Unless a custom [splashRadius] has been given, [widgetBorderSize] + 5 is used for splashes.
  /// If no [descriptions] have been defined an empty Container is returned, making it invisible onscreen.
  /// After every Row except the last a spacer is returned. Unless given its height [rowGap] defaults to 14.0.
  for (var row = 0; row < neededRows; row++) {
    rowList.add(
      Container(
        child: Row(
          mainAxisAlignment: mainAxisAlignment!,
          // Widgets always on same baseline
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var widgetIndex = 0;
                widgetIndex < widgetList[row].length;
                widgetIndex++)
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: onPressedList[row][widgetIndex] != null
                            ? Border.all(
                                width: widgetBorderWidth!,
                                color: widgetBorderColor ??=
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                            : null,
                        borderRadius:
                            widgetBorderRadius ?? BorderRadius.circular(90)),
                    child: ConstrainedBox(
                      constraints: adjustedConstraints,
                      child: Padding(
                        padding: widgetPadding,
                        child: SizedBox(
                          height: widgetBorderSize,
                          width: widgetBorderSize,
                          child: InkResponse(
                            child: Center(
                              child: widgetList[row][widgetIndex],
                            ),
                            onTap: onPressedList[row][widgetIndex],
                            radius: widgetSplashRadius ?? widgetBorderSize + 5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: descriptionsPadding,
                    child: onPressedList[row][widgetIndex] != null
                        ? textList[row][widgetIndex]
                        : Container(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );

    if (row < neededRows - 1)
      rowList.add(SizedBox(
        height: rowGap,
      ));
  }

  /// Shows the actual bottom sheet
  /// Returns container to enable custom padding, defaults to EdgeInsets.fromLTRB(20, 20, 20, 15).
  /// The Column contains every given Row in [rowList].
  /// The mainAxisSize is set to be minimal in order to maintain the layout.
  /// When defined a titel [titleText] with [titelPadding] for the sheet will be displayed.
  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: backgroundColor,
    elevation: elevation,
    shape: shape,
    clipBehavior: clipBehaviour,
    constraints: constraints,
    barrierColor: barrierColor,
    isScrollControlled: isScrollControlled,
    useRootNavigator: useRootNavigator,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    routeSettings: routeSettings,
    transitionAnimationController: transitionAnimationController,
    builder: (BuildContext context) {
      return Container(
        padding: sheetPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (titleText != null)
              Container(
                padding: titlePadding,
                child: titleText,
              ),
            for (var row in rowList) row,
          ],
        ),
      );
    },
  );
}
