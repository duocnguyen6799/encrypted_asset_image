/*
 Created by DuocNP on 06/10/2022.
 Copyright (c) 2022 . All rights reserved.
*/
import 'dart:typed_data';

import 'package:file_cryptor/file_cryptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EncryptedAssetImage extends StatefulWidget {
  const EncryptedAssetImage({
    Key? key,
    required this.assetPath,
    required this.fileCryptor,
    this.scale = 1.0,
    this.frameBuilder,
    this.errorBuilder,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.width,
    this.height,
    this.color,
    this.opacity,
    this.colorBlendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    this.isAntiAlias = false,
    this.filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
    this.loadingBuilder,
  }) : super(key: key);

  /// Path of the asset image
  final String assetPath;

  /// Instance of FileCryptor
  final FileCryptor fileCryptor;

  /// The param of [Image.memory]
  final double scale;

  /// The param of [Image.memory]
  final ImageFrameBuilder? frameBuilder;

  /// The param of [Image.memory]
  final ImageLoadingBuilder? loadingBuilder;

  /// The param of [Image.memory]
  final ImageErrorWidgetBuilder? errorBuilder;

  /// The param of [Image.memory]
  final double? width;

  /// The param of [Image.memory]
  final double? height;

  /// The param of [Image.memory]
  final Color? color;

  /// The param of [Image.memory]
  final Animation<double>? opacity;

  /// The param of [Image.memory]
  final FilterQuality filterQuality;

  /// The param of [Image.memory]
  final BlendMode? colorBlendMode;

  /// The param of [Image.memory]
  final BoxFit? fit;

  /// The param of [Image.memory]
  final AlignmentGeometry alignment;

  /// The param of [Image.memory]
  final ImageRepeat repeat;

  /// The param of [Image.memory]
  final Rect? centerSlice;

  /// The param of [Image.memory]
  final bool matchTextDirection;

  /// The param of [Image.memory]
  final bool gaplessPlayback;

  /// The param of [Image.memory]
  final String? semanticLabel;

  /// The param of [Image.memory]
  final bool excludeFromSemantics;

  /// The param of [Image.memory]
  final bool isAntiAlias;

  @override
  State<EncryptedAssetImage> createState() => _EncryptedAssetImageState();
}

class _EncryptedAssetImageState extends State<EncryptedAssetImage> {
  FileCryptor get fileCryptor => widget.fileCryptor;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: _getEncryptedImage(assetPath: widget.assetPath),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Image.memory(
            snapshot.data!,
            key: widget.key,
            scale: widget.scale,
            frameBuilder: widget.frameBuilder,
            errorBuilder: widget.errorBuilder,
            semanticLabel: widget.semanticLabel,
            excludeFromSemantics: widget.excludeFromSemantics,
            width: widget.width,
            height: widget.height,
            color: widget.color,
            opacity: widget.opacity,
            colorBlendMode: widget.colorBlendMode,
            fit: widget.fit,
            alignment: widget.alignment,
            repeat: widget.repeat,
            centerSlice: widget.centerSlice,
            matchTextDirection: widget.matchTextDirection,
            gaplessPlayback: widget.gaplessPlayback,
            isAntiAlias: widget.isAntiAlias,
            filterQuality: widget.filterQuality,
          );
        } else if (snapshot.hasError) {
          return ErrorWidget('Failed to load image');
        }
        return const SizedBox();
      },
    );
  }

  /// Using to get a encrypted image from asset
  Future<Uint8List> _getEncryptedImage({required String assetPath}) async {
    ByteData bytesData = await rootBundle.load(assetPath);
    Uint8List uInt8List = bytesData.buffer
        .asUint8List(bytesData.offsetInBytes, bytesData.lengthInBytes);
    return fileCryptor.decryptUint8List(data: uInt8List);
  }
}
