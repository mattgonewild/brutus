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
  const PercentageBarPainter({required double progress}) : _progress = progress;

  final double _progress;
  double get progress => _progress;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => (oldDelegate as PercentageBarPainter).progress != _progress;
}
