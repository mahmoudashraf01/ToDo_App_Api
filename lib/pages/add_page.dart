import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:to_do_api/methods/navigation.dart';
import 'package:to_do_api/pages/todo_list.dart';
import 'package:to_do_api/themes/colors.dart';
import 'package:to_do_api/themes/text.dart';
import 'package:to_do_api/utils/show_snack_bar.dart';
import 'package:to_do_api/widgets/custom_icon.dart';
import 'package:http/http.dart' as http;

class AddToDo extends StatefulWidget {
  const AddToDo({super.key, this.todo});
  final Map? todo;

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdited = false;

  @override
  void initState() {
    super.initState();
    final totdo = widget.todo;
    if (totdo != null) {
      isEdited = true;
      final title = totdo['title'];
      final description = totdo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomIcon(
          icon: Icons.arrow_back,
          color: white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          isEdited ? "Edit To Do" : "Add To Do",
          style: h5Bold,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            style: title1Bold,
            controller: titleController,
            decoration: InputDecoration(
              hintText: "Title",
              hintStyle: title1Bold.merge(
                const TextStyle(color: grey2),
              ),
            ),
          ),
          TextField(
            style: title1Bold,
            controller: descriptionController,
            decoration: InputDecoration(
              hintText: "Description",
              hintStyle: title1Bold.merge(
                const TextStyle(color: grey2),
              ),
            ),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(purple),
            ),
            onPressed: isEdited ? updateDate : submitData,
            child: Text(
              isEdited ? "Update" : "Submit",
              style: h5Bold,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> submitData() async {
    //get the data from form
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    //submit data to server
    const url = "https://api.nstack.in/v1/todos";
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    //show succes data
    response.statusCode == 201
        ? {
            ShowMessage.showSuccessMessage(context,
                message: "Creation Success"),
            titleController.text = '',
            descriptionController.text = '',
            goToWithNoBackButton(context: context, screen: const ToDoList()),
          }
        : ShowMessage.showFailedMessage(context, message: "Creation Failed");
  }

  Future<void> updateDate() async {
    //get the data from form
    final todo = widget.todo;
    final id = todo!['_id'];
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    //submit data to server
    final url = "https://api.nstack.in/v1/todos/$id";
    final uri = Uri.parse(url);
    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    //show succes data
    response.statusCode == 200
        ? {
            ShowMessage.showSuccessMessage(context, message: "Update Success"),
            titleController.text = '',
            descriptionController.text = '',
            goToWithNoBackButton(context: context, screen: const ToDoList()),
          }
        : ShowMessage.showFailedMessage(context, message: "Update Failed");
  }
}
