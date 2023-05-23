import 'package:flutter/material.dart';
import 'package:owanto_app/src/const/app_font.dart';

class HeaderBody extends StatelessWidget {
  final String title;
  final String description;

  const HeaderBody({Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Icon(Icons.arrow_back_ios),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const SizedBox(height: 20),
              Text(
                title,
                style: AppFont.bold.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                description,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: AppFont.regular.copyWith(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
