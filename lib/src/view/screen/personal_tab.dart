import 'package:flutter/material.dart';
import 'package:owanto_app/src/const/app_font.dart';
import 'package:owanto_app/src/router/router_path.dart';
import 'package:owanto_app/src/viewmodel/cart_viewmodel.dart';
import 'package:owanto_app/src/viewmodel/product_viewmodel.dart';
import 'package:provider/provider.dart';

class PersonalTab extends StatefulWidget {
  @override
  _PersonalTabState createState() => _PersonalTabState();
}

class _PersonalTabState extends State<PersonalTab> {
  Map<String, String> listInfomation = {
    'ההזמנות שלי': 'יש לך cartViewModel הזמנות ',
    'כתובת משלוח': 'כתובת ראשית',
    'שיטות תשלום': 'Visa, Airtel Money ',
    'התראות': 'יש לך 0 התראות',
    'שפות': 'עברית',
  };

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context, listen: false);
    // final notificationViewModel = Provider.of<Notification>(context, listen: false);
    var productVM = Provider.of<ProductViewModel>(context, listen: false);
    for (var item in listInfomation.entries) {
      listInfomation[item.key] = item.value.replaceFirst(
          "cartViewModel", cartViewModel.listOrder.length.toString());
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "RT56BC",
                      style: AppFont.semiBold.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "מספר טלפון:",
                      textDirection: TextDirection.rtl,
                      style: AppFont.medium.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
              Container(
                width: 70,
                height: 30,
                child: Icon(Icons.person),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: listInfomation.length,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                var title = listInfomation.keys.elementAt(index);
                var subtitle = listInfomation.values.elementAt(index);
                return InkWell(
                  onTap: () {
                    switch (index) {
                      case 0:
                        Navigator.pushNamed(context, MyOrderScreens);
                        break;
                      case 1:
                        Navigator.pushNamed(context, ChoiceAddressScreens);
                        break;

                      case 3:
                        Navigator.pushNamed(context, RecentViewScreens,
                            arguments: productVM.listRecent);
                        break;
                    }
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0.0),
                    title: Text(
                      title,
                      textAlign: TextAlign.right,
                      style: AppFont.semiBold
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    subtitle: Text(
                      subtitle,
                      textAlign: TextAlign.right,
                      style: AppFont.regular.copyWith(
                          fontWeight: FontWeight.w100,
                          fontSize: 12,
                          color: Colors.grey),
                    ),
                    leading: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
