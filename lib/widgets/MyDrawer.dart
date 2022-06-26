import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/common/GmLocalizations.dart';
import 'package:untitled/common/global.dart';
import 'package:untitled/widgets/GmAvatar.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);
  _buildHeader() {
    return Consumer<UserModel>(builder: (context, value, Widget? child) {
      return GestureDetector(
        child: Container(
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.only(top: 40, bottom: 20),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ClipOval(
                    child: value.isLogin
                        ? gmAvatar(value.user!.avatar_url, width: 80)
                        : const Icon(Icons.image)),
              ),
              Text(
                value.isLogin
                    ? value.user!.login
                    : GmLocalizations.of(context)!.login,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              )
            ],
          ),
        ),
        onTap: () {
          if (!value.isLogin) Navigator.of(context).pushNamed("login");
        },
      );
    });
  }

  _buildMenus() {
    return Consumer<UserModel>(
      builder: (context, userModel, child) {
        var gm = GmLocalizations.of(context)!;
        return ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: Text(gm.theme),
              onTap: () {
                Navigator.pushNamed(context, 'theme');
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(gm.language),
              onTap: () {
                Navigator.pushNamed(context, 'language');
              },
            ),
            if (userModel.isLogin)
              ListTile(
                leading: const Icon(Icons.power_settings_new),
                title: Text(gm.logout),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          content: Text(gm.logoutTip),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(gm.cancel)),
                            TextButton(
                                onPressed: () {
                                  userModel.user = null;
                                  Navigator.pop(context);
                                },
                                child: Text(gm.yes))
                          ],
                        );
                      });
                },
              )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Expanded(child: _buildMenus())
          ],
        ),
      ),
    );
  }
}
