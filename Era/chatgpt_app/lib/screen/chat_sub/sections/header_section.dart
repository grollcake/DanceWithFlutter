import 'package:chatgpt_app/providers/providers.dart';
import 'package:flutter/material.dart';

import '../components/cost_view.dart';

class HeaderSection extends StatelessWidget {
  final String menuName;

  const HeaderSection({Key? key, required this.menuName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isShinny = menuName == 'Shinny';

    return Container(
      width: double.infinity,
      height: 53,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFDEE2E6),
            width: 2,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 16),
          if (deviceType == DeviceType.mobile) _buildMenuButton(context),
          Text(menuName, style: TextStyle(fontSize: 22, color: Colors.black87, fontWeight: FontWeight.bold)),
          SizedBox(width: 8),
          if (isShinny)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.pink.withOpacity(.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text('AI Bot', style: TextStyle(fontSize: 12, color: Colors.black)),
            ),
          Spacer(),
          isShinny ? CostView() : Image.asset('assets/icons/chattoolbars.png'),
          SizedBox(width: 16),
        ],
      ),
    );
  }

  _buildMenuButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
    );
  }
}
