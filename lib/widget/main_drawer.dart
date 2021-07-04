import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands_buisness/constant.dart';
import 'package:helping_hands_buisness/screens/about_us.dart';
import 'package:helping_hands_buisness/screens/privacy_policy.dart';
import 'package:helping_hands_buisness/screens/worker_profile.dart';

class MainDrawer extends StatelessWidget {
  final void Function(BuildContext context) logoutFun;
  final BuildContext ctx;

  MainDrawer({this.logoutFun, this.ctx});

  Widget buildListTile(String text, IconData icon, Function onTap) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: kprimaryColor),
      title: Text(
        text,
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, left: 10),
            color: kprimaryColor,
            width: double.infinity,
            height: 150,
            child: SafeArea(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/logo1.png'),
                  ),
                  SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome to',
                        style: TextStyle(
                          fontSize: 20,
                          color: kaccentColor,
                        ),
                      ),
                      Text(
                        'Helping Hands',
                        style: TextStyle(
                          fontSize: 20,
                          color: kaccentColor,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          buildListTile(
            'Your Profile',
            Icons.account_circle,
            () {
              Navigator.of(context).pop();
              Navigator.pushNamed(
                  context, WorkerProfileScreen.workerProfileScreen);
            },
          ),
          SizedBox(height: 10),
          buildListTile(
            'Privacy Policy',
            Icons.privacy_tip,
            () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(PrivacyPolicy.privacyPolicy);
            },
          ),
          SizedBox(height: 10),
          buildListTile(
            'About Us',
            Icons.assignment,
            () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(AboutUs.aboutUs);
            },
          ),
          SizedBox(height: 10),
          buildListTile(
            'Logout',
            Icons.logout,
            () {
              Navigator.of(context).pop();
              logoutFun(ctx);
            },
          ),
        ],
      ),
    );
  }
}
