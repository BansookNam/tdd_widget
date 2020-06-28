import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiver/iterables.dart';
import 'package:tdd_widget/widget/w_pagenation_complete.dart';

extension WidgetTesterExt on WidgetTester {
  Future pumpWidgetWithMaterialApp(Widget widget) {
    return pumpWidget(MaterialApp(home: Material(child: widget)));
  }
}

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows you to build and interact
  // with widgets in the  test environment.

  initialStateTest();
  initialViewTest();
  interactionTest();
}

void initialViewTest() {
  group("Initial View Test", () {
    testWidgets('아이템이 25개일때 1부터 5까지 텍스트 버튼이 존재하는가', (WidgetTester tester) async {
      //Given + When
      await tester.pumpWidgetWithMaterialApp(PagenationWidgetComplete(
        totalItemCount: 25,
        currentPage: 1,
      ));

      // Then
      for (int i in range(5)) {
        final numberText = find.text('${i + 1}');
        expect(numberText, findsOneWidget);
      }
    });

    testWidgets('첫번째 페이지가 1일때 숫자 색깔이 파란색인가', (WidgetTester tester) async {
      //Given + When
      await tester.pumpWidgetWithMaterialApp(PagenationWidgetComplete(
        totalItemCount: 25,
        currentPage: 1,
      ));

      final finder = find.text('1');
      var text = finder.evaluate().single.widget as Text;
      expect(text.style.color, Colors.blue);
    });

    testWidgets('아이템이 21개일때 1부터 5까지 텍스트 버튼이 존재하는가', (WidgetTester tester) async {
      //Given + When
      await tester.pumpWidgetWithMaterialApp(PagenationWidgetComplete(
        totalItemCount: 21,
        currentPage: 1,
      ));

      // Then
      for (int i in range(5)) {
        final numberText = find.text('${i + 1}');
        expect(numberText, findsOneWidget);
      }
    });

    testWidgets('아이템이 20개일때 1부터 4까지 텍스트 버튼이 존재하는가', (WidgetTester tester) async {
      //Given + When
      await tester.pumpWidgetWithMaterialApp(PagenationWidgetComplete(
        totalItemCount: 20,
        currentPage: 1,
      ));

      // Then
      for (int i in range(4)) {
        final numberText = find.text('${i + 1}');
        expect(numberText, findsOneWidget);
      }
    });

    testWidgets('아이템이 5개일때 1텍스트 버튼만 존재하는가', (WidgetTester tester) async {
      //Given + When
      await tester.pumpWidgetWithMaterialApp(PagenationWidgetComplete(
        totalItemCount: 5,
        currentPage: 1,
      ));

      // Then
      for (int i in range(5)) {
        final numberText = find.text('${i + 1}');
        if (i == 0) {
          expect(numberText, findsOneWidget);
        } else {
          expect(numberText, findsNothing);
        }
      }
    });

    testWidgets('아이템이 20개일때 1부터 4까지 텍스트 버튼이 존재하는가', (WidgetTester tester) async {
      final pagenationWidget = PagenationWidgetComplete(
        totalItemCount: 20,
        currentPage: 1,
      );
      //Given + When
      await tester.pumpWidgetWithMaterialApp(pagenationWidget);

      // Then
      for (int i in range(4)) {
        final numberText = find.text('${i + 1}');
        expect(numberText, findsOneWidget);
      }
    });

    testWidgets('아이템이 26개일때 오른쪽 화살표가 보이는가', (WidgetTester tester) async {
      //Given + When
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: PagenationWidgetComplete(
            totalItemCount: 26,
            currentPage: 1,
          ),
        ),
      ));

      // Then
      final widget = find.byKey(Key("right_arrow"));
      expect(widget, findsOneWidget);
    });

    testWidgets('아이템이 25개일때 오른쪽 화살표가 안보이는가', (WidgetTester tester) async {
      //Given + When
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: PagenationWidgetComplete(
            totalItemCount: 25,
            currentPage: 1,
          ),
        ),
      ));
      // Then
      final widget = find.byKey(Key("right_arrow"));
      expect(widget, findsNothing);
    });
  });
}

void initialStateTest() {
  group("Initial State Test", () {
    testWidgets('아이템이 25개일때 State의 totalPageCount는 5이다.', (WidgetTester tester) async {
      //Given + When
      await tester.pumpWidgetWithMaterialApp(PagenationWidgetComplete(
        key: Key("pagenation"),
        totalItemCount: 25,
        currentPage: 1,
      ));

      final pageState = tester.state<PagenationWidgetCompleteState>(find.byKey(Key("pagenation")));

      // Then
      expect(pageState.totalPageCount, 5);
    });

    testWidgets('아이템이 21개일때 State의 totalPageCount는 5이다.', (WidgetTester tester) async {
      //Given + When
      await tester.pumpWidgetWithMaterialApp(PagenationWidgetComplete(
        key: Key("pagenation"),
        totalItemCount: 21,
        currentPage: 1,
      ));

      final pageState = tester.state<PagenationWidgetCompleteState>(find.byKey(Key("pagenation")));

      // Then
      expect(pageState.totalPageCount, 5);
    });

    testWidgets('아이템이 20개일때 State의 totalPageCount는 4이다.', (WidgetTester tester) async {
      //Given + When
      await tester.pumpWidgetWithMaterialApp(PagenationWidgetComplete(
        key: Key("pagenation"),
        totalItemCount: 20,
        currentPage: 1,
      ));

      final pageState = tester.state<PagenationWidgetCompleteState>(find.byKey(Key("pagenation")));

      // Then
      expect(pageState.totalPageCount, 4);
    });
  });
}

void interactionTest() {
  group("Interaction Test", () {
    testWidgets('아이템이 26개일때 오른쪽 화살표를 누르면 6이 보이고, 7은 안보이는가', (WidgetTester tester) async {
      // Build the widget.
      await tester.pumpWidget(MaterialApp(
          home: Material(
              child: PagenationWidgetComplete(
        totalItemCount: 26,
        currentPage: 1,
      ))));

      // Tap the add button.
      await tester.tap(find.byKey(Key("right_arrow")));

      // Rebuild the widget with the new item.
      await tester.pump();

      // Expect to find the item on screen.
      expect(find.text('6'), findsOneWidget);
      expect(find.text('7'), findsNothing);
    });
  });
}
