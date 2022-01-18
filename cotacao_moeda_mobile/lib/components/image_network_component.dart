import 'package:cotacao_moeda/components/loading_component.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageNetworkComponent extends StatelessWidget {
  String uri;
  double? width;
  double? height;
  String? heroTag;
  ImageNetworkComponent({Key? key, required this.uri, this.width, this.height, this.heroTag }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imageCached = CachedNetworkImage(
        placeholder: (context, url) =>
          LoadingComponent(),
          imageUrl: uri,
          width:  width,
          height: height,
          fit: BoxFit.fill,
        );

    if(heroTag != null){
      return Hero(
        tag: heroTag.toString(),
        child: imageCached,
      );
    }

    return imageCached;
  }
}
