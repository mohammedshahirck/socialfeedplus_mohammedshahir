import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:socialfeedplus_mohammedshahir/core/theme/app_colors.dart';
import 'package:socialfeedplus_mohammedshahir/features/feed/models/post_model.dart';
import 'package:socialfeedplus_mohammedshahir/features/post_detail_page/models/comment_model.dart';


class FeedController extends GetxController {
  late Box<PostModel> postBox;

  // All posts from Hive
  RxList<PostModel> allPosts = <PostModel>[].obs;

  // Posts currently visible on screen
  RxList<PostModel> visiblePosts = <PostModel>[].obs;

  // UI States
  RxBool isDarkMode = false.obs;
  RxBool isLoadingMore = false.obs;
  RxBool hasMore = true.obs;
  Rx<PostModel?> selectedPost = Rx<PostModel?>(null);

  // Pagination
  final int pageSize = 10;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    postBox = Hive.box<PostModel>('posts');
    _loadAllPosts();
    _setupScrollListener();
  }

  //  Initial load of all posts from Hive
  void _loadAllPosts() {
    final loaded = postBox.values.toList();
    loaded.sort((a, b) => b.timestamp.compareTo(a.timestamp)); // newest first
    allPosts.assignAll(loaded);

    // Set initial 10 posts
    if (allPosts.length <= pageSize) {
      visiblePosts.assignAll(allPosts);
      hasMore.value = false;
    } else {
      visiblePosts.assignAll(allPosts.take(pageSize));
      hasMore.value = true;
    }
  }

  //  Scroll listener for auto-pagination
  void _setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !isLoadingMore.value &&
          hasMore.value) {
        loadMore();
      }
    });
  }

  //  Load more posts when scrolling
  Future<void> loadMore() async {
    if (isLoadingMore.value) return;
    isLoadingMore.value = true;

    await Future.delayed(const Duration(milliseconds: 300)); // Smooth UX delay

    final start = visiblePosts.length;
    final end = (start + pageSize > allPosts.length)
        ? allPosts.length
        : start + pageSize;

    final newItems = allPosts.sublist(start, end);
    visiblePosts.addAll(newItems);

    if (end >= allPosts.length) hasMore.value = false;
    isLoadingMore.value = false;
  }

  //  Add a new post
  Future<void> addPost(PostModel post) async {
    await postBox.add(post);
    allPosts.insert(0, post);
    visiblePosts.insert(0, post);
  }

  //  Like toggle
  void toggleLike(PostModel post) {
    final index = visiblePosts.indexWhere((p) => p.key == post.key);
    if (index == -1) return;

    post.isLiked = !post.isLiked;
    post.isLiked ? post.likeCount++ : post.likeCount--;
    post.save();
    visiblePosts[index] = post;
  }

  //  Add comment to post
  Future<void> addComment(PostModel post, CommentModel comment) async {
    // mutate existing object
    post.comments = List<CommentModel>.from(post.comments)..add(comment);
    await post.save();

    // update feed list
    final index = allPosts.indexWhere((p) => p.key == post.key);
    if (index != -1) allPosts[index] = post;

    // notify detail screen observers
    if (selectedPost.value?.key == post.key) selectedPost.refresh();

    Get.snackbar(
      'Comment Added',
      'Your comment has been saved locally.',
      backgroundColor: Colors.grey.shade200,
      colorText: AppColors.textLight,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  //  Utility to show time difference
  String timeAgo(DateTime timestamp) {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  void setSelectedPost(PostModel post) {
    selectedPost.value = post;
  }

  //  Clear all posts
  void clearAllPosts() {
    postBox.clear();
    allPosts.clear();
    visiblePosts.clear();
    hasMore.value = false;
  }

  //  Refresh entire feed
  void refreshFeed() {
    hasMore.value = true;
    visiblePosts.clear();
    _loadAllPosts();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
