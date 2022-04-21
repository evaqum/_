import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hz/models/payment_card.dart';

class PaymentCard extends StatelessWidget {
  final PaymentCardData data;
  // final PaymentCardStyle style;
  // final PaymentCardProvider provider;
  // final String ownerName;
  final void Function()? onTap;

  const PaymentCard({
    Key? key,
    required this.data,
    this.onTap,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 500.0),
      child: AspectRatio(
        aspectRatio: 53.98 / 85.60,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              gradient: LinearGradient(
                colors: [
                  [
                    const Color(0xFFFFA751),
                    const Color(0xFFFFE259),
                  ],
                  [
                    const Color(0xFF5433FF),
                    const Color(0xFF20BDFF),
                    const Color(0xFFA5FECB),
                  ],
                  [
                    const Color(0xFFF7797D),
                    const Color(0xFFFBD786),
                    const Color(0xFFC6FFDD),
                  ],
                ][data.style!.index],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 24.0,
                  left: 24.0,
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: [
                      Icon(
                        Icons.accessible_forward_sharp,
                        color: Colors.white60,
                        size: 48.0,
                      ),
                      Text(
                        'HUISA  ',
                        style: GoogleFonts.ptSans(
                          color: Colors.white60,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 38.0,
                          letterSpacing: -1,
                        ),
                      ),
                      Icon(
                        Icons.disc_full_outlined,
                        color: Colors.white60,
                        size: 48.0,
                      ),
                    ][data.provider!.index],
                  ),
                ),
                Positioned(
                  bottom: 24.0,
                  right: 24.0,
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: Text(
                      data.ownerName?.toUpperCase() ?? 'CHICH WOWIY',
                      style: GoogleFonts.montserrat(
                        color: Colors.black54,
                        letterSpacing: 5.0,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
