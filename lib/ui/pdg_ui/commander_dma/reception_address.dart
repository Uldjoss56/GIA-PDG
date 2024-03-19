import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/paiement/paiement.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class ReceptionAddress extends StatefulWidget {
  const ReceptionAddress({super.key});

  @override
  State<ReceptionAddress> createState() => _ReceptionAddressState();
}

class _ReceptionAddressState extends State<ReceptionAddress> {
  final format = NumberFormat("#,###", "fr");
  Location location = Location();

  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;

  Marker? _cotonouMarker;
  Marker? _parisMarker;

  LatLng cotonou = const LatLng(6.3724685, 2.3261369);
  LatLng paris = const LatLng(48.866667, 2.333333);
  LatLng? myCurrentLocation;

  final searchEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: true,
            mapType: MapType.normal,
            markers: {
              if (_cotonouMarker != null) _cotonouMarker!,
              if (_parisMarker != null) _parisMarker!,
            },
            initialCameraPosition: CameraPosition(
              target: myCurrentLocation ?? cotonou,
              zoom: 17,
            ),
            onMapCreated: (GoogleMapController controller) {
              // You can do something with the controller here
            },
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 40,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      style: IconButton.styleFrom(
                        elevation: 5,
                        backgroundColor: myPink02,
                        foregroundColor: myPink,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_left_rounded,
                        size: 30,
                        weight: 30,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: myGris,
                    ),
                    child: TextFormField(
                      controller: searchEditingController,
                      decoration: InputDecoration(
                        hintText: "Rechercher une adresse",
                        hintStyle: const TextStyle(
                          fontFamily: "Manrope",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: myGrisFonceAA,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        errorBorder: InputBorder.none,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 50,
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              height: 0.5 * height,
              decoration: BoxDecoration(
                color: myWhite,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 1,
                    spreadRadius: 0.1,
                    color: myGrisFonce22,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Votre adresse de réception",
                    style: TextStyle(
                      fontFamily: "Manrope",
                      color: myPink,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Pays : ",
                          style: TextStyle(
                            fontFamily: "Manrope",
                            color: myGrisFonce,
                          ),
                        ),
                        TextSpan(
                          text: "Bénin",
                          style: TextStyle(
                            fontFamily: "Manrope",
                            color: myGrisFonce,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Ville : ",
                          style: TextStyle(
                            fontFamily: "Manrope",
                            color: myGrisFonce,
                          ),
                        ),
                        TextSpan(
                          text: "Abomey-Calavi",
                          style: TextStyle(
                            fontFamily: "Manrope",
                            color: myGrisFonce,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Quatier : ",
                          style: TextStyle(
                            fontFamily: "Manrope",
                            color: myGrisFonce,
                          ),
                        ),
                        TextSpan(
                          text: "Sikècodji, rue 456, allée 82, "
                              "maison 201 Cotonou, Bénin",
                          style: TextStyle(
                            fontFamily: "Manrope",
                            color: myGrisFonce,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ColorFiltered(
                                  colorFilter: const ColorFilter.mode(
                                    myPink,
                                    BlendMode.srcIn,
                                  ),
                                  child: Image.asset(
                                    "assets/img/icons/credit-card_white.png",
                                    width: 0.08 * width,
                                  ),
                                ),
                                const Text(
                                  "Total",
                                  style: TextStyle(
                                    color: myGrisFonce,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Manrope",
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "XOF ${format.format(20000)}",
                              style: const TextStyle(
                                fontFamily: "Manrope",
                                color: myGrisFonce,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: myPink,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(),
                                      shape: ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => const Paiement(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Commander",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _initLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        myCurrentLocation = LatLng(
          currentLocation.latitude!,
          currentLocation.longitude!,
        );
      });
    });

    location.enableBackgroundMode(enable: true);

    _cotonouMarker ??= Marker(
      markerId: const MarkerId("cotonou"),
      infoWindow: const InfoWindow(title: "Cotonou"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      position: cotonou,
    );

    _parisMarker ??= Marker(
      markerId: const MarkerId("paris"),
      infoWindow: const InfoWindow(title: "Paris"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      position: paris,
    );
  }
}
