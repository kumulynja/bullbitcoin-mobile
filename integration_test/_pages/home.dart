import 'package:bb_mobile/_pkg/consts/keys.dart';
import 'package:flutter_test/flutter_test.dart';

class THomePage {
  Finder get mainnetCard => find.byKey(UIKeys.homeCardMainnet);
  Finder get testnetCard => find.byKey(UIKeys.homeCardTestnet);
}