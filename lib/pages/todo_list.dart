import 'package:ToDo/methods/navigation.dart';
import 'package:ToDo/pages/add_page.dart';
import 'package:ToDo/services/todo_list_services.dart';
import 'package:ToDo/themes/colors.dart';
import 'package:ToDo/themes/text.dart';
import 'package:ToDo/utils/show_snack_bar.dart';
import 'package:ToDo/widgets/custom_icon.dart';
import 'package:ToDo/widgets/todo_card.dart';
import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List items = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: HomeButton(
          icon: Icons.home,
          color: white,
        ),
        backgroundColor: purple2,
        title: Text(
          "To Do List",
          style: h5Bold,
          textAlign: TextAlign.end,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          goTo(context: context, screen: const AddToDo());
        },
        label: Text(
          "Add To Do Form",
          style: title1Bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 90),
        child: Visibility(
          visible: isLoading,
          replacement: RefreshIndicator(
            onRefresh: fetchData,
            child: Visibility(
              visible: items.isNotEmpty,
              replacement: Center(
                child: Text(
                  "No Todo List",
                  style: h4Bold,
                ),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 5,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index] as Map;
                  return ToDoCard(
                    index: index,
                    item: item,
                    navigationToEditPAge: navigationToEditPAge,
                    deleteById: deleteById,
                  );
                },
              ),
            ),
          ),
          child: const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Future<void> deleteById(String id) async {
    final success = await ToDoSurvices.deleteById(id);
    if (success) {
      final filterdItems =
          items.where((element) => element['_id'] != id).toList();
      ShowMessage.showSuccessMessage(context,
          message: "Task Dleted Successfully");
      setState(() {
        items = filterdItems;
      });
    }
  }

  Future<void> fetchData() async {
    final response = await ToDoSurvices.fetchData();
    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      ShowMessage.showFailedMessage(context,
          message: "Something went wrong check the connection");
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> navigationToAddPAge(Map item) async {
    final route = MaterialPageRoute(builder: (context) => AddToDo(todo: item));
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchData();
  }

  Future<void> navigationToEditPAge(Map item) async {
    final route = MaterialPageRoute(builder: (context) => AddToDo(todo: item));
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchData();
  }
}
