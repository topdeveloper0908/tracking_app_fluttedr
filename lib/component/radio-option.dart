import 'package:flutter/material.dart';

class MyRadioOption<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final String label;
  final String text;
  final ValueChanged<T?> onChanged;

  const MyRadioOption({
    required this.value,
    required this.groupValue,
    required this.label,
    required this.text,
    required this.onChanged,
  });

  Widget _buildLabel() {
    final bool isSelected = value == groupValue;

    return Container(
      width: 25,
      height: 25,
      decoration: ShapeDecoration(
        shape: CircleBorder(
          side: BorderSide(
            color: Color(0xFF2FB1A8),
            width: isSelected ? 8 : 13,
          ),
        ),
      ),
    );
  }

  Widget _buildText() {
    return Text(
      text,
      style: const TextStyle(color: Colors.black, fontSize: 18),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      child: InkWell(
        onTap: () => onChanged(value),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              _buildLabel(),
              const SizedBox(width: 4),
              _buildText(),
            ],
          ),
        ),
      ),
    );
  }
}
