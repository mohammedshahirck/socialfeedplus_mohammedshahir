import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialfeedplus_mohammedshahir/features/feed/controllers/feed_controller.dart';
import 'package:socialfeedplus_mohammedshahir/features/feed/widgets/post_card.dart';
import 'package:socialfeedplus_mohammedshahir/features/post_detail_page/models/comment_model.dart';
import 'package:socialfeedplus_mohammedshahir/shared/widgets/custom_appbar.dart';


class PostDetailScreen extends GetView<FeedController> {
  const PostDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController commentController = TextEditingController();

    return Scaffold(
      appBar: CustomAppBar(title: 'Post Details', showBackButton: true),
      body: Obx(() {
        final post = controller.selectedPost.value;

        if (post == null) {
          return const Center(child: Text('Post not found'));
        }
        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  postCard(context, controller, post),
                  const Divider(),
                  Row(
                    children: [
                      Text(
                        'Comments',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ...post.comments.map(
                    (c) => ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: Text(c.content),
                      subtitle: Text(
                        '@${c.userName} • ${controller.timeAgo(c.timestamp)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: commentController,
                      decoration: const InputDecoration(
                        hintText: 'Write a comment...',
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      if (commentController.text.trim().isNotEmpty) {
                        controller.addComment(
                          post,
                          CommentModel(
                            userName: post.userName,
                            content: commentController.text.trim(),
                            timestamp: DateTime.now(),
                          ),
                        );
                        commentController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
