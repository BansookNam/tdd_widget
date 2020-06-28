import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';
import 'dart:math' as math;

class PagenationWidgetComplete extends StatefulWidget {
  final int currentPage;
  final int totalItemCount;
  final int pageNumberMaxInARow;
  final Function(int) onTapPage;
  PagenationWidgetComplete({Key key, this.currentPage, this.totalItemCount, this.onTapPage, this.pageNumberMaxInARow = 5}) : super(key: key);

  @override
  PagenationWidgetCompleteState createState() => PagenationWidgetCompleteState();
}

class PagenationWidgetCompleteState extends State<PagenationWidgetComplete> {
  int pageIndex = 0;
  List<num> pageList = [];
  final Key keyRightArrow = Key("right_arrow");
  final Key keyLeftArrow = Key("left_arrow");

  int get pageNumberMaxInARow => widget.pageNumberMaxInARow;
  int get totalPageCount => widget.totalItemCount ~/ pageNumberMaxInARow + (widget.totalItemCount % pageNumberMaxInARow == 0 ? 0 : 1);
  int get showingFirstIndex => pageIndex * pageNumberMaxInARow + 1;
  int get showingLastIndex => (pageIndex + 1) * pageNumberMaxInARow;

  @override
  Widget build(BuildContext context) {
    print(totalPageCount);
    print(pageIndex);
    pageList = getPageNumbers();
    return Container(
      child: Row(
        children: <Widget>[
          showLeftArrow()
              ? InkWell(
                  key: keyLeftArrow,
                  onTap: () {
                    setState(() {
                      pageIndex--;
                    });
                  },
                  child: Container(width: 40, height: 40, child: SvgPicture.asset("assets/images/small_arrow_black_left.svg")),
                )
              : SizedBox(
                  width: 40,
                  height: 40,
                ),
          ...pageList
              .map((pageNum) => InkWell(
                    onTap: () {
                      widget.onTapPage(pageNum);
                    },
                    child: Container(
                        width: 40,
                        height: 40,
                        child: Center(
                            child: Text(
                          pageNum.toString(),
                          style: TextStyle(color: pageNum == widget.currentPage ? Colors.blue : Colors.black, fontWeight: pageNum == widget.currentPage ? FontWeight.bold : FontWeight.normal),
                        ))),
                  ))
              .toList(),
          showRightArrow()
              ? InkWell(
                  key: keyRightArrow,
                  onTap: () {
                    setState(() {
                      pageIndex++;
                    });
                  },
                  child: Container(width: 40, height: 40, child: SvgPicture.asset("assets/images/small_arrow_black_right.svg")),
                )
              : SizedBox(
                  width: 40,
                  height: 40,
                ),
        ],
      ),
    );
  }

  List<num> getPageNumbers() {
    if (totalPageCount < pageNumberMaxInARow + 1) {
      return range(1, totalPageCount + 1).toList();
    } else {
      final firstPageNum = pageIndex * pageNumberMaxInARow + 1;
      final lastPageNum = (pageIndex + 1) * pageNumberMaxInARow;
      if (totalPageCount < lastPageNum) {
        final numberLeftCount = totalPageCount % pageNumberMaxInARow;
        return range(firstPageNum, firstPageNum + numberLeftCount).toList();
      }

      return range(firstPageNum, lastPageNum + 1).toList();
    }
  }

  bool showLeftArrow() {
    if (widget.totalItemCount < pageNumberMaxInARow + 1) {
      return false;
    }
    return pageIndex != 0;
  }

  bool showRightArrow() {
    if (pageList.length < pageNumberMaxInARow || showingLastIndex == totalPageCount) {
      return false;
    }
    return pageIndex != totalPageCount;
  }
}
