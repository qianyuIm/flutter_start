import 'package:flutter/material.dart';
import 'package:flutter_start/config/constant.dart';
import 'package:flutter_start/generated/l10n.dart';
import 'package:flutter_start/theme/locale_model.dart';
import 'package:provider/provider.dart';

class LanguageSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).languageSetting),
      ),
      body: _buildLanguageCell(context),
    );
  }

  Widget _buildLanguageCell(BuildContext context) {
    var iconColor = Theme.of(context).primaryColor;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          ExpansionTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).languageExpansionTile),
                Text(
                  LocaleModel.localeName(
                      Provider.of<LocaleModel>(context).localeIndex, context),
                ),
              ],
            ),
            leading: Icon(
              Icons.public,
              color: iconColor,
            ),
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: ConstantUtil.localeSupport.length,
                itemBuilder: (context, index) {
                  var locale = Provider.of<LocaleModel>(context);
                  return RadioListTile<int>(
                    value: index,
                    onChanged: (value) {
                      locale.switchLocale(value);
                    },
                    groupValue: locale.localeIndex,
                    title: Text(LocaleModel.localeName(index, context)),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
