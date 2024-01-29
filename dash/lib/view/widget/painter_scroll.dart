part of 'painter_scroll_amal.dart';

class ScrollPaint extends StatelessWidget {
  const ScrollPaint({super.key, required Color color, required double opacity}) : _color = color, _opacity = opacity;

  final Color _color;
  final double _opacity;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.888888888888889,
      child: CustomPaint(
        painter: ScrollPainter(color: _color, opacity: _opacity),
      ),
    );
  }
}

class ScrollPainter extends CustomPainter {
  const ScrollPainter({required Color color, required double opacity}) : _color = color, _opacity = opacity;

  final Color _color;
  final double _opacity;

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();

    path.moveTo(0,size.height*0.1562500);
    path.lineTo(0,size.height*0.2500000);
    path.cubicTo(0,size.height*0.2845703,size.width*0.02482639,size.height*0.3125000,size.width*0.05555556,size.height*0.3125000);
    path.lineTo(size.width*0.08333333,size.height*0.3125000);
    path.lineTo(size.width*0.1666667,size.height*0.3125000);
    path.lineTo(size.width*0.1666667,size.height*0.1562500);
    path.cubicTo(size.width*0.1666667,size.height*0.1044922,size.width*0.1293403,size.height*0.06250000,size.width*0.08333333,size.height*0.06250000);
    path.cubicTo(size.width*0.03732639,size.height*0.06250000,0,size.height*0.1044922,0,size.height*0.1562500);
    path.close();
    path.moveTo(size.width*0.1944444,size.height*0.06250000);
    path.cubicTo(size.width*0.2118056,size.height*0.08867187,size.width*0.2222222,size.height*0.1210938,size.width*0.2222222,size.height*0.1562500);
    path.lineTo(size.width*0.2222222,size.height*0.7500000);
    path.cubicTo(size.width*0.2222222,size.height*0.8189453,size.width*0.2720486,size.height*0.8750000,size.width*0.3333333,size.height*0.8750000);
    path.cubicTo(size.width*0.3946181,size.height*0.8750000,size.width*0.4444444,size.height*0.8189453,size.width*0.4444444,size.height*0.7500000);
    path.lineTo(size.width*0.4444444,size.height*0.7396484);
    path.cubicTo(size.width*0.4444444,size.height*0.6763672,size.width*0.4901042,size.height*0.6250000,size.width*0.5463542,size.height*0.6250000);
    path.lineTo(size.width*0.8333333,size.height*0.6250000);
    path.lineTo(size.width*0.8333333,size.height*0.2500000);
    path.cubicTo(size.width*0.8333333,size.height*0.1464844,size.width*0.7586806,size.height*0.06250000,size.width*0.6666667,size.height*0.06250000);
    path.lineTo(size.width*0.1944444,size.height*0.06250000);
    path.close();
    path.moveTo(size.width*0.8055556,size.height*0.9375000);
    path.cubicTo(size.width*0.9130208,size.height*0.9375000,size.width,size.height*0.8396484,size.width,size.height*0.7187500);
    path.cubicTo(size.width,size.height*0.7015625,size.width*0.9875000,size.height*0.6875000,size.width*0.9722222,size.height*0.6875000);
    path.lineTo(size.width*0.5463542,size.height*0.6875000);
    path.cubicTo(size.width*0.5208333,size.height*0.6875000,size.width*0.5000000,size.height*0.7107422,size.width*0.5000000,size.height*0.7396484);
    path.lineTo(size.width*0.5000000,size.height*0.7500000);
    path.cubicTo(size.width*0.5000000,size.height*0.8535156,size.width*0.4253472,size.height*0.9375000,size.width*0.3333333,size.height*0.9375000);
    path.lineTo(size.width*0.6388889,size.height*0.9375000);
    path.lineTo(size.width*0.8055556,size.height*0.9375000);
    path.close();

    canvas.drawPath(path, Paint()..color = _color.withOpacity(_opacity));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
