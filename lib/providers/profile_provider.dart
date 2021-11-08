import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  bool isUpdating = false;

  update() async {
    isUpdating = true;
    notifyListeners();
    await Future.delayed(
      const Duration(seconds: 3),
    );
    isUpdating = false;
    notifyListeners();
  }
}
