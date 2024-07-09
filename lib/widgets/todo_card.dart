import 'package:ToDo/themes/text.dart';
import 'package:flutter/material.dart';


class ToDoCard extends StatelessWidget {
  const ToDoCard({
    super.key,
    required this.index,
    required this.item,
    required this.navigationToEditPAge,
    required this.deleteById,
  });
  final int index;
  final Map item;
  final Function(Map) navigationToEditPAge;
  final Function(String) deleteById;

  @override
  Widget build(BuildContext context) {
    final id = item["_id"] as String; 
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text('${index + 1}'),
        ),
        title: Text(
          ("${item['title']}"),
          style: title1Bold,
        ),
        subtitle: Text(
          ("${item['description']}"),
        ),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == "Edit") {
              navigationToEditPAge(item);
            }
            if (value == "Delete") {
              deleteById(id);
            }
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: "Edit",
                child: Text(
                  "Edit",
                  style: title2Bold,
                ),
              ),
              PopupMenuItem(
                value: "Delete",
                child: Text(
                  "Delete",
                  style: title2Bold,
                ),
              )
            ];
          },
        ),
      ),
    );
  }
}
