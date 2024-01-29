part of 'painter_gear_amal.dart';

class GearPaint extends StatelessWidget {
  const GearPaint({super.key, required Color color, required double opacity}) : _color = color, _opacity = opacity;

  final Color _color;
  final double _opacity;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        painter: GearPainter(color: _color, opacity: _opacity),
      ),
    );
  }
}

class GearPainter extends CustomPainter {
  const GearPainter({required Color color, required double opacity}) : _color = color, _opacity = opacity;

  final Color _color;
  final double _opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();

    path.moveTo(size.width*0.9685547,size.height*0.3253906);
    path.cubicTo(size.width*0.9748047,size.height*0.3423828,size.width*0.9695312,size.height*0.3613281,size.width*0.9560547,size.height*0.3734375);
    path.lineTo(size.width*0.8714844,size.height*0.4503906);
    path.cubicTo(size.width*0.8736328,size.height*0.4666016,size.width*0.8748047,size.height*0.4832031,size.width*0.8748047,size.height*0.5000000);
    path.cubicTo(size.width*0.8748047,size.height*0.5167969,size.width*0.8736328,size.height*0.5333984,size.width*0.8714844,size.height*0.5496094);
    path.lineTo(size.width*0.9560547,size.height*0.6265625);
    path.cubicTo(size.width*0.9695312,size.height*0.6386719,size.width*0.9748047,size.height*0.6576172,size.width*0.9685547,size.height*0.6746094);
    path.cubicTo(size.width*0.9599609,size.height*0.6978516,size.width*0.9496094,size.height*0.7201172,size.width*0.9376953,size.height*0.7416016);
    path.lineTo(size.width*0.9285156,size.height*0.7574219);
    path.cubicTo(size.width*0.9156250,size.height*0.7789063,size.width*0.9011719,size.height*0.7992187,size.width*0.8853516,size.height*0.8183594);
    path.cubicTo(size.width*0.8738281,size.height*0.8324219,size.width*0.8546875,size.height*0.8371094,size.width*0.8375000,size.height*0.8316406);
    path.lineTo(size.width*0.7287109,size.height*0.7970703);
    path.cubicTo(size.width*0.7025391,size.height*0.8171875,size.width*0.6736328,size.height*0.8339844,size.width*0.6427734,size.height*0.8466797);
    path.lineTo(size.width*0.6183594,size.height*0.9582031);
    path.cubicTo(size.width*0.6144531,size.height*0.9759766,size.width*0.6007812,size.height*0.9900391,size.width*0.5828125,size.height*0.9929688);
    path.cubicTo(size.width*0.5558594,size.height*0.9974609,size.width*0.5281250,size.height*0.9998047,size.width*0.4998047,size.height*0.9998047);
    path.cubicTo(size.width*0.4714844,size.height*0.9998047,size.width*0.4437500,size.height*0.9974609,size.width*0.4167969,size.height*0.9929688);
    path.cubicTo(size.width*0.3988281,size.height*0.9900391,size.width*0.3851562,size.height*0.9759766,size.width*0.3812500,size.height*0.9582031);
    path.lineTo(size.width*0.3568359,size.height*0.8466797);
    path.cubicTo(size.width*0.3259766,size.height*0.8339844,size.width*0.2970703,size.height*0.8171875,size.width*0.2708984,size.height*0.7970703);
    path.lineTo(size.width*0.1623047,size.height*0.8318359);
    path.cubicTo(size.width*0.1451172,size.height*0.8373047,size.width*0.1259766,size.height*0.8324219,size.width*0.1144531,size.height*0.8185547);
    path.cubicTo(size.width*0.09863281,size.height*0.7994141,size.width*0.08417969,size.height*0.7791016,size.width*0.07128906,size.height*0.7576172);
    path.lineTo(size.width*0.06210937,size.height*0.7417969);
    path.cubicTo(size.width*0.05019531,size.height*0.7203125,size.width*0.03984375,size.height*0.6980469,size.width*0.03125000,size.height*0.6748047);
    path.cubicTo(size.width*0.02500000,size.height*0.6578125,size.width*0.03027344,size.height*0.6388672,size.width*0.04375000,size.height*0.6267578);
    path.lineTo(size.width*0.1283203,size.height*0.5498047);
    path.cubicTo(size.width*0.1261719,size.height*0.5333984,size.width*0.1250000,size.height*0.5167969,size.width*0.1250000,size.height*0.5000000);
    path.cubicTo(size.width*0.1250000,size.height*0.4832031,size.width*0.1261719,size.height*0.4666016,size.width*0.1283203,size.height*0.4503906);
    path.lineTo(size.width*0.04375000,size.height*0.3734375);
    path.cubicTo(size.width*0.03027344,size.height*0.3613281,size.width*0.02500000,size.height*0.3423828,size.width*0.03125000,size.height*0.3253906);
    path.cubicTo(size.width*0.03984375,size.height*0.3021484,size.width*0.05019531,size.height*0.2798828,size.width*0.06210937,size.height*0.2583984);
    path.lineTo(size.width*0.07128906,size.height*0.2425781);
    path.cubicTo(size.width*0.08417969,size.height*0.2210938,size.width*0.09863281,size.height*0.2007813,size.width*0.1144531,size.height*0.1816406);
    path.cubicTo(size.width*0.1259766,size.height*0.1675781,size.width*0.1451172,size.height*0.1628906,size.width*0.1623047,size.height*0.1683594);
    path.lineTo(size.width*0.2710938,size.height*0.2029297);
    path.cubicTo(size.width*0.2972656,size.height*0.1828125,size.width*0.3261719,size.height*0.1660156,size.width*0.3570313,size.height*0.1533203);
    path.lineTo(size.width*0.3814453,size.height*0.04179688);
    path.cubicTo(size.width*0.3853516,size.height*0.02402344,size.width*0.3990234,size.height*0.009960938,size.width*0.4169922,size.height*0.007031250);
    path.cubicTo(size.width*0.4439453,size.height*0.002343750,size.width*0.4716797,0,size.width*0.5000000,0);
    path.cubicTo(size.width*0.5283203,0,size.width*0.5560547,size.height*0.002343750,size.width*0.5830078,size.height*0.006835938);
    path.cubicTo(size.width*0.6009766,size.height*0.009765625,size.width*0.6146484,size.height*0.02382812,size.width*0.6185547,size.height*0.04160156);
    path.lineTo(size.width*0.6429687,size.height*0.1531250);
    path.cubicTo(size.width*0.6738281,size.height*0.1658203,size.width*0.7027344,size.height*0.1826172,size.width*0.7289062,size.height*0.2027344);
    path.lineTo(size.width*0.8376953,size.height*0.1681641);
    path.cubicTo(size.width*0.8548828,size.height*0.1626953,size.width*0.8740234,size.height*0.1675781,size.width*0.8855469,size.height*0.1814453);
    path.cubicTo(size.width*0.9013672,size.height*0.2005859,size.width*0.9158203,size.height*0.2208984,size.width*0.9287109,size.height*0.2423828);
    path.lineTo(size.width*0.9378906,size.height*0.2582031);
    path.cubicTo(size.width*0.9498047,size.height*0.2796875,size.width*0.9601562,size.height*0.3019531,size.width*0.9687500,size.height*0.3251953);
    path.close();
    path.moveTo(size.width*0.5000000,size.height*0.6562500);
    path.arcToPoint(Offset(size.width*0.5000000,size.height*0.3437500),radius: Radius.elliptical(size.width*0.1562500, size.height*0.1562500),rotation: 0 ,largeArc: true,clockwise: false);
    path.arcToPoint(Offset(size.width*0.5000000,size.height*0.6562500),radius: Radius.elliptical(size.width*0.1562500, size.height*0.1562500),rotation: 0 ,largeArc: true,clockwise: false);
    path.close();

    canvas.drawPath(path, Paint()..color = _color.withOpacity(_opacity));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
