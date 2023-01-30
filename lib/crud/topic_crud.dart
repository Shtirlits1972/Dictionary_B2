import 'package:dictionary_b2_v1/model/topic.dart';
import 'package:path/path.dart';
import 'package:dictionary_b2_v1/constants.dart';
import 'package:sqflite/sqflite.dart';

class TopicCrud {
  static Future<Topic> add(Topic model) async {
    String command = 'INSERT INTO Topic ( [NameTopic] ) values(?); ';

    String strPath = await getDatabasesPath();
    String path = join(strPath, dbName);
    Database db = await openDatabase(path, version: 1);

    model = await db.transaction<Topic>((txn) async {
      int id = await txn.rawInsert(command, [model.NameTopic]);
      model = Topic(id, model.NameTopic);
      return model;
    });
    return model;
  }

  static Future del(int id) async {
    String command = 'DELETE FROM Topic WHERE id = ?';
    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);
      Database db = await openDatabase(path, version: 1);

      int count = await db.rawDelete(command, [id]);

      print('row delete = $count ');
    } catch (e) {
      print(e);
    }
  }

  static Future upd(Topic model) async {
    String command = 'UPDATE Topic SET NameTopic = ? WHERE id = ?';
    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);
      Database db = await openDatabase(path, version: 1);

      int count = await db.rawUpdate(command, [model.NameTopic, model.id]);

      print('row updated = $count ');
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Topic>> getAll() async {
    List<Topic> listTopic = [];

    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);

      Database db = await openDatabase(path, version: 1);

      List<Map> list = await db.rawQuery('SELECT id, NameTopic FROM Topic ;');

      for (int i = 0; i < list.length; i++) {
        int id = list[i]['id'];
        String NameTopic = list[i]['NameTopic'];

        Topic pr = Topic(id, NameTopic);
        listTopic.add(pr);
      }
    } catch (e) {
      print(e);
    }
    return listTopic;
  }
}
