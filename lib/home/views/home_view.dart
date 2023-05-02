import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_list/home/views/create_movies.dart';

import '../../constant/colors.dart';
import '../../model/model.dart';
import '../../widget/common_container.dart';
import '../../widget/movie_list_widget.dart';
import '../controllers/home_controllers.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.baseColor,
        onPressed: () {
          Get.to(() => const CreateMovie());
        },
        child: const Icon(CupertinoIcons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomAppBar(
        height: 50,
        color: AppColors.whiteColor,
        elevation: 6,
        shape: CircularNotchedRectangle(),
        notchMargin: 4,
      ),
      appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            'images/logo.png',
            height: 41,
          )),
      body: Obx(
        () => controller.movieList.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.movieList.length,
                      itemBuilder: (BuildContext context, int idx) =>
                          Dismissible(
                        key: ValueKey(controller.movieList[idx]),
                        onDismissed: (data) {
                          controller.deleteMovie(idx: idx);
                        },
                        child: MovieListWidget(
                          onEdit: () => controller.onEditMovies(
                              data: controller.movieList[idx]),
                          title: controller.movieList[idx].title ?? '',
                          image: controller.movieList[idx].image ??
                              'images/img3.jpeg',
                          releaseYear:
                              controller.movieList[idx].releaseYear ?? '_',
                          director: controller.movieList[idx].director ?? '_',
                        ).paddingSymmetric(horizontal: 20, vertical: 5),
                      ),
                    ),
                  )
                ],
              ).paddingSymmetric(vertical: 10)
            : const Center(
                child: Text('No Movies'),
              ),
      ),
    );
  }
}
