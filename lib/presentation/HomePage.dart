import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-1.299263152617537, 36.77293016918341),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    String _mapStyle = '';
    rootBundle.loadString('assets/maps/custom_style_map.json').then((string) {
      _mapStyle = string;
    });

    return new Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          // google map
          GoogleMap(
            padding: EdgeInsets.only(bottom: 42),
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              controller.setMapStyle(_mapStyle);
              _controller.complete(controller);
            },
          ),

          // hamburger menu
          Positioned(
              top: 40,
              left: 10,
              child: IconButton(
                icon: Icon(CupertinoIcons.line_horizontal_3),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
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
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            Expanded(
              flex: 5,
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
