import 'package:paint_shop/app/import.dart';

class MyAnimatedImage extends StatefulWidget {
  const MyAnimatedImage({super.key});

  @override
  State<MyAnimatedImage> createState() => _MyAnimatedImageState();
}

class _MyAnimatedImageState extends State<MyAnimatedImage>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  double _width = 0;
  final double _height = 85.22;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Delay before starting the animation
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _width = 150;
      });
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.linear,
          width: _width,
          height: _height,
          padding: const EdgeInsets.only(left: 20),
          child: Image.asset(
            AppImage.splashImg,
            height: _height,
            width: _width,
            fit: BoxFit.fitHeight,
          ),
        );
      },
    );
  }
}
