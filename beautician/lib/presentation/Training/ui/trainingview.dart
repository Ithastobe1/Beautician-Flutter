import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/color.dart';

class TrainingView extends StatefulWidget {
  const TrainingView({super.key});

  @override
  State<TrainingView> createState() => _TrainingViewState();
}

class _TrainingViewState extends State<TrainingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Training".tr,
          style: TextStyle(
              fontSize: 24,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        backgroundColor: AppColors.themecolors,
      ),
      body: SafeArea(child: Center(child: CircularProgressIndicator())),
    );
  }
}
