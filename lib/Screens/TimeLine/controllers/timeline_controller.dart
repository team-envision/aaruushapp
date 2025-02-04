import 'package:AARUUSH_CONNECT/Screens/TimeLine/state/Timeline_State.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:get/get.dart';

class TimelineController extends GetxController {
  final TimelineState state;

  TimelineController({required this.state});
  @override
  void onInit() {
    super.onInit();
    state.flipCardController = FlipCardController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    state.swiperController.dispose();
  }
}
