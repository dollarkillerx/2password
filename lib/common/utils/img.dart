import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/widgets.dart';

// https://www.liujunmin.com/flutter/io/path_provider.html 临时文件

///带缓存的image
Widget cachedImage(String url, {double? width, double? height}) {
  return CachedNetworkImage(
      height: height,
      width: width,
      fit: BoxFit.cover,
      placeholder: (
        BuildContext context,
        String url,
      ) =>
          Container(color: Colors.grey[200]),
      errorWidget: (
        BuildContext context,
        String url,
        dynamic error,
      ) =>
          Icon(Icons.error),
      imageUrl: url);
}

Image imageFromBase64String(String base64String) {
  return Image.memory(
    base64Decode(base64String),
    fit: BoxFit.fill,
  );
}
