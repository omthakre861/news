import 'package:flutter/material.dart';

class Widgetratio {
  BuildContext context;

  
  Widgetratio(this.context);

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
}
