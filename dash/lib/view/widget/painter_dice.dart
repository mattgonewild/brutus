part of 'painter_dice_amal.dart';

class DicePaint extends StatelessWidget {
  const DicePaint({super.key, required Color color, required double opacity}) : _color = color, _opacity = opacity;

  final Color _color;
  final double _opacity;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.1428571428571428,
      child: CustomPaint(
        painter: DicePainter(color: _color, opacity: _opacity),
      ),
    );
  }
}

class DicePainter extends CustomPainter {
  const DicePainter({required Color color, required double opacity}) : _color = color, _opacity = opacity;

  final Color _color;
  Color get color => _color;
  final double _opacity;
  double get opacity => _opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();
    
    path.moveTo(size.width*0.4486607,size.height*0.02011719);
    path.cubicTo(size.width*0.4805804,size.height*0.004882813,size.width*0.5191964,size.height*0.004882813,size.width*0.5513393,size.height*0.02011719);
    path.lineTo(size.width*0.9426339,size.height*0.2070313);
    path.cubicTo(size.width*0.9540179,size.height*0.2125000,size.width*0.9611607,size.height*0.2230469,size.width*0.9611607,size.height*0.2343750);
    path.cubicTo(size.width*0.9611607,size.height*0.2457031,size.width*0.9540179,size.height*0.2562500,size.width*0.9426339,size.height*0.2617188);
    path.lineTo(size.width*0.5171875,size.height*0.4648438);
    path.cubicTo(size.width*0.5064732,size.height*0.4699219,size.width*0.4937500,size.height*0.4699219,size.width*0.4830357,size.height*0.4648438);
    path.lineTo(size.width*0.05736607,size.height*0.2617188);
    path.cubicTo(size.width*0.04598214,size.height*0.2562500,size.width*0.03883929,size.height*0.2457031,size.width*0.03883929,size.height*0.2343750);
    path.cubicTo(size.width*0.03883929,size.height*0.2230469,size.width*0.04598214,size.height*0.2125000,size.width*0.05736607,size.height*0.2070313);
    path.lineTo(size.width*0.4486607,size.height*0.02011719);
    path.close();
    path.moveTo(size.width*0.05290179,size.height*0.3320313);
    path.lineTo(size.width*0.4457589,size.height*0.5195313);
    path.cubicTo(size.width*0.4571429,size.height*0.5250000,size.width*0.4642857,size.height*0.5355469,size.width*0.4642857,size.height*0.5468750);
    path.lineTo(size.width*0.4642857,size.height*0.9687500);
    path.cubicTo(size.width*0.4642857,size.height*0.9796875,size.width*0.4575893,size.height*0.9900391,size.width*0.4468750,size.height*0.9957031);
    path.cubicTo(size.width*0.4361607,size.height*1.001367,size.width*0.4225446,size.height*1.001562,size.width*0.4116071,size.height*0.9962891);
    path.lineTo(size.width*0.05580357,size.height*0.8263672);
    path.cubicTo(size.width*0.02142857,size.height*0.8099609,0,size.height*0.7785156,0,size.height*0.7441406);
    path.lineTo(0,size.height*0.3593750);
    path.cubicTo(0,size.height*0.3484375,size.width*0.006696429,size.height*0.3380859,size.width*0.01741071,size.height*0.3324219);
    path.cubicTo(size.width*0.02812500,size.height*0.3267578,size.width*0.04174107,size.height*0.3265625,size.width*0.05267857,size.height*0.3318359);
    path.close();
    path.moveTo(size.width*0.9473214,size.height*0.3320313);
    path.cubicTo(size.width*0.9584821,size.height*0.3267578,size.width*0.9718750,size.height*0.3269531,size.width*0.9825893,size.height*0.3326172);
    path.cubicTo(size.width*0.9933036,size.height*0.3382813,size.width,size.height*0.3484375,size.width,size.height*0.3595703);
    path.lineTo(size.width,size.height*0.7441406);
    path.cubicTo(size.width,size.height*0.7785156,size.width*0.9785714,size.height*0.8099609,size.width*0.9441964,size.height*0.8263672);
    path.lineTo(size.width*0.5886161,size.height*0.9960938);
    path.cubicTo(size.width*0.5774554,size.height*1.001367,size.width*0.5640625,size.height*1.001172,size.width*0.5533482,size.height*0.9955078);
    path.cubicTo(size.width*0.5426339,size.height*0.9898437,size.width*0.5359375,size.height*0.9796875,size.width*0.5359375,size.height*0.9685547);
    path.lineTo(size.width*0.5359375,size.height*0.5468750);
    path.cubicTo(size.width*0.5359375,size.height*0.5353516,size.width*0.5430804,size.height*0.5250000,size.width*0.5544643,size.height*0.5195313);
    path.lineTo(size.width*0.9473214,size.height*0.3320313);
    path.close();

    canvas.drawPath(path, Paint()..color = _color.withOpacity(_opacity));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => (oldDelegate as DicePainter).color != _color || oldDelegate.opacity != _opacity;
}
