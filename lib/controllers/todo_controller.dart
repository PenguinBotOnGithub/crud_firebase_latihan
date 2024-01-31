import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class TodoController extends GetxController {
  var addController = TextEditingController();
  var updateController = TextEditingController();

  final uuid = const Uuid();
  final db = FirebaseFirestore.instance;

  RxList<Todo> todos = <Todo>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getTodos();
  }

  Future<void> getTodos() async {
    isLoading.value = true;
    todos.clear();
    await db.collection("Todo").get().then((todoCollection) => {
          for (var todo in todoCollection.docs)
            {todos.add(Todo.fromJson(todo.data()))}
        });
    Future.delayed(Durations.long2);
    isLoading.value = false;
  }

  void addTodo(String content) async {
    if (content.isEmpty) {
      Get.rawSnackbar(title: "ERROR", message: "New Todos can not be empty");
      return;
    }

    String id = uuid.v4();
    Todo newTodo = Todo(id: id, title: content);
    await db.collection("Todo").doc(id).set(newTodo.toJson());
    addController.clear();
    getTodos();
  }

  void deleteTodo(String id) async {
    await db.collection("Todo").doc(id).delete();
    getTodos();
  }

  void editTodo(int index) async {
    Todo oldTodo = todos[index];
    Todo? newTodo;
    updateController.text = oldTodo.title;
    await Get.defaultDialog(
        title: "Edit Todo",
        content: TextField(
          controller: updateController,
        ),
        onConfirm: () {
          newTodo = Todo(id: oldTodo.id, title: updateController.text);
          Get.back();
        },
        textConfirm: "Update");
    updateController.clear();

    if (newTodo == null) {
      return;
    }

    if (newTodo != oldTodo) {
      await db.collection("Todo").doc(oldTodo.id).set(newTodo!.toJson());
    } else {
      Get.rawSnackbar(
          title: "ERROR",
          message: "Edited Todo can not be the same as the old one");
    }
    getTodos();
  }
}
