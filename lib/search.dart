import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'components/searchWidget.dart';
import 'components/HorizontalScrollCards.dart';
import 'components/BottomItemsList.dart';


class SearchScreen extends StatefulWidget {
   SearchScreen({Key? key}) : super(key: key);
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
final GlobalKey<ScaffoldState> _key = GlobalKey();
class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
            key: _key,
        backgroundColor: const Color(0xFF242329) ,
        body: Stack(
          children: <Widget>[
            SvgPicture.asset('assets/images/BGLightseffect1.svg'),
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children:      <Widget>[
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                 children:  const <Widget>[
                   Padding(
                     padding: EdgeInsets.only(top: 30),
                     child: Text('AARUUSH',style: TextStyle(
                      fontFamily: 'Xirod',
                       fontSize: 24,
                       color: Colors.white
            ),
            ),
                   ),
                 ],
               ),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                   child: Row(
                     children: <Widget>[
                       IconButton(onPressed: (){
                         _key.currentState!.openDrawer();
                       },
                         iconSize: 24 ,icon: SvgPicture.asset('assets/images/Menu.svg') ,color: Colors.white,),
                       const Spacer(),
                       IconButton(onPressed: ()=>{},iconSize: 24 ,icon: const Icon(Icons.notifications_none_outlined),color: Colors.white,)
                     ],
                   ),
                 ),
                 const searchWidget(),
                 const Padding(
                   padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                   child: Text('Categories',
                     textAlign: TextAlign.left ,
                     style: TextStyle(
                     color: Colors.white,
                       fontSize: 36,

                   ),),
                 ),
                 const SizedBox(
                     height: 90,
                     child: horizontalScrollCards()),
                 const SizedBox(
                   height: 10,
                 ),
                 const Spacer(),
                 //  const Expanded(child: Padding(
                 //   padding: EdgeInsets.symmetric(horizontal: 5),
                 // //  child: BottomItemsList(),
                 // )),
                 Padding(
                   padding: const EdgeInsets.only(bottom: 20),
                   child: SizedBox(
                     height: 80,
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Container(
                           height: 52,
                           width: 52,
                           decoration: const BoxDecoration(
                             shape: BoxShape.circle,
                             color: Color(0xFF6B450C)
                           ),
                         )
                       ],
                     ),

                   ),
                 )
               ]
             )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children:  const <Widget>[
              DrawerHeader(child: Text('AARUUSH APP')
              ),
              ListTile(
                title: Text("ITEM1"),
              ),
              ListTile(
                title:  Text("ITEM2"),
              )
            ],
          ),
        ),
      )
      ),
    );
  }
}