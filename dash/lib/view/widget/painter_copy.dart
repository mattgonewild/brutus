part of 'painter_copy_amal.dart';

class CopyPaint extends StatelessWidget {
  const CopyPaint({super.key, required Color color, required double opacity})
      : _color = color,
        _opacity = opacity;

  final Color _color;
  Color get color => _color;
  final double _opacity;
  double get opacity => _opacity;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.1428571428571428,
      child: CustomPaint(
        painter: CopyPainter(color: _color, opacity: _opacity),
      ),
    );
  }
}

class CopyPainter extends CustomPainter {
  const CopyPainter({required Color color, required double opacity})
      : _color = color,
        _opacity = opacity;

  final Color _color;
  Color get color => _color;
  final double _opacity;
  double get opacity => _opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();

    path.moveTo(size.width * 0.4642857, 0);
    path.lineTo(size.width * 0.7412946, 0);
    path.cubicTo(size.width * 0.7696429, 0, size.width * 0.7968750, size.height * 0.009960937, size.width * 0.8169643, size.height * 0.02753906);
    path.lineTo(size.width * 0.9685268, size.height * 0.1601563);
    path.cubicTo(size.width * 0.9886161, size.height * 0.1777344, size.width, size.height * 0.2015625, size.width, size.height * 0.2263672);
    path.lineTo(size.width, size.height * 0.6562500);
    path.cubicTo(size.width, size.height * 0.7080078, size.width * 0.9520089, size.height * 0.7500000, size.width * 0.8928571, size.height * 0.7500000);
    path.lineTo(size.width * 0.4642857, size.height * 0.7500000);
    path.cubicTo(size.width * 0.4051339, size.height * 0.7500000, size.width * 0.3571429, size.height * 0.7080078, size.width * 0.3571429, size.height * 0.6562500);
    path.lineTo(size.width * 0.3571429, size.height * 0.09375000);
    path.cubicTo(size.width * 0.3571429, size.height * 0.04199219, size.width * 0.4051339, 0, size.width * 0.4642857, 0);
    path.close();
    path.moveTo(size.width * 0.1071429, size.height * 0.2500000);
    path.lineTo(size.width * 0.2857143, size.height * 0.2500000);
    path.lineTo(size.width * 0.2857143, size.height * 0.3750000);
    path.lineTo(size.width * 0.1428571, size.height * 0.3750000);
    path.lineTo(size.width * 0.1428571, size.height * 0.8750000);
    path.lineTo(size.width * 0.5714286, size.height * 0.8750000);
    path.lineTo(size.width * 0.5714286, size.height * 0.8125000);
    path.lineTo(size.width * 0.7142857, size.height * 0.8125000);
    path.lineTo(size.width * 0.7142857, size.height * 0.9062500);
    path.cubicTo(size.width * 0.7142857, size.height * 0.9580078, size.width * 0.6662946, size.height, size.width * 0.6071429, size.height);
    path.lineTo(size.width * 0.1071429, size.height);
    path.cubicTo(size.width * 0.04799107, size.height, 0, size.height * 0.9580078, 0, size.height * 0.9062500);
    path.lineTo(0, size.height * 0.3437500);
    path.cubicTo(0, size.height * 0.2919922, size.width * 0.04799107, size.height * 0.2500000, size.width * 0.1071429, size.height * 0.2500000);
    path.close();

    canvas.drawPath(path, Paint()..color = _color.withOpacity(_opacity));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => (oldDelegate as CopyPainter).color != _color || oldDelegate.opacity != _opacity;
}
