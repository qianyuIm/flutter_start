import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_start/generated/l10n.dart';
import 'package:flutter_start/router/router_manger.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverPadding(padding: EdgeInsets.only(top: 10),),
          UserAppBar(),

          /// 列表
          UserListWidget()
        ],
        
      ),
    );
  }
}

class UserAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions: [
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {},
        ),
      ],
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      expandedHeight: 200 + MediaQuery.of(context).padding.top,
      flexibleSpace: UserHeaderWidget(),
      stretch: true,
    );
    
  }
}

class UserHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      title: Text('说点什么好呢'),
      background: Container(
        color: Colors.red,
      ),
    );
  }
}

/// list
class UserListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).accentColor;
    return SliverPadding(
        padding: EdgeInsets.only(top: 30),
        sliver: ListTileTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          child: SliverList(
            delegate: SliverChildListDelegate(List.generate(30, (index) {
              return ListTile(
                title: Text(
                  S.of(context).dataManagement,
                  style: TextStyle(color: color),
                ),
                leading: Icon(
                  Icons.settings,
                  color: color,
                ),
                trailing: Icon(Icons.chevron_right, color: color),
              );
            }).toList()),
          ),
        ));
  }
}
