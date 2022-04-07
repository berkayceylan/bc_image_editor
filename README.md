<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->
# BC Image Editor
You can edit image using this package and also you can create flex preview image by setting foreground to null. For now, you can use only asset files.

## Features

- Background and Foreground(optional) image
- Resize images
- Set x,y position them
- 3D rotate image image on x, y axis (Foreground only)
- 2D rotate foreground image
- Scale for detail view
- Use on device files or asset files



## Getting started
Import: 
```dart
    import 'package:bc_image_editor/bc_image_editor.dart';
```
Using:
```dart
    BcImageEditor(
            frontImage: "image/path",
            bgImage: "image/path",
            frontWidth: 200,
            frontHeight: 300,
            bgWidth: 300,
            bgHeight: 200, //If one of variable of width and height not setted or set to null, the other one will auto scale
            frontLeft: 10,
            frontTop: 10,
            bgLeft: 10,
            bgTop: 10,
            frontBoxFit: BoxFit.fill,
            bgBoxFit: BoxFit.fill,
            rotateX: 0, //rotateX and y are on 3D axis
            rotateY: 0,
            rotate2D: 0,
        ),
```
---
<br /> 


## Using from asset folder image
<br /> 

First initialize your path name:
```dart
    String imagePath = "";
```
Then create a async function like below and use it in initState:
```dart
    void initFiles() async {
        File tempImg =
            await getImageFileFromAssets("assets/image/path");
        setState(() {
            imagePath = tempImg.path;
        });
  }
```
## Example
Coming soon

# LICENSE
MIT License

## Additional information
It's my first package in pub.dev I will try to improve it.