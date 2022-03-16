import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EffioAppBar extends StatelessWidget with PreferredSizeWidget {
  const EffioAppBar({Key? key}) : super(key: key);
  final _url = 'https://overthinkersjourney.com/philosophy-of-fitness/';
  void _launchURL() async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: GestureDetector(
        onDoubleTap: _launchURL,
        child: Text(
          'EFFIO',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontFamily: 'Rammetto One',
          ),
        ),
      ),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
