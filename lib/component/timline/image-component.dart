import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImageComponent extends StatefulWidget {
  final String? imageSource;
  final bool isNetworkImage;
  final bool isCircleImage;
  final double height;
  final double width;
  final double textSize;
  final dynamic isImageFromFile;
  final EdgeInsets edgeInsets;

  const ImageComponent(
      {Key? key,
      required this.imageSource,
      this.isNetworkImage = true,
      this.height = 100,
      this.width = 100,
      this.textSize = 12,
      this.edgeInsets = const EdgeInsets.all(10),
      this.isCircleImage = false,
      this.isImageFromFile})
      : super(key: key);

  @override
  State<ImageComponent> createState() => _ImageComponentState();
}

class _ImageComponentState extends State<ImageComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.edgeInsets,
      child: widget.isNetworkImage
          ? ClipRRect(
              borderRadius: widget.isCircleImage
                  ? BorderRadius.circular(100)
                  : BorderRadius.circular(0),
              child: Image.network(
                widget.imageSource!,
                height: widget.height,
                width: widget.width,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Text(
                  error.toString(),
                  style: TextStyle(fontSize: widget.textSize),
                ),
              ),
            )
          : widget.isImageFromFile != null
              ? ClipRRect(
                  borderRadius: widget.isCircleImage
                      ? BorderRadius.circular(100)
                      : BorderRadius.circular(0),
                  child: kIsWeb
                      ? Image.memory(
                          widget.isImageFromFile.bytes,
                          width: widget.width,
                          height: widget.height,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(widget.isImageFromFile!.path),
                          width: widget.width,
                          height: widget.height,
                          fit: BoxFit.cover,
                        ))
              : ClipRRect(
                  borderRadius: widget.isCircleImage
                      ? BorderRadius.circular(100)
                      : BorderRadius.circular(0),
                  child: Image(
                    image: AssetImage(widget.imageSource!),
                    height: widget.height,
                    width: widget.width,
                    fit: BoxFit.cover,
                  )),
    );
  }
}
