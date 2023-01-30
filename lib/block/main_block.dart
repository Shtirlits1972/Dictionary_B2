import 'package:dictionary_b2_v1/model/topic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KeeperDictionary {
  List<Topic> topic_List = [];
}

class DataCubitDictionary extends Cubit<KeeperDictionary> {
  List<Topic> get getTopics => state.topic_List;

  setTopics(List<Topic> new_topic_List) {
    state.topic_List = new_topic_List;
  }

  addTopic(Topic topic) {
    state.topic_List.add(topic);
  }

  delTopic(int id) {
    for (int i = 0; i < state.topic_List.length; i++) {
      if (state.topic_List[i].id == id) {
        state.topic_List.removeAt(i);
        break;
      }
    }
  }

  DataCubitDictionary(super.initialState);
}
