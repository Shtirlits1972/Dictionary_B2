import 'package:dictionary_b2_v1/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class InitCrud {
  static init() async {
    String topicTab =
        'CREATE TABLE [Topic]( [id] INTEGER PRIMARY KEY AUTOINCREMENT, [NameTopic] NVARCHAR );  ';

    String topic1 =
        'INSERT INTO [Topic] ([NameTopic]) VALUES ("Art of communications ")   ;';
    String topic2 =
        'INSERT INTO [Topic] ([NameTopic]) VALUES ("A little bird told me ")   ;';
    String topic3 =
        'INSERT INTO [Topic] ([NameTopic]) VALUES ("Never have I ever ")   ;';

    getDatabasesPath().then((String strPath) {
      String path = join(strPath, dbName);
      try {
        final database = openDatabase(path, onCreate: (db, version) async {
          await db.execute(topicTab);

          await db.execute(topic1);
          await db.execute(topic2);
          await db.execute(topic3);

          print('DB created');
        }, version: 1);
      } catch (e) {
        print(e);
      }
    });
  }
}
