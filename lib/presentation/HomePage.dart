import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sendy_case_study/shared/Colors.dart';

import '../domain/value_objects/app_strings.dart';
import '../shared/components/Home/EnterPickup.dart';
import '../shared/components/Home/NavigationDrawerItem.dart';

import 'package:flutter/services.dart' show rootBundle;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controller = Completer();

  late LatLng currentLatLng;

  /// Determine the current position of the device.
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true.

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(locationPermissionDeniedText),
        ));

        return Future.error(locationPermissionDeniedText);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(locationPermissionPermanentlyDeniedText),
      ));
      return Future.error(locationPermissionPermanentlyDeniedText);
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    currentLatLng = LatLng(position.latitude, position.longitude);
    return position;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    String _mapStyle = '';
    rootBundle.loadString('assets/maps/custom_style_map.json').then((string) {
      _mapStyle = string;
    });

    return new Scaffold(
      key: _scaffoldKey,
      body: FutureBuilder<Position>(
          future: _determinePosition(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: <Widget>[
                  // google map
                  GoogleMap(
                    padding: EdgeInsets.only(bottom: 42, top: 30),
                    mapType: MapType.normal,
                    initialCameraPosition:
                        CameraPosition(target: currentLatLng, zoom: 17),
                    onMapCreated: (GoogleMapController controller) {
                      controller.setMapStyle(_mapStyle);
                      controller.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(target: currentLatLng, zoom: 17),
                        ),
                      );
                      _controller.complete(controller);
                    },
                    myLocationEnabled: true,
                  ),

                  // hamburger menu
                  Positioned(
                      top: 40,
                      left: 10,
                      child: IconButton(
                        icon: Icon(
                          CupertinoIcons.line_horizontal_3,
                          color: Colors.black,
                        ),
                        onPressed: () =>
                            _scaffoldKey.currentState?.openDrawer(),
                      )),

                  // enter pickup
                  width >= 500
                      ? Positioned(
                          top: 120,
                          left: 100,
                          child: Center(
                            child: SizedBox(
                              width: 400,
                              child: EnterPickup(),
                            ),
                          ),
                        )
                      : EnterPickup(),
                ],
              );
            }
            return Center(
              child: LoadingAnimationWidget.beat(
                color: AppColors.primaryColor,
                size: 24,
              ),
            );
          }),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  //  header
                  DrawerHeader(
                    decoration: BoxDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(28.0),
                          child: Image(
                            image: AssetImage('assets/images/user_avatar.jpeg'),
                            width: 55,
                            height: 55,
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Text(
                          userText,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // items
                  NavigationDrawerItem(
                    leading: Icons.share_outlined,
                    title: shareText,
                  ),
                  NavigationDrawerItem(
                    leading: Icons.account_circle_outlined,
                    title: profileText,
                  ),
                  NavigationDrawerItem(
                    leading: Icons.payments,
                    title: paymentText,
                  ),
                  NavigationDrawerItem(
                    leading: Icons.list_alt,
                    title: orderHistoryText,
                  ),
                  NavigationDrawerItem(
                    leading: CupertinoIcons.tag_fill,
                    title: promotionsText,
                  ),
                  NavigationDrawerItem(
                    leading: Icons.help_outline,
                    title: helpText,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: NavigationDrawerItem(
                leading: CupertinoIcons.line_horizontal_3,
                title: appVersionText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
