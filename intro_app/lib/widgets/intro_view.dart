import 'package:flutr/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroView extends StatefulWidget {
  final List<IntroPage> introPages;

  const IntroView({Key key, this.introPages}) : super(key: key);

  @override
  _IntroViewState createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  int currentPageIndex = 0;

  static const double skipButtonPadding = 18.0;
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final Size screenSize = MediaQuery.of(context).size;
    final bool isOnLastPage = currentPageIndex >= widget.introPages.length - 1;

    final IntroPage currentPage = widget.introPages[currentPageIndex];

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: skipButtonPadding,
            top: statusBarHeight + skipButtonPadding,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isOnLastPage ? 0.0 : 1.0,
              child: FlatButton(
                shape: StadiumBorder(),
                onPressed: () {
                  if (isOnLastPage) return;
                  setState(
                    () => currentPageIndex = widget.introPages.length - 1,
                  );
                },
                child: Text(
                  'Skip',
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                      color: const Color(0xFF94A3BD),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: screenSize.width * 0.1,
              top: skipButtonPadding + statusBarHeight + screenSize.height / 8,
            ),
            child: SizedBox(
              width: screenSize.width * 0.8,
              height: screenSize.width * 0.8,
              child: Placeholder(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentPage.title,
                      style: GoogleFonts.cabin(
                        textStyle: TextStyle(
                          color: Color(0xFF212B40),
                          fontWeight: FontWeight.bold,
                          fontSize: 26.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      currentPage.description,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          color: Color(0xF07783A2),
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Progress(
                      currentIndex: currentPageIndex,
                      maxLength: widget.introPages.length,
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      minWidth: 110.0,
                      height: 56.0,
                      onPressed: () {
                        if (isOnLastPage) {
                          setState(() => currentPageIndex = 0);
                          return;
                        }
                        setState(() => currentPageIndex++);
                      },
                      color: Color(0xFF6761D0),
                      child: Text(
                        isOnLastPage ? 'Go Back' : 'Next',
                        style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IntroPage {
  final String title;
  final String description;

  IntroPage({this.title, this.description});
}
