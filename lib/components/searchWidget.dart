import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'CustomIcons.dart';
// Color color1 = Color(0xFFFF723D) ;
 bool i=true;
findcolor(bool i){
  if (i){
    return Color(0xFFFF723D);
  }
  else{
    return Colors.black;
  }
}
class searchWidget extends StatefulWidget {
  const searchWidget({Key? key}) : super(key: key);

  @override
  State<searchWidget> createState() => _searchWidgetState();
}

class _searchWidgetState extends State<searchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              style: const TextStyle(
                color: Colors.white,
              ),
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                  fillColor: const Color(0xFFFF723D),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                  ),
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 18
                  ),
                  prefixIcon: const Icon(Icons.search,color: Color(0xFF666666),),
                suffixIcon:  Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: GestureDetector(
                      onTap: ()=>setState(() {

                        i= !i;

                      }),
                      // onSecondaryTap: ()=>setState(() {
                      //   print("HI");
                      //   color1=Color(0xFFFF723D);
                      //
                      // }),
                      child: Container(
                        decoration: BoxDecoration(
                          color: findcolor(i),
                          borderRadius: BorderRadius.circular(15),
                        ),
                          child:SvgPicture.asset('images/filtericon.svg',),)),
                )
                // suffixIcon: Padding(
                //   padding: const EdgeInsets.all(5.0),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Colors.black,
                //       borderRadius: BorderRadius.circular(15)
                //     ),
                //     child: IconButton(onPressed: ()=>{},
                //       icon: SvgPicture.asset('assets/images/filtericon.svg'),
                //
                //
                //     ),
                //   ),
                // )
              ),
            ),
          )
        ],
      ),
    );
  }
}
