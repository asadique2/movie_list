import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../model/model.dart';
import '../../storage/app_storage.dart';
import '../views/create_movies.dart';
import '../views/home_view.dart';

class HomeController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController releaseYearController = TextEditingController();
  TextEditingController directorController = TextEditingController();

  final createFormKey = GlobalKey<FormState>();

  final RxList<MovieModel> movieList = RxList([]);
  final RxBool isUpdating = RxBool(false);

  final imageFile = XFile('').obs;

  final RxString selectedImgName = RxString('Upload Image');
  final RxString selectedImgPath = RxString('');

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() async {
    var allMovieData = await AppStorage.getAllMovies();
    log('itemsData : $allMovieData');
    for (var item in allMovieData) {
      movieList.add(MovieModel.fromJson(item));
    }
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      imageFile(image);
      selectedImgName.value = image.name;
      selectedImgPath.value = imageFile.value.path;
    } on PlatformException catch (e) {
      Get.rawSnackbar(message: 'Failed to pick image');
      print('Failed to pick image: $e');
    }
  }

  Future pickImageWithCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      imageFile(image);
      selectedImgName.value = image.name;
      selectedImgPath.value = imageFile.value.path;
    } on PlatformException catch (e) {
      Get.rawSnackbar(message: 'Failed to pick image');
      print('Failed to pick image: $e');
    }
  }

  void createMovie() async {
    if (createFormKey.currentState!.validate()) {
      if (imageFile.value.path.isNotEmpty && selectedImgPath.value != '') {
        var newItem = MovieModel(
            id: Uuid().v4(),
            title: titleController.text,
            director: directorController.text,
            image: selectedImgPath.value,
            releaseYear: releaseYearController.text);
        log(newItem.toJson().toString());
        movieList.add(newItem);
        try {
          await AppStorage.setAllMovies(movieList);
        } catch (e) {
          log('$e');
        }
        clearForm();
        Get.back();
      } else {
        Fluttertoast.showToast(msg: 'please add image');
      }
    }
  }

  deleteMovie({required int idx}) async {
    movieList.removeAt(idx);
    movieList.refresh();
    try {
      await AppStorage.setAllMovies(movieList);
    } catch (e) {
      log('$e');
    }
    loadData();
  }

  updateMovies(MovieModel data) async {
    if (selectedImgPath.value.isNotEmpty) {
      MovieModel movieToUpdate = movieList.firstWhere((e) => e.id == data.id);
      movieToUpdate.id = Uuid().v4();
      movieToUpdate.title = titleController.text;
      movieToUpdate.director = directorController.text;
      movieToUpdate.image = selectedImgPath.value;
      movieToUpdate.releaseYear = releaseYearController.text;
      try {
        await AppStorage.setAllMovies(movieList);
        isUpdating.value = false;
        clearForm();
        Get.offAll(() => const HomeView());
      } catch (e) {
        log('$e');
      }
    } else {
      Fluttertoast.showToast(msg: 'Add Image');
    }
  }

  onEditMovies({required MovieModel data}) {
    titleController.text = data.title ?? '_';
    releaseYearController.text = data.releaseYear ?? '_';
    directorController.text = data.director ?? '_';
    selectedImgName.value = data.image?.split('/').last ?? '_';
    selectedImgPath.value = data.image ?? '_';
    isUpdating.value = true;
    Get.to(() => CreateMovie(
          data: data,
        ));
  }

  void clearForm() {
    releaseYearController.clear();
    titleController.clear();
    directorController.clear();
    imageFile(XFile(''));
    selectedImgName.value = "Upload Image";
    selectedImgPath.value = '';
  }
}
