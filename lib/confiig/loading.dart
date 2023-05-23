import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingConfig {
  set() {
    EasyLoading.instance
      ..boxShadow = [const BoxShadow(color: Colors.transparent)]
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.white
      ..backgroundColor = Colors.black
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskType = EasyLoadingMaskType.clear
      ..userInteractions = false
      ..dismissOnTap = false;
  }
}

showLoading() {
  EasyLoading.show(
    status: "Loading...",
  );
}

hideLoading() {
  EasyLoading.dismiss(animation: true);
}
