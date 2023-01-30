import 'package:flutter/material.dart';

import 'package:introduction_screen/introduction_screen.dart';
import 'package:movie_app/main.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<PageViewModel> pages = [
      PageViewModel(
        title: "Add Movies",
        body: "Click on the 'Add Movie' button to add a movie to the list",
        image: Image.asset("assets/add.jpeg"),
        decoration: PageDecoration(
          titleTextStyle:
              TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
          bodyTextStyle: TextStyle(fontSize: 15.0),
        ),
      ),
      PageViewModel(
        title: "Delete Movies",
        body: "Swipe right on a movie or click on the delete icon to remove it",
        image: Image.asset("assets/del.png"),
        decoration: PageDecoration(
          titleTextStyle:
              TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
          bodyTextStyle: TextStyle(fontSize: 15.0),
        ),
      ),
      PageViewModel(
        title: "List of Watched Movies",
        body:
            "See all the movies you've watched in an infinite scrollable list",
        image: Image.asset("assets/list.png"),
        decoration: PageDecoration(
          titleTextStyle:
              TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
          bodyTextStyle: TextStyle(fontSize: 15.0),
        ),
      ),
    ];

    return IntroductionScreen(
        pages: pages,
        onDone: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => MyHomePage(
                  title: 'MovieList',
                ),
              ),
            ),
        showSkipButton: true,
        skip: const Text("Skip"),
        next: const Icon(Icons.arrow_forward),
        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            )));
  }
}
