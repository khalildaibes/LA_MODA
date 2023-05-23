import 'package:flutter/material.dart';
import 'package:owanto_app/src/const/app_font.dart';

class MainImageSection extends StatelessWidget {
  const MainImageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        height: 300,
        color: Color(0xffAD071D),
        margin: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "מבצעים חדשים לקיץ לוהט",
              style: AppFont.normal_white,
            ),
            const SizedBox(height: 30),
            Text(
              "%70 הנחה",
              style: AppFont.large_white,
            ),
            const SizedBox(height: 10),
            Text(
              "חולצות",
              style: AppFont.large_white,
            ),
            const SizedBox(height: 10),
            Text(
              "שורטים",
              style: AppFont.large_white,
            ),
            Spacer(),
            Text(
              "למה אתם מחכים תזמינו ותהנו מהמבצע המטורף",
              style: AppFont.normal_white,
            ),
          ],
        ),
      ),
    );
  }
}
