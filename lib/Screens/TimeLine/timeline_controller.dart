import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:get/get.dart';

class TimelineController extends GetxController{
   FlipCardController flipCardController=FlipCardController();
  AppinioSwiperController swiperController = AppinioSwiperController();
  @override
  void onInit() {
    super.onInit();
    flipCardController =FlipCardController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    swiperController.dispose();
  }

}