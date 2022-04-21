import 'dart:math';

// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hz/models/payment_card.dart';
import 'package:hz/widgets/payment_tile.dart';

import '../widgets/payment_card_scroll.dart';

List<PaymentCardData> _paymentCards = [
  PaymentCardData(
    style: PaymentCardStyle.yellowish,
    provider: PaymentCardProvider.invalidCard,
    balance: 4.20,
    ownerName: 'Oleg Oleg',
  ),
  PaymentCardData(
    style: PaymentCardStyle.blueish,
    provider: PaymentCardProvider.huisa,
    balance: 0.03,
    ownerName: 'Oleg Oleg',
  ),
  PaymentCardData(
    style: PaymentCardStyle.trafficLightish,
    provider: PaymentCardProvider.invalidCard,
    balance: -1.56,
    ownerName: 'Oleg Oleg',
  ),
  PaymentCardData(
    style: PaymentCardStyle.blueish,
    provider: PaymentCardProvider.disk,
    balance: 31789.28,
    ownerName: 'Oleg Oleg',
  ),
];

// AudioCache audioCache = AudioCache(prefix: 'assets/audios/');

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late double _currentOffset = 0;
  late PageController _cardScrollController;
  // FutureOr<AudioPlayer>? playerFuture;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
    _cardScrollController = PageController(
      viewportFraction: 0.75,
    );

    _cardScrollController.addListener(() async {
      double? page = _cardScrollController.page;
      if (page == null || page == _currentOffset) {
        return;
      }

      // раньше тут играла музыка
      // if (page.round() == 3 && playerFuture == null) {
      //   playerFuture = audioCache.play('amogus.mp3');
      // } else if (page.round() != 3 && playerFuture != null) {
      //   final player = await playerFuture;
      //   await player!.stop();
      //   playerFuture = null;
      // }
      setState(() {
        _currentOffset = page;
      });
    });
    super.initState();
  }

  Widget buildProfilePicRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            minRadius: 30.0,
            // backgroundColor: Colors.black,
            backgroundImage: AssetImage('assets/chich.jpg'),
          ),
        ],
      ),
    );
  }

  Widget buildTopColumn() {
    final double? balance = _paymentCards[_currentOffset.round()].balance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildProfilePicRow(),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return Align(
              alignment: Alignment.centerLeft,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          child: Text(
            _currentOffset.round() == 3 ? 'Chich CD' : 'Chich Pay',
            key: ValueKey<bool>(_currentOffset.round() == 3),
            style: GoogleFonts.kronaOne(
              fontWeight: FontWeight.w900,
              fontSize: 24.0,
            ),
          ),
        ),
        const SizedBox(height: 32.0),
        Text(
          'OLEG',
          style: GoogleFonts.kronaOne(
            color: Colors.black54,
            fontWeight: FontWeight.w100,
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 4.0),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return Align(
              alignment: Alignment.centerLeft,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          child: Text(
            _currentOffset.round() == 3
                ? '491 Mb / 700 Mb'
                : '\$${balance!.abs().toStringAsFixed(2)}',
            key: ValueKey<int>(_currentOffset.round()),
            style: GoogleFonts.kronaOne(
              fontWeight: FontWeight.w100,
              fontSize: 22.0,
              color: _paymentCards[_currentOffset.round()].balance! < 0.00
                  ? Colors.red.shade400
                  : Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPageIndicator() {
    final int totalPages = _paymentCards.length;
    final double? current = _currentOffset;
    // int currentPage = current.floor();
    // int nextPage = currentPage + 1;

    final ColorTween colorTween = ColorTween(
      begin: Colors.black,
      end: Colors.black26,
    );

    final Tween<double> widthTween = Tween(
      begin: 48.0,
      end: 6.0,
    );

    return Padding(
      padding: const EdgeInsets.only(left: 32.0),
      child: Row(
        children: [
          for (int i = 0; i < totalPages; i++)
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Container(
                // curve: Curves.easeInOutCubic,
                // duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  // color: current == i ? Colors.black : Colors.black26,
                  color: colorTween
                      .transform((current! - i).abs().clamp(0.0, 1.0)),
                ),
                height: 6.0,
                width: widthTween.transform(
                  (current - i).abs().clamp(0.0, 1.0),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget? child) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(-0.4, -1.0),
                  radius: 3.5 + _animationController.value * 0.01,
                  colors: [
                    const Color(0xFF2AD0CA),
                    const Color(0xFFE1F664),
                    const Color(0xFFFEB0FE),
                    const Color(0xFFABB3FC),
                    const Color(0xFF5DF7A4),
                    const Color(0xFF58C4F6),
                  ],
                  transform: GradientRotation(
                    2 * pi * _animationController.value,
                  ),
                ),
              ),
            );
          },
        ),
        for (BlendMode blendMode in [BlendMode.difference, BlendMode.screen])
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              backgroundBlendMode: blendMode,
              gradient: SweepGradient(
                colors: [
                  for (int i = 0; i < 4; i++) ...[
                    Colors.white,
                    Colors.black,
                  ],
                  Colors.white,
                ],
              ),
            ),
          ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          width: double.infinity,
          height: double.infinity,
          color: _currentOffset.round() == 3
              ? const Color(0x00FFFFFF)
              : Colors.white,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: buildTopColumn(),
                ),
                Expanded(
                  child: PaymentCardScroll(
                    controller: _cardScrollController,
                    cards: _paymentCards,
                    onCardTap: (_, i) {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        barrierColor: Colors.black.withOpacity(0.24),
                        builder: (BuildContext context) {
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(24.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Actions',
                                    style: GoogleFonts.kronaOne(
                                      fontSize: 24.0,
                                    ),
                                  ),
                                  const SizedBox(height: 28.0),
                                  Container(
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width: 70.0,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Icon(
                                                Icons.arrow_upward_rounded,
                                                size: 36.0,
                                              ),
                                              const SizedBox(height: 6.0),
                                              Text(
                                                'Send',
                                                style: GoogleFonts.kronaOne(),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 70.0,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Icon(
                                                Icons.more_horiz_rounded,
                                                size: 36.0,
                                              ),
                                              const SizedBox(height: 6.0),
                                              Text(
                                                'Details',
                                                style: GoogleFonts.kronaOne(),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 70.0,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Icon(
                                                Icons.arrow_downward_rounded,
                                                size: 36.0,
                                              ),
                                              const SizedBox(height: 6.0),
                                              Text(
                                                'Receive',
                                                style: GoogleFonts.kronaOne(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(height: 38.0),
                                  PaymentTile(
                                    incoming: false,
                                    title: 'Starbucks',
                                    date: 'Today',
                                    amount: 5.40,
                                  ),
                                  const SizedBox(height: 24.0),
                                  PaymentTile(
                                    incoming: true,
                                    title: 'Transfer',
                                    date: '2 May\' 20',
                                    amount: 7.9,
                                  ),
                                  const SizedBox(height: 24.0),
                                  Row(
                                    children: [
                                      Container(
                                        height: 48.0,
                                        width: 48.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(56.0),
                                          // border: Border.all(
                                          //   color: Colors.black26,
                                          //   width: 0.5,
                                          // ),
                                        ),
                                        child: Center(
                                          child:
                                              Icon(Icons.more_horiz_outlined),
                                        ),
                                      ),
                                      const SizedBox(width: 12.0),
                                      Text(
                                        'See more',
                                        style: GoogleFonts.kronaOne(
                                          // fontWeight: FontWeight.w100,
                                          color: Colors.black54,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 40.0),
                buildPageIndicator(),
                const SizedBox(height: 130.0),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _cardScrollController.dispose();
    super.dispose();
  }
}
