import 'package:flutter/material.dart';
import 'package:LactoSafe/src/view/welcome_page_contents.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);
  static const routeName = '/WelcomePage';

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int currentPage = 0;

  void goToNextPage() {
    setState(() {
      if (currentPage < 4) {
        currentPage++;
      } else {
        Navigator.pushNamed(context, '/SignIn');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String finalPageButton = 'Avançar';
    Widget pageWidget = Container();

    if (currentPage == 0) {
      pageWidget = PageOne();
    } else if (currentPage == 1) {
      pageWidget = PageTwo();
    } else if (currentPage == 2) {
      pageWidget = PageThree();
    } else if (currentPage == 3) {
      pageWidget = PageFour();
    } else if (currentPage == 4) {
      finalPageButton = 'Finalizar';
      pageWidget = PageFive();
    }

    List<Widget> pageIndicator = List.generate(
      5,
      (index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentPage == index
                ? Theme.of(context).primaryColor
                : Colors.grey,
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          pageWidget,
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: pageIndicator,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/SignIn');
                  },
                  child: const Text(
                    "Pular",
                    style: TextStyle(
                      color: Color.fromARGB(221, 63, 62, 62),
                      fontSize: 16,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    goToNextPage();
                  },
                  child: Text(
                    finalPageButton,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
