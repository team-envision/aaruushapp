import 'package:aarush/Screens/Auth/auth_controller.dart';
import 'package:aarush/Themes/themes.dart';
import 'package:aarush/Utilities/custom_sizebox.dart';
import 'package:aarush/components/bg_area.dart';
import 'package:aarush/components/primaryButton.dart';
import 'package:aarush/components/profile_text_field.dart';
import 'package:aarush/components/white_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../components/AuthTextFields.dart';
import 'login.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: BgArea(
          children: [
            sizeBox(45, 0),
            Text(
              "Hello, There",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 13),
              child: Text("Welcome Back", style: Get.theme.kTitleTextStyle),
            ),

            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: Container(
                    height:60,
                    decoration: BoxDecoration(
                  color: Color(0xffF45D08),
                    borderRadius: BorderRadius.circular(28),
                  ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TabBar(
                        dividerHeight: 0,
                        unselectedLabelColor: Colors.black,
                        labelColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        indicatorPadding: EdgeInsets.symmetric(horizontal: -48),
                        indicator: BoxDecoration(

                          color: Colors.white,
                            borderRadius: BorderRadius.circular(28),
                          ),
                        controller: tabController,
                        tabs: [
                          Tab(text: 'Login     ',
                          ),
                          Tab(text: 'Register'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height-295,
                  child: TabBarView(
                    controller: tabController,
                    children: [Login(),Container(color: Colors.pink,)],
                  ),
                )
              ],
            ),

            SvgPicture.asset(
              'assets/images/Aarushlogo.svg',
              height: 100,
              width: 200,
            ),
          ],
        ));
  }


}
