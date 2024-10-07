import 'package:AARUUSH_CONNECT/Screens/Search/SearchView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


Widget searchTextField({TextEditingController? controller, dynamic onChanged,required BuildContext context}){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
    child: TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor:  Color.fromRGBO(29 , 29, 29, 1),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(18),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(18),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(18),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(18),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        hintText: "Search",
        prefixIcon: const Icon(Icons.search),
        hintStyle: const TextStyle(
          fontSize: 18,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w300,
        ),
      ),
      onTap: (){Get.to(Searchscreen());},
    ),
  );
}

