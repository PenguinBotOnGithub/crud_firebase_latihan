import 'package:crud_firebase/controllers/todo_controller.dart';
import 'package:get/get.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TodoController());
  }
}
