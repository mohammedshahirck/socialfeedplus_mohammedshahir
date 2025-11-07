import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialfeedplus_mohammedshahir/features/create_post/controllers/post_controller.dart';
import 'package:socialfeedplus_mohammedshahir/features/create_post/widgets/image_picker_sheet.dart';
import 'package:socialfeedplus_mohammedshahir/shared/widgets/custom_appbar.dart';
import 'package:socialfeedplus_mohammedshahir/shared/widgets/custom_gradient_button.dart';
import 'package:socialfeedplus_mohammedshahir/shared/widgets/outline_border.dart';


class CreatePostScreen extends GetView<CreatePostController> {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Create Post", showBackButton: true),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image preview
              GestureDetector(
                onTap: () => showImagePickerSheet(context, controller),
                child: Obx(() {
                  final image = controller.selectedImage.value;
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: image == null
                        ? const Center(child: Text("Tap to add image"))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(image, fit: BoxFit.cover),
                          ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              // Caption
              TextField(
                controller: controller.captionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Write your caption...",
                  border: customOutlineBorder(),
                  disabledBorder: customOutlineBorder(),
                  focusedBorder: customOutlineBorder(),
                  enabledBorder: customOutlineBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // AI Caption Button
              Obx(
                () => CustomGradientButton(
                  text: controller.isGeneratingCaption.value
                      ? "Generating..."
                      : "✨ Generate AI Caption",
                  onPressed: controller.isGeneratingCaption.value
                      ? null
                      : controller.generateAICaption,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: CustomGradientButton(text: "Post", onPressed: controller.post),
      ),
    );
  }
}
