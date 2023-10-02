import 'package:flutter/material.dart';

import '../../../constants/local_images_file.dart';

class MostPopular {
  String restaurentname, serve, time;
  String imagepath;
  VoidCallback? onsav;
  bool isbookmark;

  MostPopular({
    required this.restaurentname,
    required this.serve,
    required this.time,
    required this.imagepath,
    this.onsav,
    this.isbookmark = false,
  });

  static List<MostPopular> getFollowingInfolist = [
    MostPopular(
      restaurentname: "باستا بحرية",
      serve: '2 شخص',
      imagepath: LocalImagesFile.seafood_pasta,
      time: '35 دقيقة.',
    ),
    MostPopular(
      restaurentname: "باستا خضار",
      serve: '2 شخص',
      imagepath: LocalImagesFile.vegetable_pasta,
      time: '35 دقيقة.',
    ),
    MostPopular(
      restaurentname: "سوشي",
      serve: '2 شخص',
      imagepath: LocalImagesFile.sushi,
      time: '35 دقيقة.',
    ),
  ];
}
