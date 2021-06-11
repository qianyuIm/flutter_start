import 'package:flutter/material.dart';
import 'package:flutter_start/generated/l10n.dart';
import 'package:flutter_start/model/effect_model.dart';
import 'package:flutter_start/ui/widget/effect_widget_list_item.dart';
import 'package:flutter_start/ui/widget/feedback_widget.dart';

class EffectPage extends StatefulWidget {
  @override
  _EffectPageState createState() => _EffectPageState();
}

class _EffectPageState extends State<EffectPage> {
  late List<EffectItemModel> items;
  @override
  void initState() {
    items = EffectItemSupport.effectItems;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).specialEffects),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return FeedbackWidget(
            a: 0.95,
            duration: const Duration(milliseconds: 200),
            onEnd: () => _toDetailPage(items[index]),
            child: EffectWidgetListItem(data: items[index],hasBottomHole: false,),
          );
        },
      ),
    );
  }
  _toDetailPage(EffectItemModel model) {
    Navigator.of(context).pushNamed(model.routerName);
  }
}