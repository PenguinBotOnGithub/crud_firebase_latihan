import 'package:crud_firebase/controllers/todo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<TodoController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todos Gk Jelas"),
      ),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Todo",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: controller.addController,
                onSubmitted: controller.addTodo,
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.send),
                    hintText: "Todo",
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Todos",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Center(
                  child: Obx(() => controller.isLoading.value
                      ? CircularProgressIndicator()
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.todos.length,
                          itemBuilder: (context, count) {
                            return ListTile(
                              title: Text(controller.todos[count].title),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () =>
                                          controller.editTodo(count),
                                      icon: Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () => controller.deleteTodo(
                                          controller.todos[count].id),
                                      icon: Icon(Icons.delete))
                                ],
                              ),
                            );
                          })),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
