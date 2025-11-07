import 'dart:io';
import 'package:flutter/material.dart';
import 'package:socialfeedplus_mohammedshahir/features/feed/models/post_model.dart';


Widget postImage(PostModel post) {
  if (post.imageUrl.startsWith('/')) {
    // 📂 Local image
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: Image.file(
        File(post.imageUrl),
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  } else {
    // 🌐 Network image
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: Image.network(
        post.imageUrl,
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, _, __) => Container(
          height: 250,
          color: Colors.grey[300],
          child: const Center(child: Icon(Icons.broken_image)),
        ),
      ),
    );
  }
}
