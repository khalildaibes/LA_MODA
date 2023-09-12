import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:owanto_app/src/data/model/category.dart' as Category;
import 'package:owanto_app/src/view/screen/widgets/ow_articles_titles_section.dart';
import 'package:owanto_app/src/view/screen/widgets/ow_collection_image_section.dart';
import 'package:owanto_app/src/view/screen/widgets/ow_header_title.dart';
import 'package:owanto_app/src/view/screen/widgets/ow_main_image_section.dart';
import 'package:owanto_app/src/view/screen/widgets/ow_popular_section.dart';
import 'package:owanto_app/src/view/screen/widgets/ow_tuniques_section.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/service/category_service.dart';
import 'component/ow_search_bar/ow_search_bar.dart';
import 'widgets/ow_banner_photo_section_from_firebase.dart';
import 'widgets/ow_popular_section_from_firebase.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  Future<List<String>> fetchPhotosWithPrefix(String prefix) async {
    List<String> photoUrls = [];

    try {
      firebase_storage.ListResult result =
          await firebase_storage.FirebaseStorage.instance.ref().listAll();

      List<Reference> photos = [];
      for (var ref in result.items) {
        if (ref.name.startsWith('prefix')) {
          photos.add(ref);
        }
      }
      for (var item in photos) {
        String imageUrl = await item.getDownloadURL();
        photoUrls.add(imageUrl);
      }
    } catch (e) {
      print('Error fetching photos: $e');
    }

    return photoUrls;
  }

  Future<bool> last_log_in() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool lastlogin = prefs.containsKey('last_log_in');
    if (lastlogin) {
      var lastlogindate = prefs.get('last_log_in');
      DateTime now = DateTime.now();
      // DateFormat formatter = DateFormat('yyyy-MM-dd');
      // String formattedDate = formatter.format(now);
      // print(formattedDate);
      return true;
    } else {
      // Key does not exist in SharedPreferences
      return false;
    }
  }

  Future<List<Category.Category>> get_categories() async {
    CategoryService categoryService = CategoryService();
    return await categoryService.get_categories_from_db()
        as List<Category.Category>;
  }

  Widget build_category_products(categories) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: categories!.length,
      itemBuilder: (context, index) {
        return Column(children: [
          const HeaderBody(
              title: "קולקצית קיץ", description: "גלו את ה קולקציה החדשה שלנו"),
          // CollectionImageSection(),
          new HomeHorizontalItemSection(
              category: categories[index].name ?? "", favorit: false)
        ]);
      },
    );

    // return Text('Error: ${error}');
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Category.Category>> categories = get_categories();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //ALL WIDGETS ARE FOUND IN WIDGETS FOLDER
              const CustomSearchBar(),

              SvgPicture.asset(
                'assets/image/lamodalogo.svg',
                height: 150,
                width: 300,
                fit: BoxFit.cover,
              ),
              // MainImageSection(),
              new HomeBannerItemSection(photo_name: "main banner"),

              const SizedBox(height: 10),

              FutureBuilder<List<Category.Category>>(
                future: CategoryService().get_categories_from_db(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                        height: 50,
                        child: Center(child: CircularProgressIndicator()));
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    debugPrint(snapshot.data!.length.toString());
                    debugPrint(snapshot.data!.first.name.toString());

                    // var result = ListView.builder(
                    //   scrollDirection: Axis.vertical,
                    //   shrinkWrap: true,
                    //   itemCount: snapshot.data!.length,
                    //   itemBuilder: (context, index) {
                    //     const HeaderBody(
                    //         title: "קולקצית קיץ",
                    //         description: "גלו את ה קולקציה החדשה שלנו");
                    //     // CollectionImageSection(),
                    //     new HomeHorizontalItemSection(
                    //         category: snapshot.data![index].name ?? "",
                    //         favorit: false);
                    //   },
                    // );
                    // debugPrint(result.childrenDelegate.toString());
                    // return build_category_products(snapshot.data);
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(children: [
                          HeaderBody(
                              title: snapshot.data![index].name.toString(),
                              description:
                                  snapshot.data![index].slogan.toString()),
                          // CollectionImageSection(),
                          new HomeHorizontalItemSection(
                              category: snapshot.data![index].name ?? "",
                              favorit: false)
                        ]);
                      },
                    );
                  }
                },
              ),

              // const HeaderBody(
              //     title: "קולקצית קיץ",
              //     description: "גלו את ה קולקציה החדשה שלנו"),
              // // CollectionImageSection(),
              // new HomeHorizontalItemSection(
              //     category: "antica jeans", favorit: false),
              // const SizedBox(height: 10),
              // // ArticlesTitlesSection(),
              // const HeaderBody(
              //     title: "הנמכרים ביותר",
              //     description: "גלו את ה קולקציה החדשה שלנו"),
              // new HomeHorizontalItemSection(
              //     category: "all time favorite", favorit: false),
              // const HeaderBody(
              //     title: "הכי חדש", description: "גלו את ה קולקציה החדשה שלנו"),
              // new HomeHorizontalItemSection(
              //     category: "brand new", favorit: false),
              const SizedBox(height: 60),
              TuniqueSection(),
              const SizedBox(height: 200)
            ],
          ),
        ),
      ),
    );
  }
}
