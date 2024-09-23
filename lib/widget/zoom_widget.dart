import 'package:flutter/material.dart';
import 'package:pinch_zoom_release_unzoom/pinch_zoom_release_unzoom.dart';

Widget zoomInOutWidget({required Widget child}) {
  return PinchZoomReleaseUnzoomWidget(
      minScale: 0.8,
      maxScale: 4,
      resetDuration: const Duration(milliseconds: 200),
      boundaryMargin: const EdgeInsets.only(bottom: 0),
      clipBehavior: Clip.none,
      useOverlay: true,
      overlayColor: Colors.black,
      fingersRequiredToPinch: 2,
      child: child);
}
