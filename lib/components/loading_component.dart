
import 'package:cotacao_moeda/components/image_component.dart';
import 'package:flutter/material.dart';

class LoadingComponent extends StatefulWidget {
  
  LoadingComponent({ Key? key }) : super(key: key);

  @override
  _LoadingComponentState createState() => _LoadingComponentState();
}

class _LoadingComponentState extends State<LoadingComponent> with SingleTickerProviderStateMixin {

  late AnimationController animationController;

  final double pi = 3.1415926535897932;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat();
  }

  @override
  dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var widthLeft = 30.0;
    var heightLeft = 30.0;

    var widthRight = 50.0;
    var heightRight = 50.0;

    return Stack(      
      alignment: Alignment.center,
      children: [
        Center(child: AnimatedBuilder(
            animation: animationController,
            builder: (_, child) {
              return Transform.rotate(
                angle: animationController.value * 2 * pi,
                child: child,
              );
            },
            child: ImageComponent(uri: "assets/images/d1d10576-2038-4479-9879-2b631983fb0c.png", height: heightLeft, width: widthLeft))),
        Center(child: AnimatedBuilder(
          animation: animationController,
          builder: (_, child) {
            return Transform.rotate(
              angle: animationController.value * 2 * pi,
              child: child,
            );
          },
          child: ImageComponent(uri: "assets/images/bdc30dca-7ae0-4510-b971-c7dac3aa04f3.png",height: heightRight, width: widthRight))),
      ],
    );
  }
}
