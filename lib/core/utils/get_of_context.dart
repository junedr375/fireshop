import 'package:flutter/material.dart';

///Getting MediaQuesry ScreenSize
Size getMediaQuerySize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double getMainAxisHeight(BuildContext context) {
  Size size = getMediaQuerySize(context);
  return size.height > size.width ? size.height : size.width;
}
