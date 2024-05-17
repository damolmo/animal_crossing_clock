// Global variable to be shared across the application
import 'package:flutter/cupertino.dart';

double getDeviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
double getDeviceHeight(BuildContext context) => MediaQuery.of(context).size.height;