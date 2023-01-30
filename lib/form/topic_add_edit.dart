import 'package:dictionary_b2_v1/constants.dart';
import 'package:dictionary_b2_v1/crud/topic_crud.dart';
import 'package:dictionary_b2_v1/model/topic.dart';
import 'package:flutter/material.dart';

class TopicAddEdit extends StatefulWidget {
  TopicAddEdit({Key? key, required this.topic}) : super(key: key);
  Topic topic;

  @override
  _TopicAddEditState createState() => _TopicAddEditState();
}

class _TopicAddEditState extends State<TopicAddEdit> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: '');
    nameController.text = widget.topic.NameTopic;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add New topic',
          style: txt30,
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Name topic',
                    style: txt20,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: nameController,
                    style: txt20,
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 120,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: TextButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty) {
                        widget.topic.NameTopic = nameController.text;

                        if (widget.topic.id > 0) {
                          TopicCrud.upd(widget.topic).then((value) {
                            Navigator.pop(context, widget.topic);
                          });
                        } else {
                          TopicCrud.add(widget.topic).then(
                            (value) {
                              print(value);
                              Navigator.pop(context, value);
                            },
                          );
                        }
                      } else {
                        print('Error: $nameController.text ');
                      }
                    },
                    child: Text(
                      'OK',
                      style: txt15,
                    ),
                  ),
                ),
                Container(
                  width: 120,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: TextButton(
                    onPressed: () {
                      print('Cancel');
                      Navigator.pop(context, null);
                    },
                    child: Text(
                      'Cancel',
                      style: txt15,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
