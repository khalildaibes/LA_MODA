import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:owanto_app/src/view/screen/widgets/ow_articles_titles_section.dart';
import 'package:owanto_app/src/view/screen/widgets/ow_collection_image_section.dart';
import 'package:owanto_app/src/view/screen/widgets/ow_header_title.dart';
import 'package:owanto_app/src/view/screen/widgets/ow_main_image_section.dart';
import 'package:owanto_app/src/view/screen/widgets/ow_popular_section.dart';
import 'package:owanto_app/src/view/screen/widgets/ow_tuniques_section.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shared_preferences/shared_preferences.dart';
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

  @override
  Widget build(BuildContext context) {
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
              const HeaderBody(
                  title: "קולקצית קיץ",
                  description: "גלו את ה קולקציה החדשה שלנו"),
              // CollectionImageSection(),
              new HomeHorizontalItemSection(category: "antica jeans"),
              const SizedBox(height: 10),
              // ArticlesTitlesSection(),
              const HeaderBody(
                  title: "הנמכרים ביותר",
                  description: "גלו את ה קולקציה החדשה שלנו"),
              new HomeHorizontalItemSection(category: "all time favorite"),
              const HeaderBody(
                  title: "הכי חדש", description: "גלו את ה קולקציה החדשה שלנו"),
              new HomeHorizontalItemSection(category: "brand new"),
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
