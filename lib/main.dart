import 'package:flutter/material.dart';
import 'package:hangman/components/colors.dart';
import 'package:hangman/components/text_format.dart';
import 'package:hangman/models/game.dart';
import 'package:hangman/widget/figure_image.dart';
import 'package:hangman/widget/letter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String word = 'Icarus'.toUpperCase();
  List<String> alphabets = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const PoppinsText(
          text: "Hangman",
          fontS: 24,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Divider(
            color: Colors.black,
          ),
          Center(
            child: Stack(
              children: [
                figureImage(Game.tries >= 0, 'assets/hang.png'),
                figureImage(Game.tries >= 1, 'assets/head.png'),
                figureImage(Game.tries >= 2, 'assets/body.png'),
                figureImage(Game.tries >= 3, 'assets/ra.png'),
                figureImage(Game.tries >= 4, 'assets/la.png'),
                figureImage(Game.tries >= 5, 'assets/rl.png'),
                figureImage(Game.tries >= 6, 'assets/ll.png'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: word
                  .split('')
                  .map((e) => letter(e.toUpperCase(),
                      !Game.selectedChar.contains(e.toUpperCase())))
                  .toList(),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 350.0,
            child: GridView.count(
              crossAxisCount: 7,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              padding: const EdgeInsets.all(25.0),
              children: alphabets.map((e) {
                return RawMaterialButton(
                  onPressed: Game.selectedChar.contains(e)
                      ? null
                      : () {
                          setState(() {
                            Game.selectedChar.add(e);
                            print(Game.selectedChar);
                            if (!word.split('').contains(e.toUpperCase())) {
                              Game.tries++;
                            }
                            if (Game.tries == 6) {
                              Alert(
                                context: context,
                                type: AlertType.error,
                                title: "You Failed!",
                                desc: "You killed that dude.",
                                buttons: [
                                  DialogButton(
                                    onPressed: () {
                                      setState(() {
                                        Navigator.pop(context);
                                        Game.tries = 0;
                                        Game.selectedChar.clear();
                                      });
                                    },
                                    width: 120,
                                    child: const Text(
                                      "Try again",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  )
                                ],
                              ).show();
                            }
                          });
                        },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  fillColor: Game.selectedChar.contains(e)
                      ? Colors.black87
                      : primaryDark,
                  child: PoppinsText(
                    text: e,
                    fontS: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
