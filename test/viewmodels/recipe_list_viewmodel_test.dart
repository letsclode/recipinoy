import 'package:flutter_test/flutter_test.dart';
import 'package:flavorsph/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('RecipeListViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
