import 'package:dictionary_b2_v1/block/main_block.dart';
import 'package:dictionary_b2_v1/constants.dart';
import 'package:dictionary_b2_v1/crud/topic_crud.dart';
import 'package:dictionary_b2_v1/model/topic.dart';
import 'package:dictionary_b2_v1/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopicView extends StatefulWidget {
  TopicView({Key? key, required this.selectedIndex}) : super(key: key);
  int selectedIndex;
  @override
  _TopicViewState createState() => _TopicViewState();
}

class _TopicViewState extends State<TopicView> {
  List<Topic> topics = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Topics'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              print('add new');
              try {
                Topic topic = Topic.empty();
                Navigator.pushNamed(context, '/TopicAddEdit', arguments: topic)
                    .then((value) {
                  if (value != null) {
                    int y = 0;
                    setState(() {
                      topics.add(value as Topic);
                    });
                  }
                });
              } catch (e) {
                print(e);
              }
            },
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'Add new product',
          )
        ],
      ),
      body: BlocBuilder<DataCubitDictionary, KeeperDictionary>(
          builder: (context, state) {
        return Center(
          child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            itemCount: topics.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: Dismissible(
                  key: Key(topics[index].id.toString()),

                  confirmDismiss: (direction) async {
                    showDialog<bool>(
                      barrierDismissible: true,
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Warning!'),
                        content: const Text('Do you want to delete?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                              setState(() {});
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    ).then((value) {
                      if (value! == true) {
                        TopicCrud.del(topics[index].id).then((value) {
                          topics.removeAt(index);
                          setState(() {});
                          print('dismiss');
                        });
                        return value;
                      }
                    });
                  },

                  child: InkWell(
                    onLongPress: () {
                      print('edit topic');
                      try {
                        Navigator.pushNamed(context, '/TopicAddEdit',
                                arguments: topics[index])
                            .then((value) {
                          Topic topicEdit = value as Topic;
                          if (topicEdit != null) {
                            for (int i = 0; i < topics.length; i++) {
                              if (topics[i].id == topicEdit.id) {
                                setState(() {
                                  topics[i] = topicEdit;
                                });
                                break;
                              }
                            }
                          }
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 119, 108, 223),
                        child: Text(
                          topics[index].id.toString(),
                          style: txt15,
                        ),
                      ),
                      title: Text(
                        topics[index].NameTopic,
                        style: txt20,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          //  Text(
          //   'Topic view',
          //   style: txt20,
          // ),
        );
      }),
      bottomNavigationBar:
          BottomBarGeneral(selectedIndex: widget.selectedIndex),
    );
  }

  @override
  void initState() {
    super.initState();
    TopicCrud.getAll().then((value) {
      setState(() {
        topics = value;
      });
    });
  }
}
