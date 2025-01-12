import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//svg

class MyIcon extends StatelessWidget {
  final String iconPath;
  final Color color;
  final double size;

  MyIcon({
    required this.iconPath,
    this.color = Colors.black,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      color: color,
      width: size,
      height: size,
    );
  }
}

 // dotted line

class DottedLinePainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double dashLength;
  final double dashSpace;

  DottedLinePainter({
    this.strokeWidth = 0.8,
    this.color = const Color(0xff717171),
    this.dashLength = 4.0,
    this.dashSpace = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashLength, 0),
        paint,
      );
      startX +=2* dashLength;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DottedContainer extends StatelessWidget {
  final double height;
  final String name;
  final String frequency;
  final TextStyle textStyle;
  final Color backgroundColor;

  DottedContainer({
    required this.height,
    required this.name,
    required this.frequency,
    required this.textStyle,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0,top: 5),
            child: Row(
              children: [
                Text(name, style: textStyle),
                SizedBox(width: 4),
                Text("($frequency)",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black87)),
              ],
            ),
          ),

        ],
      ),
    );
  }
}


