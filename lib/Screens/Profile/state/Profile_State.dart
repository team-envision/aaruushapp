import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileState extends GetXState{
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final formkey = GlobalKey<FormState>();

}