import 'package:flutter/material.dart';

class SlidingImages extends StatefulWidget {
  const SlidingImages({
    Key? key,
    required this.item,
  }) : super(key: key);

  final dynamic item;

  @override
  State<SlidingImages> createState() => _SlidingImagesState();
}

class _SlidingImagesState extends State<SlidingImages> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            // logo
            Align(
              alignment: Alignment.topLeft,
              child: Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: Image.asset(
                  "assets/images/logo.jpg",
                  fit: BoxFit.fitWidth,
                  width: 130.0,
                  alignment: Alignment.topLeft,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            // image
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Image.asset(
                widget.item['image'],
                fit: BoxFit.fitWidth,
                width: 380.0,
                alignment: Alignment.bottomCenter,
              ),
            ),
            // header & desc
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Text(widget.item['header'],
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            height: 2.0)),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.item['description'],
                      style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1.2,
                          fontSize: 16.0,
                          height: 1.3),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
