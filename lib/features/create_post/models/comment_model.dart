import 'package:hive/hive.dart';

part 'comment_model.g.dart';

@HiveType(typeId: 1)
class CommentModel extends HiveObject {
  @HiveField(0)
  String userName;

  @HiveField(1)
  String content;

  @HiveField(2)
  DateTime timestamp;

  CommentModel({
    required this.userName,
    required this.content,
    required this.timestamp,
  });
}
