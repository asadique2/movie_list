import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../model/model.dart';
import '../../widget/common_textinput.dart';
import '../controllers/home_controllers.dart';

class CreateMovie extends GetView<HomeController> {
  final MovieModel? data;
  const CreateMovie({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'images/logo.png',
          height: 41,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
            controller.isUpdating.value = false;
            controller.clearForm();
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.baseColor,
        height: 57,
        child: GestureDetector(
          onTap: () => controller.isUpdating.value
              ? controller.updateMovies(data ?? MovieModel())
              : controller.createMovie(),
          child: Center(
            child: controller.isUpdating.value
                ? const Text(
                    "Update",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.whiteColor,
                        letterSpacing: 2),
                  )
                : const Text(
                    "Create",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.whiteColor,
                        letterSpacing: 2),
                  ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.createFormKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
              CommonTextField(
                  validator: mandatoryValidator,
                  label: 'Title',
                  wrapper: controller.titleController),
              const SizedBox(height: 20),
              CommonTextField(
                  textInputType: TextInputType.datetime,
                  validator: mandatoryValidator,
                  label: 'Release year',
                  wrapper: controller.releaseYearController),
              const SizedBox(height: 20),
              CommonTextField(
                  validator: mandatoryValidator,
                  label: 'Director',
                  wrapper: controller.directorController),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  Get.defaultDialog(
                    title: 'Choose Image',
                    titlePadding: EdgeInsets.only(bottom: 30, top: 20),
                    content: pickPickerWidget(),
                  );
                },
                child: Container(
                  height: 150,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.baseColor),
                  ),
                  child: Center(
                    child: Obx(() => Text(controller.selectedImgName.value)),
                  ),
                ),
              )
            ],
          ).paddingSymmetric(horizontal: 24),
        ),
      ),
    );
  }

  String? mandatoryValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'required field';
    }
    return null;
  }

  Widget pickPickerWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            controller.pickImage();
            Get.back();
          },
          child: const Icon(
            Icons.photo,
            color: AppColors.baseColor,
            size: 46,
          ),
        ),
        const SizedBox(width: 40),
        InkWell(
          onTap: () {
            controller.pickImageWithCamera();
            Get.back();
          },
          child: const Icon(
            Icons.camera_alt_outlined,
            color: AppColors.baseColor,
            size: 46,
          ),
        ),
      ],
    );
  }
}
