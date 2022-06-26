import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/common/GmLocalizations.dart';
import 'package:untitled/common/global.dart';

class LanguageRoute extends StatelessWidget {
  const LanguageRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor;
    var localeModel = Provider.of<LocaleModel>(context);
    var gm = GmLocalizations.of(context)!;
    _buildLanguageItem(lan, value) {
      return ListTile(
        title: Text(
          lan,
          style: TextStyle(color: localeModel.locale == value ? color : null),
        ),
        trailing: localeModel.locale == value ? Icon(Icons.done, color: color,) : null,
        onTap: () {
          localeModel.locale = value;
        },
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(gm.language),),
      body: ListView(
        children: [
          _buildLanguageItem("中文", "zh_CN"),
          _buildLanguageItem("English", "en_US"),
          _buildLanguageItem(gm.auto, null)
        ],
      ),
    );
  }
}
