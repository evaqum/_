import 'dart:ui';

import 'package:flutr/models.dart';
import 'package:flutr/widgets/country_card.dart';
import 'package:flutr/widgets/country_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(App());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppHome(),
    );
  }
}

class AppHome extends StatefulWidget {
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  static const double _blurSigma = 10.0;
  static const double _cardViewHeight = 400.0;

  final PageController _pageController = PageController(viewportFraction: 0.84);
  double? currentPageOffset = 0.0;

  int currentCountryIndex = 0;
  int currentPlaceIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      // print(_pageController.page);
      setState(() {
        currentPageOffset = _pageController.page;
      });
    });
  }

  List<Widget> buildBackground() => [
        SizedBox.expand(
          child: FittedBox(
            child: Image.asset('assets/cappadocia.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        Container(color: Colors.white.withOpacity(0.35)),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: _blurSigma, sigmaY: _blurSigma),
          child: Container(color: Colors.black.withOpacity(0.4)),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
        title: Text('app', style: GoogleFonts.poppins()),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Stack(
        children: [
          ...buildBackground(),
          ConstrainedBox(
            constraints: BoxConstraints.tight(screenSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CountryTabs(
                  countries: globalCountries,
                  selectedIndex: currentCountryIndex,
                  onTap: (i) => setState(() => currentCountryIndex = i),
                ),
                const SizedBox(height: 24.0),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: screenSize.width,
                    maxHeight: _cardViewHeight,
                  ),
                  child: PageView.builder(
                    controller: _pageController,
                    physics: BouncingScrollPhysics(),
                    itemCount: globalCountries.length,
                    itemBuilder: (context, index) {
                      final Widget child = Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CountryCard(
                          country: globalCountries[index],
                          currentPlaceIndex: index == currentCountryIndex
                              ? currentPlaceIndex
                              : 0,
                        ),
                      );
                      final double v = currentPageOffset! - index;
                      final double scale = (1.0 - v.abs()) * 0.2 + 0.8;
                      final double padding =
                          (_cardViewHeight - _cardViewHeight * scale) / 4;
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: padding,
                        ),
                        child: child,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 48.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '01',
                              style: GoogleFonts.miriamLibre(
                                color: Colors.white.withOpacity(0.87),
                                fontSize: 36.0,
                              ),
                            ),
                            TextSpan(
                              text: '/12',
                              style: GoogleFonts.miriamLibre(
                                color: Colors.white.withOpacity(0.42),
                                fontSize: 22.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          RotatedBox(
                            quarterTurns: 2,
                            child: Icon(
                              Icons.arrow_right_alt_rounded,
                              color: Colors.white,
                              size: 32.0,
                            ),
                          ),
                          Icon(
                            Icons.arrow_right_alt_rounded,
                            color: Colors.white,
                            size: 32.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.white.withOpacity(0.14),
                      value: 0.3,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        'Cappadocia',
                        'Mersin',
                        'Antalya',
                        'Istanbul',
                        'Izmir',
                        'Ankara'
                      ].map((city) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            city,
                            style: GoogleFonts.nunito(
                              color: Colors.white.withOpacity(
                                city == 'Cappadocia' ? 1.0 : 0.67,
                              ),
                              fontWeight: FontWeight.w400,
                              fontSize: 18.0,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 48.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
