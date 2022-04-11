library bc_image_editor;

import 'package:flutter/material.dart';
import 'package:bc_image_editor/bc_image_editor.dart';
import 'package:gesture_x_detector/gesture_x_detector.dart';

enum EditMode {
  size,
  horizontalRotate,
  verticalRotate,
  rotate2D,
  viewMode,
  noEdit
}

class EditWithGesture extends StatefulWidget {
  final String frontImage, bgImage;
  final EditMode editMode;
  const EditWithGesture({
    Key? key,
    this.frontImage = "",
    this.bgImage = "",
    this.editMode = EditMode.noEdit,
  }) : super(key: key);

  @override
  State<EditWithGesture> createState() => _EditWithGestureState();
}

class _EditWithGestureState extends State<EditWithGesture> {
  double frontTop = 300,
      frontLeft = 100,
      firstHeight = 100,
      rotateY = 0,
      rotateX = 0,
      scaleAmount = 1,
      frontWidth = 100;

  double bgLeft = 50,
      bgTop = 300,
      bgWidth = 300,
      scaleAmountBg = 1,
      firstWidthBg = 300,
      firstTransformScale = 1,
      transformScale = 1,
      rotate2D = 0;

  void mouseMove(MoveEvent event) {
    setState(() {
      switch (widget.editMode) {
        case EditMode.horizontalRotate:
          rotateY += event.delta.dx;
          break;
        case EditMode.verticalRotate:
          rotateX += event.delta.dy;
          break;
        case EditMode.viewMode:
          bgTop = bgTop + event.delta.dy;
          bgLeft = bgLeft + event.delta.dx;
          frontTop += event.delta.dy;
          frontLeft += event.delta.dx;
          break;
        case EditMode.rotate2D:
          rotate2D += event.delta.dx / 100;
          break;
        case EditMode.noEdit:
          break;
        default:
          frontTop += event.delta.dy / firstTransformScale;
          frontLeft += event.delta.dx / firstTransformScale;
          break;
      }
    });
  }

  void mouseScale(ScaleEvent event) {
    setState(() {
      switch (widget.editMode) {
        case EditMode.viewMode:
          transformScale = firstTransformScale * event.scale;
          debugPrint(event.scale.toString());
          break;
        case EditMode.noEdit:
          break;
        default:
          frontWidth = firstHeight * event.scale;
          scaleAmount = event.scale;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return XGestureDetector(
      onScaleEnd: () {
        switch (widget.editMode) {
          case EditMode.viewMode:
            firstTransformScale = transformScale;
            break;
          case EditMode.noEdit:
            break;
          default:
            firstHeight *= scaleAmount;
            break;
        }
      },
      onScaleUpdate: mouseScale,
      onMoveUpdate: mouseMove,
      child: BcImageEditor(
        frontImage: widget.frontImage,
        bgImage: widget.bgImage,
        frontWidth: frontWidth,
        bgWidth: bgWidth,
        frontTop: frontTop,
        frontLeft: frontLeft,
        bgTop: bgTop,
        bgLeft: bgLeft,
        transformScale: transformScale,
        rotateX: rotateX,
        rotateY: rotateY,
        rotate2D: rotate2D,
        bgBoxFit: BoxFit.cover,
        frontBoxFit: BoxFit.cover,
      ),
    );
  }
}
