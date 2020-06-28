import 'package:quiver/iterables.dart';
import 'dart:math' as math;

import 'dart:async';

Future sleep(int milliSec) {
  return Future.delayed(Duration(milliseconds: milliSec), () => {});
}

class MockRepository {
  static const int itemCount = 26;
  List<num> numList = range(1, itemCount + 1).toList();

  Future<MockResponse> getNumbers(int page, int limit) async {
    final int firstIndex = (page - 1) * limit;
    final int lastIndex = page * limit;
    await sleep(300);
    return MockResponse(numList.length, numList.sublist(firstIndex, math.min(lastIndex, numList.length)));
  }
}

class MockResponse {
  final int totalCount;
  final List<num> numList;

  MockResponse(this.totalCount, this.numList);
}
