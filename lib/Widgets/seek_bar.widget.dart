import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/Screens/player/audioplayer.screen.dart';

class SeekBar extends StatefulWidget {
  final AudioPlayerHandler audioHandler;
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final bool offline;
  // final double width;
  // final double height;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  const SeekBar({
    required this.duration,
    required this.position,
    required this.offline,
    required this.audioHandler,
    // required this.width,
    // required this.height,
    this.bufferedPosition = Duration.zero,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragValue;
  bool _dragging = false;
  late SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 4.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final value = min(
      _dragValue ?? widget.position.inMilliseconds.toDouble(),
      widget.duration.inMilliseconds.toDouble(),
    );
    if (_dragValue != null && !_dragging) {
      _dragValue = null;
    }
    return Stack(
      children: [
        SliderTheme(
          data: _sliderThemeData.copyWith(
            thumbShape: HiddenThumbComponentShape(),
            activeTrackColor: Colors.white70.withOpacity(0.5),
            inactiveTrackColor: Colors.white70.withOpacity(0.3),
            // trackShape: RoundedRectSliderTrackShape(),
            trackShape: const RectangularSliderTrackShape(),
          ),
          child: ExcludeSemantics(
            child: Slider(
              max: widget.duration.inMilliseconds.toDouble(),
              value: min(
                widget.bufferedPosition.inMilliseconds.toDouble(),
                widget.duration.inMilliseconds.toDouble(),
              ),
              onChanged: (value) {},
            ),
          ),
        ),
        SliderTheme(
          data: _sliderThemeData.copyWith(
            inactiveTrackColor: Colors.transparent,
            activeTrackColor: Colors.white,
            thumbColor: Colors.white,
          ),
          child: Slider(
            max: widget.duration.inMilliseconds.toDouble(),
            value: value,
            onChanged: (value) {
              if (!_dragging) {
                _dragging = true;
              }
              setState(() {
                _dragValue = value;
              });
              widget.onChanged?.call(Duration(milliseconds: value.round()));
            },
            onChangeEnd: (value) {
              widget.onChangeEnd?.call(Duration(milliseconds: value.round()));
              _dragging = false;
            },
          ),
        ),
        Positioned(
            right: 25.0,
            top: 10,
            child: GestureDetector(
              child: Text(
                '1.25x',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                showSliderDialog(
                  context: context,
                  title: 'Adjust Speed',
                  divisions: 25,
                  min: 0.5,
                  max: 3.0,
                  audioHandler: widget.audioHandler,
                );
              },
            )),

        Positioned(
          left: 25.0,
          bottom: 10,
          child: Text(
              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                      .firstMatch('$_position')
                      ?.group(1) ??
                  '$_position',
              style: TextStyle(color: Colors.white)),
        ),
        Positioned(
          right: 25.0,
          bottom: 10,
          child: Text(
            RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                    .firstMatch('$_duration')
                    ?.group(1) ??
                '$_duration',
            style: TextStyle(color: Colors.white)
          ),
        ),
      ],
    );
  }

  Duration get _duration => widget.duration;
  Duration get _position => widget.position;
}

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {}
}

void showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  required AudioPlayerHandler audioHandler,
  String valueSuffix = '',
}) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
        backgroundColor: Color.fromARGB(255, 22, 22, 23),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),    
        content: SizedBox(
          height: 100.0,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(CupertinoIcons.minus, color: Colors.white),
                    onPressed: null,
                  ),
                  Text(
                    '1.0x',
                    style: const TextStyle(
                        fontFamily: 'Fixed',
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        color: Colors.white),
                  ),
                  IconButton(
                    icon: const Icon(CupertinoIcons.plus, color: Colors.white),
                    onPressed: null,
                  ),
                ],
              ),
              Slider(
                inactiveColor: Colors.white70.withOpacity(0.4),
                activeColor: Colors.white,
                divisions: divisions,
                min: min,
                max: max,
                value: 3,
                onChanged: (double value) {
                  // handle onChanged event here
                },
              ),
            ],
          ),
        )),
  );
}
