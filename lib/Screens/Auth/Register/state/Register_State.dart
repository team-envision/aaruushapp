import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterState extends GetXState{
  final formKey = GlobalKey<FormState>();
  String? googleUserEmail;
  RxDouble height = (Get.height * 0.55).obs;
  TextEditingController NameTextEditingController = TextEditingController();
  TextEditingController CollgeTextEditingController = TextEditingController();
  TextEditingController RegNoTextEditingController = TextEditingController();
  TextEditingController PhNoTextEditingController = TextEditingController();
  TextEditingController EmailTextEditingController = TextEditingController();


}