import 'package:flutter/material.dart';

class CustomButtonWidget extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final Color? initialColor;
  final Color initialTextColor;
  final Color? hoverColor;
  final Color hoverTextColor;
  final Gradient? initialGradient;
  final Gradient? hoverGradient;
  final Color? initialBorderColor;
  final Color? hoverBorderColor;
  final double? width;
  final VoidCallback onTap;

  const CustomButtonWidget({
    super.key,
    required this.text,
    required this.textStyle,
    this.initialColor,
    required this.initialTextColor,
    this.hoverColor,
    required this.hoverTextColor,
    this.initialGradient,
    this.hoverGradient,
    this.width,
    required this.onTap,
    this.initialBorderColor,
    this.hoverBorderColor,
  }) : assert(initialColor != null || initialGradient != null,
            'Either initialColor or initialGradient must be provided');

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
    final textStyle = widget.textStyle.copyWith(color: textColor);
    final gradient = _isHovered
        ? widget.hoverGradient ?? widget.initialGradient
        : widget.initialGradient;

    return Container(
      width: widget.width,
      padding: const EdgeInsets.symmetric(vertical: 16),
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
              color: gradient == null ? containerColor : null,
              gradient: gradient,
              border: Border.all(
                color: _isHovered
                    ? widget.hoverBorderColor ?? Colors.transparent
                    : widget.initialBorderColor ?? Colors.transparent,
              ),
            ),
            child: Text(
              widget.text,
              textAlign: TextAlign.center,
              style: textStyle,
            ),
          ),
        ),
      ),
    );
  }
}
