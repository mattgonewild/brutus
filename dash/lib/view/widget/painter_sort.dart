part of 'painter_sort_amal.dart';

class SortPaint extends StatelessWidget {
  const SortPaint({
    super.key,
    required Color topColor,
    required Color bottomColor,
  })  : _topColor = topColor,
        _bottomColor = bottomColor;

  final Color _topColor;
  Color get topColor => _topColor;
  final Color _bottomColor;
  Color get bottomColor => _bottomColor;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.667,
      child: CustomPaint(
        painter: SortPainter(topColor: _topColor, bottomColor: _bottomColor),
      ),
    );
  }
}

class SortPainter extends CustomPainter {
  const SortPainter({
    required Color topColor,
    required Color bottomColor,
  })  : _topColor = topColor,
        _bottomColor = bottomColor;

  final Color _topColor;
  Color get topColor => _topColor;
  final Color _bottomColor;
  Color get bottomColor => _bottomColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Path pathTop = Path();
    final Path pathBottom = Path();

    pathTop.moveTo(size.width * 0.4293750, size.height * 0.08085937);
    pathTop.cubicTo(size.width * 0.4684375, size.height * 0.05644531, size.width * 0.5318750, size.height * 0.05644531, size.width * 0.5709375, size.height * 0.08085937);
    pathTop.lineTo(size.width * 0.9709375, size.height * 0.3308594);
    pathTop.cubicTo(size.width * 0.9996875, size.height * 0.3488281, size.width * 1.008125, size.height * 0.3755859, size.width * 0.9925000, size.height * 0.3990234);
    pathTop.cubicTo(size.width * 0.9768750, size.height * 0.4224609, size.width * 0.9406250, size.height * 0.4376953, size.width * 0.9000000, size.height * 0.4376953);
    pathTop.lineTo(size.width * 0.1000000, size.height * 0.4376953);
    pathTop.cubicTo(size.width * 0.05968750, size.height * 0.4376953, size.width * 0.02312500, size.height * 0.4224609, size.width * 0.007500000, size.height * 0.3990234);
    pathTop.cubicTo(size.width * -0.008125000, size.height * 0.3755859, size.width * 0.0006250000, size.height * 0.3488281, size.width * 0.02906250, size.height * 0.3308594);
    pathTop.lineTo(size.width * 0.4290625, size.height * 0.08085938);
    pathTop.close();

    pathBottom.moveTo(size.width * 0.4293750, size.height * 0.9193359);
    pathBottom.lineTo(size.width * 0.02937500, size.height * 0.6693359);
    pathBottom.cubicTo(size.width * 0.0006250000, size.height * 0.6513672, size.width * -0.007812500, size.height * 0.6246094, size.width * 0.007812500, size.height * 0.6011719);
    pathBottom.cubicTo(size.width * 0.02343750, size.height * 0.5777344, size.width * 0.05968750, size.height * 0.5625000, size.width * 0.1003125, size.height * 0.5625000);
    pathBottom.lineTo(size.width * 0.9000000, size.height * 0.5625000);
    pathBottom.cubicTo(size.width * 0.9403125, size.height * 0.5625000, size.width * 0.9768750, size.height * 0.5777344, size.width * 0.9925000, size.height * 0.6011719);
    pathBottom.cubicTo(size.width * 1.008125, size.height * 0.6246094, size.width * 0.9993750, size.height * 0.6513672, size.width * 0.9709375, size.height * 0.6693359);
    pathBottom.lineTo(size.width * 0.5709375, size.height * 0.9193359);
    pathBottom.cubicTo(size.width * 0.5318750, size.height * 0.9437500, size.width * 0.4684375, size.height * 0.9437500, size.width * 0.4293750, size.height * 0.9193359);
    pathBottom.close();

    canvas.drawPath(pathTop, Paint()..color = _topColor);
    canvas.drawPath(pathBottom, Paint()..color = _bottomColor);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => (oldDelegate as SortPainter).topColor != _topColor || oldDelegate.bottomColor != _bottomColor;
}
