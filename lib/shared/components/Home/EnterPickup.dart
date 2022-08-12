import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/value_objects/app_strings.dart';
import '../../Colors.dart';

class EnterPickup extends StatelessWidget {
  const EnterPickup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      left: 20,
      right: 20,
      child: Card(
        elevation: 15,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: ListTile(
          dense: true,
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          contentPadding: EdgeInsets.fromLTRB(30, 10, 30, 10),
          leading: Icon(
            CupertinoIcons.location_solid,
            color: Colors.orange,
            size: 20,
          ),
          title: Text(
            enterPickupText,
            style: TextStyle(
              fontSize: 17,
              color: Colors.black,
            ),
          ),
          trailing: Icon(
            CupertinoIcons.chevron_right_2,
            color: AppColors.primaryColor,
            size: 20,
          ),
        ),
      ),
    );
  }
}
