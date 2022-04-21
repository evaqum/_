import 'package:flutter/material.dart';
import 'package:hz/models/payment_card.dart';

import 'payment_card.dart';

class PaymentCardScroll extends StatefulWidget {
  final PageController? controller;
  final List<PaymentCardData> cards;
  final void Function(PaymentCardData, int) onCardTap;

  PaymentCardScroll({
    Key? key,
    required this.cards,
    required this.onCardTap,
    this.controller,
  }) : super(key: key);

  @override
  _PaymentCardScrollState createState() => _PaymentCardScrollState();
}

class _PaymentCardScrollState extends State<PaymentCardScroll> {
  double? _offset = 0.0;

  @override
  void initState() {
    widget.controller!.addListener(() {
      if (_offset == widget.controller!.page) {
        return;
      }
      setState(() {
        _offset = widget.controller!.page;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.controller,
      itemCount: widget.cards.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        double additionalOffset =
            _offset! < index ? (index - _offset!) * 30 : 0.0;
        return Transform.translate(
          offset: Offset(-32 + additionalOffset, 0),
          // offset: Offset(0, 0),
          child: PaymentCard(
            data: widget.cards[index],
            onTap: () => widget.onCardTap(widget.cards[index], index),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    widget.controller!.dispose();
    super.dispose();
  }
}
