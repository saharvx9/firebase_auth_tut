import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;
  static late double fullScreenWidth;
  static late double fullScreenHeight;
  static double safeIsMobile = 1.0;

  static final SizeConfig _instance = SizeConfig._internal();

  factory SizeConfig() => _instance;

  SizeConfig._internal();

  void init(BuildContext context,{bool fromMaterialApp = false}) {
    safeIsMobile = kIsWeb ? 0.8 : 1.0;
    _mediaQueryData = fromMaterialApp ? MediaQueryData.fromWindow(WidgetsBinding.instance.window) : MediaQuery.of(context);
    fullScreenHeight = _mediaQueryData.size.height;
    fullScreenWidth = _mediaQueryData.size.width;
    screenWidth = _mediaQueryData.size.width * safeIsMobile;
    screenHeight = _mediaQueryData.size.height * safeIsMobile;
    blockSizeHorizontal = screenWidth / 100 * safeIsMobile;
    blockSizeVertical = screenHeight / 100 * safeIsMobile;

    _safeAreaHorizontal = (_mediaQueryData.padding.left + _mediaQueryData.padding.right) * safeIsMobile;
    _safeAreaVertical = (_mediaQueryData.padding.top + _mediaQueryData.padding.bottom) * safeIsMobile;
    safeBlockHorizontal = ((screenWidth - _safeAreaHorizontal) / 100) * safeIsMobile;
    safeBlockVertical = ((screenHeight - _safeAreaVertical) / 100) * safeIsMobile;
    safeBlockHorizontal = safeBlockHorizontal > 4.0 ? 4.0 : safeBlockHorizontal;
    safeBlockVertical = safeBlockVertical > 8.0 ? 8.0 : safeBlockVertical;
  }

  ///
  /// Responsive Spacings uses for padding space etc...
  ///

  //Vertical
  static double get spacingMiniVertical => safeBlockVertical * safeIsMobile;
  static double get spacingSmallVertical => safeBlockVertical * 2 * safeIsMobile;
  static double get spacingSmallPlusVertical => safeBlockVertical * 2.5 * safeIsMobile;
  static double get spacingMediumVertical => safeBlockVertical * 3 * safeIsMobile;
  static double get spacingNormalVertical => safeBlockVertical * 4 * safeIsMobile;
  static double get spacingLargeVertical => safeBlockVertical * 7 * safeIsMobile;
  static double get spacingExtraVertical => safeBlockVertical * 9 * safeIsMobile;
  //Horizontal
  static double get spacingSmallHorizontal => safeBlockHorizontal * 2 * safeIsMobile;
  static double get spacingSmallPlusHorizontal => safeBlockHorizontal * 2.5 * safeIsMobile;
  static double get spacingMediumHorizontal => safeBlockVertical * 3 * safeIsMobile;
  static double get spacingNormalHorizontal => safeBlockVertical * 4 * safeIsMobile;
  static double get spacingLargeHorizontal => safeBlockVertical * 7 * safeIsMobile;
  static double get spacingExtraHorizontal => safeBlockVertical * 9 * safeIsMobile;

  ///
  /// Responsive Fonts
  ///
  static double get fontMini => safeBlockHorizontal * 2 * safeIsMobile;
  static double get fontSmall => safeBlockHorizontal * 3 * safeIsMobile;
  static double get fontSmallPlus => safeBlockHorizontal * 3.5 * safeIsMobile;
  static double get fontNormal => safeBlockHorizontal * 4.5 * safeIsMobile;
  static double get fontMedium => safeBlockHorizontal * 5 * safeIsMobile;
  static double get fontLarge => safeBlockHorizontal * 6 * safeIsMobile;
  static double get fontExtra => safeBlockHorizontal * 7 * safeIsMobile;
  static double get fontHuge => safeBlockHorizontal * 10 * safeIsMobile;

}
