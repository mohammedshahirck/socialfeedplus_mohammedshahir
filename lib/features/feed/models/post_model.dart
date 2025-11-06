import 'package:hive/hive.dart';
import 'package:socialfeedplus_mohammedshahir/features/create_post/models/comment_model.dart';



part 'post_model.g.dart'; // required for Hive codegen

@HiveType(typeId: 0)
class PostModel extends HiveObject {
  @HiveField(0)
  String userName;

  @HiveField(1)
  String caption;

  @HiveField(2)
  String imageUrl;

  @HiveField(3)
  DateTime timestamp;

  @HiveField(4)
  bool isLiked;

  @HiveField(5)
  int likeCount;

  @HiveField(6)
  List<CommentModel> comments;

  PostModel({
    required this.userName,
    required this.caption,
    required this.imageUrl,
    required this.timestamp,
    this.isLiked = false,
    this.likeCount = 0,
    List<CommentModel>? comments,
  }) : comments = comments ?? [];

  // Add this method:
  PostModel copyWith({
    String? userName,
    String? caption,
    String? imageUrl,
    DateTime? timestamp,
    bool? isLiked,
    int? likeCount,
    List<CommentModel>? comments,
  }) {
    return PostModel(
      userName: userName ?? this.userName,
      caption: caption ?? this.caption,
      imageUrl: imageUrl ?? this.imageUrl,
      timestamp: timestamp ?? this.timestamp,
      isLiked: isLiked ?? this.isLiked,
      likeCount: likeCount ?? this.likeCount,
      comments: comments ?? List<CommentModel>.from(this.comments),
    );
  
  }
}
