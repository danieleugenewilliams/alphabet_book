import 'dart:async';
import 'dart:ui';
import 'package:alphabet_book/pages.dart';
import 'package:flutter/material.dart';

class PagerIndicator extends StatelessWidget {
  // TODO: FIX THIS MESSY CLASS

  final PagerIndicatorViewModel viewModel;

  PagerIndicator({
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    List<PageBubble> bubbles = [];
    for (var i = 0; i < viewModel.pages.length; ++i) {
      final page = viewModel.pages[i];

      var percentActive;
      if (i == viewModel.activeIndex) {
        percentActive = 1.0 - viewModel.slidePercent;
      } else if (i == viewModel.activeIndex - 1 && viewModel.slideDirection == SlideDirection.leftToRight) {
        percentActive = viewModel.slidePercent;
      } else if (i == viewModel.activeIndex + 1 && viewModel.slideDirection == SlideDirection.rightToLeft) {
        percentActive = viewModel.slidePercent;
      } else {
        percentActive = 0.0;
      }

      bool isHollow = i > viewModel.activeIndex
          || (i == viewModel.activeIndex && viewModel.slideDirection == SlideDirection.leftToRight);


      bubbles.add(
        new PageBubble(
          viewModel: new PageBubbleViewModel(
            page.iconAssetPath,
            page.color,
            isHollow,
            percentActive,
          ),
        ),
      );
    }

    final BUBBLE_WIDTH = 55.0;
    final baseTranslation = ((viewModel.pages.length * BUBBLE_WIDTH) / 3.6) - (BUBBLE_WIDTH / 3.0);
    var translation = baseTranslation - (viewModel.activeIndex * BUBBLE_WIDTH);
    print("baseTranslation: $baseTranslation");
    print("activeIndex: ${viewModel.activeIndex}");

    print("slideDIrection: ${viewModel.slideDirection}");
    if (viewModel.slideDirection == SlideDirection.leftToRight) {
      translation += BUBBLE_WIDTH * viewModel.slidePercent;
    } else if (viewModel.slideDirection == SlideDirection.rightToLeft) {
      translation -= BUBBLE_WIDTH * viewModel.slidePercent;
    }

    print("slidePercent: ${viewModel.slidePercent}");
    print("translation: $translation");
    var futureBuilder = new FutureBuilder(
        future: _getBubbles(viewModel),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return new Text("Awaiting results...");
            default:
              if (snapshot.hasError) {
                //print("Error: ${snapshot.error}");
                return new Text("Error: ${snapshot.error}");
              } else {
                //print("Result: ${snapshot.data}");
                return createBubbleIndicatorListView(context, snapshot, translation.abs(), BUBBLE_WIDTH);
              }
          }

        }
    );
    return futureBuilder;
  }

  Widget createBubbleIndicatorListView(BuildContext context, AsyncSnapshot snapshot, var translation, var bubbleWidth) {
    List<PageBubble> bubbles = snapshot.data;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: bubbles.length,
      //mainAxisAlignment: MainAxisAlignment.center,
      itemBuilder: (BuildContext context, int index) {
        //print("translation * width: $translation * $bubbleWidth");
        //print("Result2: ${snapshot.data}");
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            Transform(
              transform: new Matrix4.translationValues(lerpDouble(10.0, 200.28, translation).abs(), 0.0, 0.0),
              child: Container(
                height: 80.0,
                width: translation,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: bubbles,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}


enum SlideDirection {
  leftToRight,
  rightToLeft,
  none,
}

class PagerIndicatorViewModel {
  final List<PageViewModel> pages;
  final int activeIndex;
  final SlideDirection slideDirection;
  final double slidePercent;

  PagerIndicatorViewModel(
      this.pages,
      this.activeIndex,
      this.slideDirection,
      this.slidePercent,
      );
}

class PageBubble extends StatelessWidget {

  final PageBubbleViewModel viewModel;

  PageBubble({
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 55.0,
      height: 55.0,
      child: Center(
        child: new Container(
          width: lerpDouble(20.0, 45.0, viewModel.activePercent),
          height: lerpDouble(20.0, 45.0, viewModel.activePercent),
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: viewModel.isHollow
                  ? const Color(0x88FFFFFF).withAlpha(0x88 * viewModel.activePercent.round())
                  : const Color(0x88FFFFFF),
              border: new Border.all(
                color: viewModel.isHollow
                    ? const Color(0x88FFFFFF).withAlpha(0x88 * (1.0 - viewModel.activePercent).round())
                    : Colors.transparent,
                width: 3.0,
              )
          ),
          child: new Opacity(
            opacity: viewModel.activePercent,
            child: Image.asset(
              viewModel.iconAssetPath,
              color: viewModel.color,
            ),
          ),
        ),
      ),
    );
  }
}


class PageBubbleViewModel {
  final String iconAssetPath;
  final Color color;
  final bool isHollow;
  final double activePercent;

  PageBubbleViewModel(
      this.iconAssetPath,
      this.color,
      this.isHollow,
      this.activePercent,
      );
}

Future<List<PageBubble>> _getBubbles(PagerIndicatorViewModel viewModel) async {
  var values = new List<PageBubble>();

  for (var i = 0; i < viewModel.pages.length; ++i) {
    final page = viewModel.pages[i];

    var percentActive;
    if (i == viewModel.activeIndex) {
      percentActive = 1.0 - viewModel.slidePercent;
    } else if (i == viewModel.activeIndex - 1 && viewModel.slideDirection == SlideDirection.leftToRight) {
      percentActive = viewModel.slidePercent;
    } else if (i == viewModel.activeIndex + 1 && viewModel.slideDirection == SlideDirection.rightToLeft) {
      percentActive = viewModel.slidePercent;
    } else {
      percentActive = 0.0;
    }

    bool isHollow = i > viewModel.activeIndex
        || (i == viewModel.activeIndex && viewModel.slideDirection == SlideDirection.leftToRight);


    values.add(
      new PageBubble(
        viewModel: new PageBubbleViewModel(
          page.iconAssetPath,
          page.color,
          isHollow,
          percentActive,
        ),
      ),
    );
  }

  return values;
}