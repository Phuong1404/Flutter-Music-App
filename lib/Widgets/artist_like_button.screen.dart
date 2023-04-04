import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_app/Widgets/snackbar.widget.dart';

class ArtistLikeButton extends StatefulWidget {
  final double? size;
  final Map data;
  final bool showSnack;
  const ArtistLikeButton({
    super.key,
    this.size,
    required this.data,
    this.showSnack = false,
  });

  @override
  _ArtistLikeButtonState createState() => _ArtistLikeButtonState();
}

class _ArtistLikeButtonState extends State<ArtistLikeButton>
    with SingleTickerProviderStateMixin {
  bool liked = false;
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _curve;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _curve = CurvedAnimation(parent: _controller, curve: Curves.slowMiddle);

    _scale = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.2),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0),
        weight: 50,
      ),
    ]).animate(_curve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: IconButton(
        icon: Icon(
          liked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          color: liked ? Colors.redAccent : Colors.white,
        ),
        iconSize: widget.size ?? 24.0,
        tooltip: liked ? 'Unlike' : 'Like',
        onPressed: () async {
          if (!liked) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
          setState(() {
            liked = !liked;
          });
          if (widget.showSnack) {
            ShowSnackBar().showSnackBar(
              context,
              liked ? 'Added to Favorites' : 'Removed from Favorites',
            );
          }
        },
      ),
    );
  }
}
