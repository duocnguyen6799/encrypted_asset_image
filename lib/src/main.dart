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

  final String assetPath;

  final FileCryptor fileCryptor;

  final double scale;

  final ImageFrameBuilder? frameBuilder;

  final ImageLoadingBuilder? loadingBuilder;

  final ImageErrorWidgetBuilder? errorBuilder;

  final double? width;

  final double? height;

  final Color? color;

  final Animation<double>? opacity;

  final FilterQuality filterQuality;

  final BlendMode? colorBlendMode;

  final BoxFit? fit;

  final AlignmentGeometry alignment;

  final ImageRepeat repeat;

  final Rect? centerSlice;

  final bool matchTextDirection;

  final bool gaplessPlayback;

  final String? semanticLabel;

  final bool excludeFromSemantics;

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
        }
        return ErrorWidget('Fail to load image');
      },
    );
  }

  Future<Uint8List> _getEncryptedImage({required String assetPath}) async {
    ByteData bytesData = await rootBundle.load(assetPath);
    Uint8List uInt8List = bytesData.buffer
        .asUint8List(bytesData.offsetInBytes, bytesData.lengthInBytes);
    return fileCryptor.decryptUint8List(data: uInt8List);
  }
}
