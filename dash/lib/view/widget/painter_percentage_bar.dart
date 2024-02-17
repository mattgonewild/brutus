part of 'painter_percentage_bar_amal.dart';

class PercentageBarPaint extends StatelessWidget {
  const PercentageBarPaint({super.key, required double progress}) : _progress = progress;

  final double _progress;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: PercentageBarPainter(progress: _progress));
  }
}

class PercentageBarPainter extends CustomPainter {
  const PercentageBarPainter({
    required double progress,
    startColor = Colors.green,
    midColor = Colors.yellow,
    endColor = Colors.red,
  })  : _progress = progress,
        _startColor = startColor,
        _midColor = midColor,
        _endColor = endColor;

  final double _progress;
  double get progress => _progress;

  final Color _startColor;
  Color get startColor => _startColor;
  final Color _midColor;
  Color get midColor => _midColor;
  final Color _endColor;
  Color get endColor => _endColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect maxRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Rect progressRect = Rect.fromLTWH(0, 0, size.width * _progress.clamp(0.0, 1.0), size.height);

    final Gradient gradient = LinearGradient(colors: [_startColor, _midColor, _endColor], stops: const [0.0, 0.5, 1.0]);

    canvas.drawRect(
      progressRect,
      Paint()
        ..shader = gradient.createShader(maxRect)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => (oldDelegate as PercentageBarPainter).progress != _progress;
}
