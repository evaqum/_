import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models.dart';

class CountryCard extends StatelessWidget {
  final Country country;
  final int currentPlaceIndex;

  const CountryCard({
    Key? key,
    required this.country,
    required this.currentPlaceIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Place currentPlace = country.places![currentPlaceIndex];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        image: DecorationImage(
          image: AssetImage(currentPlace.imageAsset!),
          fit: BoxFit.cover,
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.14),
        //     offset: const Offset(0.0, 8.0),
        //     spreadRadius: 4.0,
        //     blurRadius: 6.0,
        //   ),
        // ],
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x001D68CA),
                  Color(0xF01D68CA),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentPlace.name,
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    letterSpacing: -1.0,
                    fontSize: 42.0,
                  ),
                ),
                if (currentPlace.description != null) ...[
                  SizedBox(height: 6.0),
                  Text(
                    currentPlace.description!,
                    style: GoogleFonts.openSans(
                      color: Colors.white.withOpacity(0.78),
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                ],
                Row(
                  children: [
                    Text(
                      'Discover place ',
                      style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                    ),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                      color: Colors.white,
                      size: 28.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
