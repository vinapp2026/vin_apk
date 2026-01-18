import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  bool isLoading = false;
  bool isLoading2 = false;
  bool isToggle = true;
  bool isToggle1 = true;
  bool isToggle2 = true;
  int tapIndex = 0;
  toggleDone({int? index}) {
    if (index == 0) {
      isToggle = !isToggle;
    } else if (index == 1) {
      isToggle1 = !isToggle1;
    } else if (index == 2) {
      isToggle2 = !isToggle2;
    }
    notifyListeners();
  }

  changeIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  changeIsLoading2(bool value) {
    isLoading2 = value;
    notifyListeners();
  }

  //
  TabController? signInTabController;
  signInTabFung(TickerProvider vsync) {
    signInTabController = TabController(length: 2, vsync: vsync);
    signInTabController!.addListener(signInTabIndexChange);
  }

  signInTabIndexChange() {
    notifyListeners();
  }

  TabController? controller;

  tabFuncation(TickerProvider vsync) {
    controller = TabController(length: 4, vsync: vsync);
    if (controller!.index == 1 || controller!.previousIndex == 0) {
      controller!.addListener(tabIndexChange);
    }
  }

  tabIndexChange() {
    notifyListeners();
  }

  void disposeController() {
    if (signInTabController != null) {
      signInTabController?.removeListener(
          signInTabIndexChange); // Remove the listener with the specific method.
      signInTabController?.dispose();
    }
  }

  void dispose() {
    signInTabController?.dispose();
    super.dispose();
  }

  tabNavigate(int index, {bool? isInit}) {
    controller!.animateTo(index);
    if (isInit == null) {
      notifyListeners();
    }
  }

  //
// Booking screen
  bool isBulk = false;
  bookingtoggle(bool val) {
    isBulk = val;
    notifyListeners();
  }

  Timer? timer1;
  int start = 29;
  bool? visibleButton = false;
  startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer1 = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start <= 0) {
          //_start = 59;
          timer.cancel();
          visibleButton = true;
          // visibleTimer = false;
        } else {
          start = start - 1;
        }
        notifyListeners();
      },
    );
  }
}
