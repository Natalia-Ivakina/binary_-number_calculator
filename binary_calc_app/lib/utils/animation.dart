import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:binary_calc_app/providers/settigns_model.dart';
import 'package:binary_calc_app/utils/vibration.dart';

//_____________________________________________________________________________
class CustomPageRoute extends PageRouteBuilder {
  final Widget page;

  // Custom page route for animations
  CustomPageRoute(this.page)
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0); // Starting position (right)
            const end = Offset.zero; // Ending position (center)
            const curve = Curves.easeInOut; // Animation curve

            var tween = Tween(begin: begin, end: end);
            var offsetAnimation =
                animation.drive(tween.chain(CurveTween(curve: curve)));

            return SlideTransition(position: offsetAnimation, child: child);
          },
        );
}

//_____________________________________________________________________________
class RotatingImage extends StatefulWidget {
  final String imagePath; // Path to the image

  const RotatingImage({super.key, required this.imagePath});

  @override
  State<RotatingImage> createState() => _RotatingImageState();
}

class _RotatingImageState extends State<RotatingImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isRotating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1), // Reduce time to speed up rotation
      vsync: this,
    ); //..repeat(); // Start animation in a loop

    _animation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  void _toggleRotation() async {
    bool isVibrationOn = context.read<SettingsModel>().isVibrationOn;
    await handleVibration(isVibrationOn);
    if (_isRotating) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      _isRotating = !_isRotating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleRotation,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.rotationY(
                _animation.value * 3 * 3.14159), // Rotation around the Y axis
            alignment: Alignment.center,
            child: Image.asset(
              widget.imagePath, // Use the provided image path
              width: MediaQuery.of(context).size.width * 0.18,
              height: MediaQuery.of(context).size.width * 018,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
