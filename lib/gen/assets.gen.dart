/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Poppins-Bold.ttf
  String get poppinsBold => 'assets/fonts/Poppins-Bold.ttf';

  /// File path: assets/fonts/Poppins-BoldItalic.ttf
  String get poppinsBoldItalic => 'assets/fonts/Poppins-BoldItalic.ttf';

  /// File path: assets/fonts/Poppins-Italic.ttf
  String get poppinsItalic => 'assets/fonts/Poppins-Italic.ttf';

  /// File path: assets/fonts/Poppins-Medium.ttf
  String get poppinsMedium => 'assets/fonts/Poppins-Medium.ttf';

  /// List of all assets
  List<String> get values =>
      [poppinsBold, poppinsBoldItalic, poppinsItalic, poppinsMedium];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/ic_chatbot.svg
  SvgGenImage get icChatbot => const SvgGenImage('assets/icons/ic_chatbot.svg');

  /// File path: assets/icons/ic_community_off.svg
  SvgGenImage get icCommunityOff =>
      const SvgGenImage('assets/icons/ic_community_off.svg');

  /// File path: assets/icons/ic_community_on.svg
  SvgGenImage get icCommunityOn =>
      const SvgGenImage('assets/icons/ic_community_on.svg');

  /// File path: assets/icons/ic_edu_off.svg
  SvgGenImage get icEduOff => const SvgGenImage('assets/icons/ic_edu_off.svg');

  /// File path: assets/icons/ic_edu_on.svg
  SvgGenImage get icEduOn => const SvgGenImage('assets/icons/ic_edu_on.svg');

  /// File path: assets/icons/ic_home_off.svg
  SvgGenImage get icHomeOff =>
      const SvgGenImage('assets/icons/ic_home_off.svg');

  /// File path: assets/icons/ic_home_on.svg
  SvgGenImage get icHomeOn => const SvgGenImage('assets/icons/ic_home_on.svg');

  /// File path: assets/icons/ic_launcher.png
  AssetGenImage get icLauncher =>
      const AssetGenImage('assets/icons/ic_launcher.png');

  /// File path: assets/icons/ic_profile_off.svg
  SvgGenImage get icProfileOff =>
      const SvgGenImage('assets/icons/ic_profile_off.svg');

  /// File path: assets/icons/ic_profile_on.svg
  SvgGenImage get icProfileOn =>
      const SvgGenImage('assets/icons/ic_profile_on.svg');

  /// List of all assets
  List<dynamic> get values => [
        icChatbot,
        icCommunityOff,
        icCommunityOn,
        icEduOff,
        icEduOn,
        icHomeOff,
        icHomeOn,
        icLauncher,
        icProfileOff,
        icProfileOn
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/nutrimama_logo.svg
  SvgGenImage get nutrimamaLogo =>
      const SvgGenImage('assets/images/nutrimama_logo.svg');

  /// File path: assets/images/profile_default_img.png
  AssetGenImage get profileDefaultImg =>
      const AssetGenImage('assets/images/profile_default_img.png');

  /// List of all assets
  List<dynamic> get values => [nutrimamaLogo, profileDefaultImg];
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
