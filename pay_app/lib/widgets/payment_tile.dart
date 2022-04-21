import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentTile extends StatelessWidget {
  final bool incoming;
  final String title;
  final String date;
  final double amount;

  const PaymentTile({
    Key? key,
    required this.incoming,
    required this.title,
    required this.date,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 48.0,
          width: 48.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(56.0),
            border: Border.all(
              color: Colors.black26,
              width: 0.5,
            ),
          ),
          child: Center(
            child: RotatedBox(
              quarterTurns: incoming ? -1 : 1,
              child: Icon(Icons.call_received_sharp),
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.kronaOne(
                fontWeight: FontWeight.w900,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              date,
              style: GoogleFonts.kronaOne(
                color: Colors.black38,
                fontWeight: FontWeight.w100,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        Expanded(child: Container()),
        Text(
          '${incoming ? '+' : '-'}\$${amount.toStringAsFixed(2)}',
          style: GoogleFonts.kronaOne(
            color: incoming ? Colors.green.shade400 : Colors.red.shade400,
            fontWeight: FontWeight.w100,
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }
}
