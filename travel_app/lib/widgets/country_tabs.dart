import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models.dart';

class CountryTabs extends StatefulWidget {
  final List<Country> countries;
  final int selectedIndex;
  final void Function(int index) onTap;

  const CountryTabs({
    Key? key,
    required this.countries,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  _CountryTabsState createState() => _CountryTabsState();
}

class _CountryTabsState extends State<CountryTabs>
    with SingleTickerProviderStateMixin {
  late ScrollController _tabScrollController;

  @override
  void initState() {
    super.initState();
    _tabScrollController = ScrollController(
      initialScrollOffset: _textWidths
          .getRange(0, widget.selectedIndex)
          .fold(0.0, (a, b) => a + b),
    );
  }

  List<double> get _textWidths {
    return widget.countries
        .map((country) => getEffectiveTabTextWidth(country.name))
        .toList();
  }

  @override
  void didUpdateWidget(covariant CountryTabs oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedIndex != oldWidget.selectedIndex) {
      final double offset = _textWidths
          .getRange(0, widget.selectedIndex)
          .fold(0.0, (a, b) => a + b);
      _tabScrollController.animateTo(
        offset,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _tabScrollController,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Row(
        children: widget.countries.map(
          (country) {
            final int index = widget.countries.indexOf(country);
            return GestureDetector(
              onTap: () {
                widget.onTap(index);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  country.name,
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    color: index == widget.selectedIndex
                        ? Colors.white
                        : Colors.white.withOpacity(0.38),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  static double getEffectiveTabTextWidth(String text) {
    final TextStyle style = GoogleFonts.nunito(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
    );
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0.0, maxWidth: double.infinity);
    return textPainter.size.width + 32.0;
  }
}
