import 'package:flutter/material.dart';

class CustomButtonWidget extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final Color initialColor;
  final Color initialTextColor;
  final Color hoverColor;
  final Color? initialBorderColor;
  final Color? hoverBorderColor;
  final Color hoverTextColor;
  final double? width;
  final VoidCallback onTap;

  const CustomButtonWidget({
    super.key,
    required this.text,
    required this.textStyle,
    required this.initialColor,
    required this.initialTextColor,
    required this.hoverColor,
    required this.hoverTextColor,
    this.width,
    required this.onTap,
    this.initialBorderColor,
    this.hoverBorderColor,
  });

  @override
  State<CustomButtonWidget> createState() => _CustomButtonWidgetState();
}

class _CustomButtonWidgetState extends State<CustomButtonWidget> {
  bool _isHovered = false;

  void _handleTap() {
    widget.onTap();
  }

  void _handleHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }

  @override
  Widget build(BuildContext context) {
    final containerColor = _isHovered ? widget.hoverColor : widget.initialColor;
    final textColor =
        _isHovered ? widget.hoverTextColor : widget.initialTextColor;
    final style = widget.textStyle.copyWith(color: textColor);
    return Container(
      width: widget.width,
      margin: const EdgeInsets.symmetric(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _handleTap,
          onHover: _handleHover,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: containerColor,
              border: Border.all(
                color: _isHovered
                    ? widget.hoverBorderColor ?? Colors.transparent
                    : widget.initialBorderColor ?? Colors.transparent,
              ),
            ),
            child: Text(
              widget.text,
              style: style,
            ),
          ),
        ),
      ),
    );
  }
}
