library bc_image_editor;

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load(path);

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  bool exist = await file.exists();
  if (!exist) {
    await file.create(recursive: true);
  }

  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

class BcImageEditor extends StatelessWidget {

  final String? bgImage, frontImage;

  final double? frontLeft,
      frontTop,
      frontWidth,
      rotateX,
      rotateY,
      rotate2D,
      frontHeight;
  final double? transformScale, bgLeft, bgTop, bgWidth, bgHeight;

  final BoxFit frontBoxFit, bgBoxFit;


  const BcImageEditor({
    Key? key,
    @required this.frontImage,
    @required this.bgImage,
    this.frontWidth,
    this.frontHeight,
    this.frontLeft,
    this.frontTop,
    this.frontBoxFit = BoxFit.fill,
    this.bgWidth,
    this.bgHeight,
    this.bgLeft,
    this.bgTop,
    this.bgBoxFit = BoxFit.fill,
    this.rotateX = 0,
    this.rotateY = 0,
    this.rotate2D = 0,
    this.transformScale = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Transform.scale(
        alignment: Alignment.bottomCenter,
        scale: transformScale!,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: bgLeft,
              top: bgTop,
              child: bgImage == ""
                  ? const SizedBox.shrink()
                  : Image.file(
                      File(bgImage!),
                      fit: bgBoxFit,
                      width: bgWidth,
                      height: bgHeight,
                    ),
            ),
            Positioned(
              left: frontLeft,
              top: frontTop,
              child: Transform.rotate(
                angle: rotate2D!,
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(pi / 180 * rotateY!)
                    ..rotateX(pi / 180 * rotateX!),
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      frontImage! == ""
                          ? const SizedBox.shrink()
                          : Image.file(
                              File(frontImage!),
                              fit: frontBoxFit,
                              width: frontWidth,
                              height: frontHeight,
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
