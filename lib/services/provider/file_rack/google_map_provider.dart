// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_webservice/places.dart';
// class GoogleMapProvider extends ChangeNotifier{
//    final route ='';
//   late LatLng _gpsactual;
//   LatLng initialposition = LatLng(-0, -0);
//   final activegps = true;
//   TextEditingController locationController = TextEditingController();
//   late GoogleMapController _mapController;
//   LatLng get gpsPosition => _gpsactual;
//   LatLng get initialPos => initialposition;
//   final Set<Marker> _markers = Set();

//   Set<Marker> get markers => _markers;

//   GoogleMapController get mapController => _mapController;
//   final TextEditingController Mapcontroller = TextEditingController();
//   bool isLoading = false;
//   Placemark pickPlaceMark1 = Placemark();

//   Placemark get pickPlaceMark => pickPlaceMark1;
//   List<Prediction> predictionList = [];
//   List markerList = [];
//   final markerIdList = [];
//   final imgUrl = '';
//   List<double> lat = []; // Creating an empty list for latitude values
//   List<double> long = []; // Creating an empty list for longitude values
//   final isListening = false;
//   //SpeechToText speechToText =SpeechToText();
//   final data = Get.arguments;



//   ///Search Map Location
//   Future<List<Prediction>> searchLocation(
//       BuildContext context, String text) async {
//     if (text != null && text.isNotEmpty) {
//       http.Response response = await getLocationData(text);
//       var data = jsonDecode(response.body.toString());
//       print("my status is " + data["status"]);
//       if (data['status'] == 'OK') {
//         predictionList = [];
//         data['predictions'].forEach((prediction) => predictionList.add(Prediction.fromJson(prediction)));
//       } else {
//         // ApiChecker.checkApi(response);
//       }
//     }
//     return predictionList;
//   }

// }