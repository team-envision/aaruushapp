import 'package:AARUUSH_CONNECT/Screens/Search/views/SearchView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


Widget searchTextField({TextEditingController? controller, dynamic onChanged,required BuildContext context}){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 12),
    child: SizedBox(height: 55,
      child: TextField(readOnly: true,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor:  Color.fromRGBO(29 , 29, 29, 1),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(30),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(30),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(30),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          hintText: "Search",
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(Icons.search, color: Colors.white),
          ),
          hintStyle: const TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w300,
              color: Colors.white
          ),
        ),
        onTap: (){Get.to(Searchscreen());},
      ),
    ),
  );
}

