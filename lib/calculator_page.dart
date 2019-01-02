import 'package:flutter/material.dart';
import 'package:bmi_calculator/custom_slider.dart';

class CaclulatorPage extends StatefulWidget {
  @override
  _CaclulatorPageState createState() => _CaclulatorPageState();
}

class _CaclulatorPageState extends State<CaclulatorPage> {
  bool _isMetric = true;
  double _bmi = 0.0;
  double _height = 100.0;
  double _weight = 40.0;
  double _sliderWidth = 300.0;
  double _sliderHeight = 15.0;

  TextStyle _bmiHeadingStyle = TextStyle(
      fontFamily: 'helvetica',
      fontSize: 104.0,
      color: Color.fromARGB(255, 76, 165, 242),
      shadows: <Shadow>[
        Shadow(
          offset: Offset(0, 3.0),
          blurRadius: 6.0,
          color: Color.fromARGB(40, 0, 0, 0),
        )
      ]);
  TextStyle _subheadingStyle = TextStyle(
    fontFamily: 'helvetica-light',
    fontSize: 28.0,
    color: Color.fromARGB(255, 76, 165, 242),
  );
  TextStyle _sliderTextStyle = TextStyle(
    fontFamily: 'helvetica-light',
    fontSize: 28.0,
    color: Color.fromARGB(255, 76, 165, 242),
  );

  Future<void> _bmiInfo() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'About BMI',
            style: _subheadingStyle,
          ),
          content: SingleChildScrollView(
            child: Text(
              "Body Mass Index is a screening tool that can indicate whether a person is underweight or if they have a healthy weight, excess weight, or obesity. If a person's BMI is outside of the healthy range, their health risks may increase significantly.",
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  String _getRecommendation() {
    String recommendation;
    if (_height > 80 && _weight > 40) {
      _bmi = _weight / ((_height / 100.0) * (_height / 100.0));
      if (_bmi < 18.5)
        recommendation = "You're considered to be underweight.";
      else if (_bmi < 25)
        recommendation = "You're within a healthy weight range!";
      else if (_bmi < 30)
        recommendation = "You're considered to be overweight.";
      else if (_bmi >= 30) recommendation = "You're considered to be obese.";
    } else {
      _bmi = 0.0;
      recommendation =
          "Enter your height and weight below to calculate your BMI.";
    }
    return recommendation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 45,
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _bmi > 0
                        ? Text(
                            _bmi.toStringAsFixed(1),
                            style: _bmiHeadingStyle,
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Text(
                        _getRecommendation(),
                        textAlign: TextAlign.center,
                        style: _subheadingStyle,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 15,
                  right: 15,
                  child: GestureDetector(
                    onTap: () {
                      _bmiInfo();
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 3),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 3),
                            color: Color.fromARGB(32, 0, 0, 0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Text(
                        "?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'helvetica-light',
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 55,
            child: Container(
              padding: EdgeInsets.only(bottom: 20),
              color: Color.fromARGB(255, 250, 250, 234),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //Male Female
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTapDown: (TapDownDetails details) {
                          setState(() {
                            _isMetric = true;
                          });
                        },
                        child: Container(
                          width: 141.0,
                          height: 61.0,
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            boxShadow: [
                              BoxShadow(
                                offset: _isMetric ? Offset(0, -3) : Offset(0, 3),
                                color: Color.fromARGB(32, 0, 0, 0),
                                blurRadius: 6.0,
                              ),
                            ],
                            color: _isMetric ? Colors.blue : Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              "Metric",
                              style: TextStyle(
                                  fontFamily: 'helvetica-light',
                                  fontSize: 20.0,
                                  color: _isMetric
                                      ? Colors.white
                                      : Color.fromARGB(255, 76, 165, 242)),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTapDown: (TapDownDetails details) {
                          setState(() {
                            _isMetric = false;
                          });
                        },
                        child: Container(
                          width: 141.0,
                          height: 61.0,
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            boxShadow: [
                              BoxShadow(
                                offset:
                                    !_isMetric ? Offset(0, -3) : Offset(0, 3),
                                color: Color.fromARGB(32, 0, 0, 0),
                                blurRadius: 6.0,
                              ),
                            ],
                            color: !_isMetric ? Colors.blue : Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              "Imperial",
                              style: TextStyle(
                                  fontFamily: 'helvetica-light',
                                  fontSize: 20.0,
                                  color: !_isMetric
                                      ? Colors.white
                                      : Color.fromARGB(255, 76, 165, 242)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: _sliderWidth,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            _isMetric
                                ? _height.toStringAsFixed(1) + " cm"
                                : (_height / 2.54).toStringAsFixed(1) + " in",
                            style: _sliderTextStyle,
                          ),
                        ),
                        CustomSlider(
                          min: 0.0,
                          max: 220,
                          width: _sliderWidth,
                          height: _sliderHeight,
                          value: _height,
                          onChanged: (newValue) {
                            setState(() {
                              _height = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: _sliderWidth,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            _isMetric
                                ? _weight.toStringAsFixed(1) + " kg"
                                : (_weight * 2.205).toStringAsFixed(1) + " lb",
                            style: _sliderTextStyle,
                          ),
                        ),
                        CustomSlider(
                          min: 0.0,
                          max: 150.0,
                          width: _sliderWidth,
                          height: _sliderHeight,
                          value: _weight,
                          onChanged: (newValue) {
                            setState(() {
                              _weight = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
