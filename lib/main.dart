import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> imgList = [
  'https://pbs.twimg.com/profile_images/926490279749783552/jKFTBcvm_400x400.jpg',
  'https://aws1.discourse-cdn.com/nubank/original/3X/7/a/7ae3ac803c9af9b2dea0b1390a5dc4a1629c191f.jpeg',
  'https://play-lh.googleusercontent.com/IA_-UGo_Np05_G8TUE6ckEVyvkj6EBSrZmy7R5mwnTQUZqO69QJPlRtR2SOXf1QSLg',
  'http://s2.glbimg.com/r4LVSTbdJ9mM_EArrccE1HYSqJM=/s.glbimg.com/og/rg/f/original/2015/11/03/gp_iphone.jpg'
];

void main() => runApp(Carousel());

final themeMode = ValueNotifier(2);

class Carousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (context, value, g) {
        return MaterialApp(
          initialRoute: '/reason',
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.values.toList()[value as int],
          debugShowCheckedModeBanner: false,
          routes: {
            '/reason': (ctx) => CarouselChangeReasonDemo(),
          },
        );
      },
      valueListenable: themeMode,
    );
  }
}

class Item extends StatelessWidget {
  final String title;
  final String route;
  Item(this.title, this.route);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

class CarouselChangeReasonDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselChangeReasonDemoState();
  }
}

class _CarouselChangeReasonDemoState extends State<CarouselChangeReasonDemo> {
  String reason = '';
  final CarouselController _controller = CarouselController();

  void onPageChange(int index, CarouselPageChangedReason changeReason) {
    setState(() {
      switch (index) {
        case 1:
          {
            reason = 'Nubank';
          }
          break;

        case 2:
          {
            reason = 'Banco bS2';
          }
          break;

        case 3:
          {
            reason = 'Globo';
          }
          break;

        default:
          {
            reason = '';
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Engenharia da Computação - FIT'), actions: [
          IconButton(
              icon: Icon(Icons.nightlight_round),
              onPressed: () {
                themeMode.value = themeMode.value == 1 ? 2 : 1;
              })
        ]),
        body: Column(
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(' \n Grupo:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                  Text(
                      '\nCaio de Sá RA:1902935'
                      '\nFelix dos Santos RA:1902906'
                      '\nGustavo Souza Galvino RA:1904026'
                      '\nJordan Marques de Souza RA:1904016'
                      '\nNicholas Miranda Bastos RA:1904018'
                      '\nRichard de Oliveira Lopes RA:1902936\n',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            Expanded(
              child: CarouselSlider(
                items: imageSliders,
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  onPageChanged: onPageChange,
                  autoPlay: true,
                ),
                carouselController: _controller,
              ),
            ),
            Flexible(
              child: Column(
                children: <Widget>[
                  Text(' \n Apps criados com Flutter:',
                      style: TextStyle(fontSize: 20)),
                  Text('${reason}', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: ElevatedButton(
                    onPressed: () => _controller.previousPage(),
                    child: Text('Voltar'),
                  ),
                ),
                Flexible(
                  child: ElevatedButton(
                    onPressed: () => _controller.nextPage(),
                    child: Text('Avançar'),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
