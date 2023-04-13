import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Welcom To El-Zareef Student Recording App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20 * 2),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: SvgPicture.asset(
                "assets/icons/chat.svg",
              ),
            ),
            Spacer(),
          ],
        ),
        SizedBox(height: 20 * 2),
      ],
    );
  }
}
