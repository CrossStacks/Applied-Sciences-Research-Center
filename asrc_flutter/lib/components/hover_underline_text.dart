import 'package:flutter/material.dart';

class HoverUnderlineText extends StatefulWidget {
  final TextStyle style;
  final VoidCallback? onTap;
  final String text;
  const HoverUnderlineText(
      {super.key, required this.text, required this.style, this.onTap});

  @override
  State<HoverUnderlineText> createState() => _HoverUnderlineTextState();
}

class _HoverUnderlineTextState extends State<HoverUnderlineText> {
  double _underlineFraction = 0;
  double _textWidth = 0;
  final GlobalKey _textKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? renderBox =
          _textKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        setState(() {
          _textWidth = renderBox.size.width;
        });
      }
    });
  }

  void _onHover(bool hovering) {
    setState(() {
      _underlineFraction = hovering ? 1 : 0;
    });
  }

  void _onTap() {
    setState(() {
      // widget.!onTap??{};
      _underlineFraction = _underlineFraction == 1 ? 0 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => _onHover(true),
        onExit: (_) => _onHover(false),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 2,
            ),
            Text(
              widget.text,
              key: _textKey,
              style: widget.style,
            ),
            SizedBox(
              width: _textWidth,
              height: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  width: _underlineFraction * _textWidth,
                  height: 2,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
