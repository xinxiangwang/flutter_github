import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/common/Git.dart';
import 'package:untitled/common/GmLocalizations.dart';
import 'package:untitled/common/global.dart';
import 'package:untitled/models/index.dart';
import 'package:untitled/widgets/RepoItem.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  static const loadingTag = '##loading##';
  final _items = <Repo>[Repo()..name = loadingTag];
  bool hasMore = true;
  int page = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GmLocalizations.of(context)!.home),
      ),
      body: _buildBody(),
    );
  }
  Widget _buildBody() {
    UserModel userModel = Provider.of<UserModel>(context);
    if (!userModel.isLogin) {
      return Center(
        child: ElevatedButton(
          child: Text(GmLocalizations.of(context)!.login),
          onPressed: () => Navigator.of(context).pushNamed('login'),
        ),
      );
    } else {
      return ListView.separated(itemBuilder: (context, index) {
        if (_items[index].name == loadingTag) {
          if (hasMore) {
            _retrieveData();
            return Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child: const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2,),
              ),
            );
          } else {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: const Text("没有更多了", style: TextStyle(color: Colors.grey),),
            );
          }
        }
        return RepoItem(_items[index]);
      }, separatorBuilder: (context, index) {
        return const Divider(height: .0,);
      }, itemCount: _items.length
      );
    }
  }
  void _retrieveData() async {
    var data = await Git(context).getRepos(
      queryParams: {
        'page': page,
        'page_size': 20
      }
    );
    hasMore = data.isNotEmpty && data.length % 20 == 0;
    setState(() {
      _items.insertAll(_items.length - 1, data);
      page++;
    });
  }
}


