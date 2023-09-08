import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_3/screens/counter.dart';
import 'package:flutter_application_3/screens/image_carusel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class movieDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FirstScreen();
  }
}

class _FirstScreen extends State<movieDetails> {
  bool _isFavorited = true;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 253, 32, 32),
          leading: Row(
            children: <Widget>[
              SizedBox(
                width: 5.0,
              ),
              IconButton(
                color: Colors.white,
                icon: const Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            SizedBox(
              width: 20.0,
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 253, 32, 32),
        body: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                CarouselWithIndicatorDemo(),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(50.0),
                        topRight: const Radius.circular(50.0),
                      )),
                  height: 600,
                  width: 500,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                          ),
                                                    DefaultTextStyle(style: const TextStyle(
    fontSize: 35.0,fontWeight: FontWeight.bold, color: Colors.black, 
  ),

  child: AnimatedTextKit(
    animatedTexts: [
      WavyAnimatedText(
          'FLCL (ANIME SERIES)'),
    ],
    isRepeatingAnimation: true,
    onTap: () {
      print("Tap Event");
    },
  ),
),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text('1 each'),
                          SizedBox(
                            height: 20.0,
                          ),
                          CounterDesign(),
                          SizedBox(
                            height: 30.0,
                          ),
                          DefaultTextStyle(style: const TextStyle(
    fontSize: 25.0,fontWeight: FontWeight.bold, color: Colors.black, 
  ),

  child: AnimatedTextKit(
    animatedTexts: [
      WavyAnimatedText(
          'Movie/Series synopsis'),
    ],
    isRepeatingAnimation: true,
    onTap: () {
     //print("Tap Event");
    },
  ),
),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'The protagonist is Naota Nandaba, a twelve-year-old boy whose interactions with Haruko Haruhara '
                            '(a supposed alien who breaks into the quiet suburb) '
                            'have caused him to develop a strange hormonal disorder that causes various robots '
                            'to sprout from his forehead whenever he finds himself in compromising situations.',
                            style:
                                TextStyle(letterSpacing: 2.0, fontSize: 15.0),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            children: <Widget>[
                              ButtonTheme(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(color: Colors.white),
                                ),
                                height: 70.0,
                                child: ElevatedButton(
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red), elevation: MaterialStateProperty.all(0.0),padding: MaterialStateProperty.all(EdgeInsets.all(4)),),
                                  
                                  child: IconButton(
                                      icon: _isFavorited
                                          ? Icon(
                                              Icons.favorite_border,
                                              color: Colors.white,
                                            )
                                          : Icon(
                                              Icons.favorite,
                                              color: Colors.white,
                                            ), onPressed: () {  },),
                                  onPressed: _toggleFavorite,
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              ButtonTheme(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                height: 70.0,
                                minWidth: 260.0,
                                child: ElevatedButton(
                                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red), elevation: MaterialStateProperty.all(0.0),padding: MaterialStateProperty.all(EdgeInsets.all(20)),),
                                  onPressed: () {},
                                  child: Text(
                                    'Add to cart',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              RatingBar.builder(
   initialRating: 3,
   minRating: 0,
   direction: Axis.horizontal,
   allowHalfRating: true,
   itemCount: 5,
   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
   itemBuilder: (context, _) => Icon(
     Icons.star,
     color: Colors.red,
   ),
   onRatingUpdate: (rating) {
     //print(rating);
   },
),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}