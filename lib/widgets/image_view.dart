import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:practical_app/constant/colors.dart';
import 'package:practical_app/constant/strings.dart';

class CommanImageView extends StatelessWidget {
  final String imageUrl;
  const CommanImageView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => const Center(
        child: Text(
          ConstStrings.loadingImageStr,
          style: TextStyle(
            color: ConstColor.blackColor,
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        color: ConstColor.blackColor,
      ),
      fit: BoxFit.cover,
    );
  }
}
