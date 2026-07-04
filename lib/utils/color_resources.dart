import 'package:purplestage_provider/feature/splash/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorResources {

  static Color getRightBubbleColor() {
    return  Theme.of(Get.context!).primaryColor;
  }
  static Color getLeftBubbleColor() {
    return Get.isDarkMode ? const Color(0xA2B7B7BB): Theme.of(Get.context!).colorScheme.secondary.withOpacity(0.1);
  }
  static const Map<String, Color> buttonBackgroundColorMap ={
    'pending': Color(0xffE6EFF6),
    'accepted': Color(0xffEAF4FF),
    'ongoing': Color(0xffEAF4FF),
    'completed': Color(0xffe6f2eb),
    'settled': Color(0xffc8f9e3),
    'canceled': Color(0xffFFEBEB),
    'approved': Color(0xffdbfee9),
    'denied': Color(0xffFFEBEB),
    'expired' : Color(0xfff2f3f4),
    'running' : Color(0xffeceef8),
    'paused': Color(0xffE6EFF6),
    'resumed' : Color(0xffdbfee9),
    'resume' : Color(0xffdbfee9),
    'subscription_purchase' : Color(0x3cecc98d),
    'subscription_renew' : Color(0x1d6bf5a2),
    'subscription_shift' : Color(0x452599ee),
    'subscription_refund' : Color(0x1dc97eee),
  };

  static const Map<String, Color> buttonTextColorMap ={
    'pending': Color(0xff0461A5),
    'accepted': Color(0xff2B95FF),
    'ongoing': Color(0xff2B95FF),
    'completed': Color(0xff207b46),
    'settled': Color(0xf57b9826),
    'canceled': Color(0xffFF3737),
    'approved': Color(0xff16B559),
    'expired' : Color(0xff9ca8af),
    'running' : Color(0xff707ec6),
    'denied':  Color(0xffFF3737),
    'paused': Color(0xff0461A5),
    'resumed' : Color(0xff16B559),
    'resume' : Color(0xff16B559),
    'subscription_purchase' : Color(0xffe7680a),
    'subscription_renew' : Color(0xff16B559),
    'subscription_shift' : Color(0xff0461A5),
    'subscription_refund' : Color(0xffba4af8),
  };
}
List<BoxShadow>? shadow = Get.isDarkMode? null:[
  BoxShadow(
  offset: const Offset(0, 1),
  blurRadius: 2,
  color: Colors.black.withOpacity(0.15),
)];

List<BoxShadow>? lightShadow = [
  const BoxShadow(
    offset: Offset(0, 1),
    blurRadius: 3,
    spreadRadius: 1,
    color: Color(0x20D6D8E6),
  )];

List<BoxShadow>? cardShadow = Get.find<ThemeController>().darkTheme? [const BoxShadow()]:[BoxShadow(
  offset: const Offset(0, 1),
  blurRadius: 6,
  spreadRadius: 1,
  color: Colors.black.withOpacity(0.05),
)];
