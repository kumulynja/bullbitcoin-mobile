import 'package:bb_mobile/_ui/components/text.dart';
import 'package:bb_mobile/_ui/label_field.dart';
import 'package:bb_mobile/settings/bloc/lighting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Testground extends StatefulWidget {
  const Testground();
  @override
  State<Testground> createState() => _TestgroundState();
}

class _TestgroundState extends State<Testground> {
  final List<String> _suggestions = <String>[
    'grocery',
    'travel',
    'services',
    'food',
    'income:business',
    'income:payouts',
    'income:rent',
    'income:claims',
    'income:capital_gains',
    'income:stock_returns',
    'income:mutual_funds',
    'income:real_estate',
    'income:bakery_shop',
  ];

  List<String> labels = <String>[];

  void _onChanged(List<String> list) {
    print(list);
  }

  @override
  Widget build(BuildContext context) {
    context.read<Lighting>().toggle(ThemeLighting.light);
    return Scaffold(
      appBar: AppBar(
        title: const BBText.title('Label field sample'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LabelField(
              key: const Key('labelFieldTest'),
              suggestions: _suggestions,
              labels: const ['grocery', 'travel'],
              onChanged: _onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
