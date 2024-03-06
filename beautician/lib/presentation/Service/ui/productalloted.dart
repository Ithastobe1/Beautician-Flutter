import 'package:flutter/material.dart';

import '../model/servicepagemodel.dart';

class ProductAlloted extends StatefulWidget {
 Booking ?booking;
 ProductAlloted({super.key, required this.booking});

  @override
  State<ProductAlloted> createState() => _ProductAllotedState();
}

class _ProductAllotedState extends State<ProductAlloted> {
  bool rememberMe = false;

  void _onRememberMeChanged(newValue) => setState(() {
        rememberMe = newValue;

        if (rememberMe) {
          // TODO: Here goes your functionality that remembers the user.
        } else {
          // TODO: Forget the user
        }
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: widget.booking!.bookingsItems!.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Checkbox(value: rememberMe, onChanged: _onRememberMeChanged),
                  Text(
                    "hello world",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              );
            }));
  }
}
