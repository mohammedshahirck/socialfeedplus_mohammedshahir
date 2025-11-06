// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostModelAdapter extends TypeAdapter<PostModel> {
  @override
  final int typeId = 0;

  @override
  PostModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostModel(
      userName: fields[0] as String,
      caption: fields[1] as String,
      imageUrl: fields[2] as String,
      timestamp: fields[3] as DateTime,
      isLiked: fields[4] as bool,
      likeCount: fields[5] as int,
      comments: (fields[6] as List).cast<CommentModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, PostModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.caption)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.timestamp)
      ..writeByte(4)
      ..write(obj.isLiked)
      ..writeByte(5)
      ..write(obj.likeCount)
      ..writeByte(6)
      ..write(obj.comments);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
