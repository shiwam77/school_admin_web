import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_admin_web/Model/MasterNavigator.dart';

import '../../Color.dart';

class MasterPage extends StatefulWidget {
  @override
  _MasterPageState createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  NavTile navItems = NavTile();
  double maxWidth = 260;
  int currentSelectedIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xff263859),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CircleAvatar(
              radius: 45,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.school,
                size: 25,
                color: Color(0xffFF6768),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text('School Name',
                overflow: TextOverflow.visible,
                maxLines: 2,
                softWrap: true,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                )),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Divider(
              thickness: 1,
              height: 0,
              color: Color(0xff6B778D),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: navItems.navigationItems.length,
              itemBuilder: (context, index) => masterItem(index),
            ),
          )
        ],
      ),
    );
  }

  Widget masterItem(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          currentSelectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Container(
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: currentSelectedIndex == index
                ? Color(0xff17223B)
                : Color(0xff263859),
          ),
          alignment: Alignment.center,
          child: Text(
            navItems.navigationItems[index].title,
            style: TextStyle(color: AppColors.white, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
