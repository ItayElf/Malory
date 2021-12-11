import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:malory/screens/home_screen.dart';
import 'package:malory/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => MaterialApp(
        title: 'Malory',
        theme: ThemeData(
            primaryColor: const Color(0xff027368),
            textTheme: TextTheme(
              headline1: GoogleFonts.cinzelDecorative(
                fontSize: convert(71),
                fontWeight: FontWeight.w300,
                letterSpacing: -1.5,
                color: Colors.white,
              ),
              headline2: GoogleFonts.cinzelDecorative(
                fontSize: convert(44),
                fontWeight: FontWeight.w300,
                letterSpacing: -0.5,
                color: Colors.white,
              ),
              headline3: GoogleFonts.cinzelDecorative(
                fontSize: convert(36),
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              headline4: GoogleFonts.cinzelDecorative(
                fontSize: convert(25),
                fontWeight: FontWeight.w400,
                letterSpacing: 0.25,
                color: Colors.white,
              ),
              headline5: GoogleFonts.cinzelDecorative(
                fontSize: convert(18),
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              headline6: GoogleFonts.cinzelDecorative(
                fontSize: convert(15),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.15,
                color: Colors.white,
              ),
              subtitle1: GoogleFonts.cinzelDecorative(
                fontSize: convert(12),
                fontWeight: FontWeight.w400,
                letterSpacing: 0.15,
                color: Colors.white,
              ),
              subtitle2: GoogleFonts.cinzelDecorative(
                fontSize: convert(10),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.1,
                color: Colors.white,
              ),
              bodyText1: GoogleFonts.cinzel(
                fontSize: convert(14),
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
                color: Colors.white,
              ),
              bodyText2: GoogleFonts.cinzel(
                fontSize: convert(12),
                fontWeight: FontWeight.w400,
                letterSpacing: 0.25,
                color: Colors.white,
              ),
              button: GoogleFonts.cinzel(
                fontSize: convert(12),
                fontWeight: FontWeight.w500,
                letterSpacing: 1.25,
                color: Colors.white,
              ),
              caption: GoogleFonts.cinzel(
                fontSize: convert(10),
                fontWeight: FontWeight.w400,
                letterSpacing: 0.4,
                color: Colors.white,
              ),
              overline: GoogleFonts.cinzel(
                fontSize: convert(9),
                fontWeight: FontWeight.w400,
                letterSpacing: 1.5,
                color: Colors.white,
              ),
            )),
        home: const Home(),
      ),
    );
  }
}
