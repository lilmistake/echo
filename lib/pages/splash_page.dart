import 'package:app/game_provider.dart';
import 'package:app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key, required this.data});
  final GameData data;

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider = Provider.of<GameProvider>(context);
    return InkWell(
      onTap: gameProvider.showNextPage,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: FittedBox(
              child: Text(
                data.title,
                style: TextStyle(
                    fontSize: 100,
                    color: Colors.white,
                    fontFamily: GoogleFonts.getFont(data.titleFont).fontFamily,
                    fontWeight: FontWeight.w900),
              ),
            ),
          ),
          Text(
            "Click to Start Your Jorney!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: GoogleFonts.getFont(data.titleFont).fontFamily,
            ),
          ),
        ],
      ),
    );
  }
}
