import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final double min, max, value;
  final double width, height;
  final ValueChanged<double> onChanged;

  CustomSlider({
    @required this.value,
    @required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.width = 300.0,
    this.height = 15.0,
  });

  double initial = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 2,
      width: width + height * 2,
      child: GestureDetector(
        onHorizontalDragStart: (details) {
          var xOffset = context.findRenderObject().getTransformTo(null).row0[3];
          var percPos = ((details.globalPosition.dx - xOffset) / width) * max;
          initial = details.globalPosition.dx;
          onChanged(percPos.clamp(min, max));
        },
        onHorizontalDragUpdate: (details) {
          var xOffset = context.findRenderObject().getTransformTo(null).row0[3];
          double distance = details.globalPosition.dx - initial - xOffset;
          double percPos = distance / width * max;
          onChanged(percPos.clamp(min, max));
        },
        onHorizontalDragEnd: (details){
          initial = 0;
        },
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: height/2,
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white30),
                  borderRadius: BorderRadius.circular(height),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 3),
                      color: Color.fromARGB(32, 0, 0, 0),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
              ),
            ),
            // Positioned(
            //   left: 15,
            //   bottom: 7.5,
            //   child: Container(
            //   width: (width * (value / max)).clamp(0, width - 2),
            //   height: height,
            //   decoration: BoxDecoration(
            //      color: Colors.lightBlue,
            //      borderRadius: BorderRadius.circular(height),
            //     ),
            //   ),
            // ),
            Positioned(
              left: 0,
              child: Container(
                width: height * 2,
                height: height * 2,
                margin: EdgeInsets.only(left: ((width-height) * value / max + -height).clamp(0.0, width)),
                foregroundDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 3),
                      color: Color.fromARGB(32, 0, 0, 0),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
