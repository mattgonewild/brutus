import 'package:flutter/material.dart';

class StopPaint extends StatelessWidget {
  const StopPaint({super.key, required Color color, required double opacity}) : _color = color, _opacity = opacity;

  final Color _color;
  final double _opacity;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.888888888888889,
      child: CustomPaint(
        painter: StopPainter(color: _color, opacity: _opacity),
      ),
    );
  }
}

class StopPainter extends CustomPainter {
  const StopPainter({required Color color, required double opacity}) : _color = color, _opacity = opacity;

  final Color _color;
  final double _opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();

    path.moveTo(0,size.height*0.2500000);
    path.cubicTo(0,size.height*0.1810547,size.width*0.07473958,size.height*0.1250000,size.width*0.1666667,size.height*0.1250000);
    path.lineTo(size.width*0.8333333,size.height*0.1250000);
    path.cubicTo(size.width*0.9252604,size.height*0.1250000,size.width,size.height*0.1810547,size.width,size.height*0.2500000);
    path.lineTo(size.width,size.height*0.7500000);
    path.cubicTo(size.width,size.height*0.8189453,size.width*0.9252604,size.height*0.8750000,size.width*0.8333333,size.height*0.8750000);
    path.lineTo(size.width*0.1666667,size.height*0.8750000);
    path.cubicTo(size.width*0.07473958,size.height*0.8750000,0,size.height*0.8189453,0,size.height*0.7500000);
    path.lineTo(0,size.height*0.2500000);
    path.close();

    canvas.drawPath(path, Paint()..color = _color.withOpacity(_opacity));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
