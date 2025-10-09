import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: HSLColor.fromColor(const Color(0xFFFCD956))
          .withLightness(0.9) 
          .toColor(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/3.png',
                width: 200,
                height: 200,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: Text(
                'SEKO',
                style:
                    GoogleFonts.albertSans(color: Colors.black, fontSize: 64),
              ),
            ),
            const SizedBox(height: 30),
            Center(
                child: Text(
              'Fair Prices, Fresh Choices.',
              style: GoogleFonts.albertSans(color: Colors.black, fontSize: 24),
            )),
          ],
        ),
      ),
    );
  }
}