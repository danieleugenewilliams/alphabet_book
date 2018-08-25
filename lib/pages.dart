import 'package:flutter/material.dart';

final pages = [
  new PageViewModel(
      Colors.blueGrey,
      'assets/images/alphabet_book.png',
      'Alphabet Book',
      '',
      'assets/images/orion.png'
  ),
  new PageViewModel(
      Colors.lightGreen,
      'assets/images/airplane.png',
      'A    a',
      'Airplane',
      'assets/images/a.png'
  ),
  new PageViewModel(
      Colors.indigoAccent,
      'assets/images/butterfly.png',
      'B    b',
      'Butterfly',
      'assets/images/b.png'
  ),
  new PageViewModel(
      Colors.indigo,
      'assets/images/car.png',
      'C    c',
      'Car',
      'assets/images/c.png'
  ),
  new PageViewModel(
      Colors.lightGreen,
      'assets/images/dog.png',
      'D    d',
      'Dog',
      'assets/images/d.png'
  ),
  new PageViewModel(
      Colors.indigoAccent,
      'assets/images/elephant.png',
      'E    e',
      'Elephant',
      'assets/images/e.png'
  ),
  new PageViewModel(
      Colors.indigo,
      'assets/images/flower.png',
      'F    f',
      'Flower',
      'assets/images/f.png'
  ),
  new PageViewModel(
      Colors.lightGreen,
      'assets/images/grasshopper.png',
      'G    g',
      'Grasshopper',
      'assets/images/g.png'
  ),
  new PageViewModel(
      Colors.indigoAccent,
      'assets/images/helicopter.png',
      'H    h',
      'Helicopter',
      'assets/images/h.png'
  ),
  new PageViewModel(
      Colors.indigo,
      'assets/images/icecream.png',
      'I    i',
      'Ice Cream',
      'assets/images/i.png'
  ),
  new PageViewModel(
      Colors.lightGreen,
      'assets/images/jellyfish.png',
      'J    j',
      'Jellyfish',
      'assets/images/j.png'
  ),
  new PageViewModel(
      Colors.indigoAccent,
      'assets/images/key.png',
      'K    k',
      'Key',
      'assets/images/k.png'
  ),
  new PageViewModel(
      Colors.indigo,
      'assets/images/lion.png',
      'L    l',
      'Lion',
      'assets/images/l.png'
  ),
  new PageViewModel(
      Colors.lightGreen,
      'assets/images/monkey.png',
      'M    m',
      'Monkey',
      'assets/images/m.png'
  ),
  new PageViewModel(
      Colors.indigoAccent,
      'assets/images/noodles.png',
      'N    n',
      'Noodles',
      'assets/images/n.png'
  ),
  new PageViewModel(
      Colors.indigo,
      'assets/images/owl.png',
      'O    o',
      'Owl',
      'assets/images/o.png'
  ),
  new PageViewModel(
      Colors.lightGreen,
      'assets/images/panda.png',
      'P    p',
      'Panda',
      'assets/images/p.png'
  ),
  new PageViewModel(
      Colors.indigoAccent,
      'assets/images/quokka.png',
      'Q    q',
      'Quokka',
      'assets/images/q.png'
  ),
  new PageViewModel(
      Colors.indigo,
      'assets/images/robot.png',
      'R    r',
      'Robot',
      'assets/images/r.png'
  ),
  new PageViewModel(
      Colors.lightGreen,
      'assets/images/star.png',
      'S    s',
      'Star',
      'assets/images/s.png'
  ),
  new PageViewModel(
      Colors.indigoAccent,
      'assets/images/tiger.png',
      'T    t',
      'Tiger',
      'assets/images/t.png'
  ),
  new PageViewModel(
      Colors.indigo,
      'assets/images/umbrella.png',
      'U    u',
      'Umbrella',
      'assets/images/u.png'
  ),
  new PageViewModel(
      Colors.lightGreen,
      'assets/images/vase.png',
      'V    v',
      'Vase',
      'assets/images/v.png'
  ),
  new PageViewModel(
      Colors.indigoAccent,
      'assets/images/watermelon.png',
      'W    w',
      'Watermelon',
      'assets/images/w.png'
  ),
  new PageViewModel(
      Colors.indigo,
      'assets/images/xylophone.png',
      'X    x',
      'Xylophone',
      'assets/images/x.png'
  ),
  new PageViewModel(
      Colors.lightGreen,
      'assets/images/zebra.png',
      'Z    z',
      'Zebra',
      'assets/images/z.png'
  ),
];

class Page extends StatelessWidget {

  final PageViewModel viewModel;
  final double percentVisible;

  Page({
    this.viewModel,
    this.percentVisible = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      color: viewModel.color,
      child: new Opacity(
        opacity: percentVisible,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Transform(
              transform: new Matrix4.translationValues(0.0, 30.0 * (1.0 - percentVisible), 0.0),
              child: new Padding(
                padding: new EdgeInsets.only(top:10.0, bottom:10.0),
                child: new Text(
                    viewModel.title,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      color: Colors.white,
                      fontFamily: 'FlamanteRoma',
                      fontSize: 84.0,
                    )
                ),
              ),
            ),
            new Transform(
              transform: new Matrix4.translationValues(0.0, 50.0 * (1.0 - percentVisible), 0.0),
              child: new Padding(
                padding: new EdgeInsets.only(bottom:30.0),
                child: new Image.asset(
                  viewModel.heroAssetPath,
                  width:double.infinity,
                  height:190.0,
                  alignment: Alignment.center,
                ),
              ),
            ),
            new Transform(
              transform: new Matrix4.translationValues(0.0, 30.0 * (1.0 - percentVisible), 0.0),
              child: new Padding(
                padding: new EdgeInsets.only(bottom: 15.0),
                child: new Text(
                    viewModel.body,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      color: Colors.white,
                      fontFamily: 'FlamanteRoma',
                      fontSize: 36.0,
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PageViewModel {
  final Color color;
  final String heroAssetPath;
  final String title;
  final String body;
  final String iconAssetPath;

  PageViewModel(
    this.color,
    this.heroAssetPath,
    this.title,
    this.body,
    this.iconAssetPath,
  );

}