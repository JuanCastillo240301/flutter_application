import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  
  const CustomCheckbox({this.value, this.onChanged});

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onChanged != null) {
          widget.onChanged!(!widget.value!);
        }
      },
      child: Container(
        width: 24,
        height: 24,
        
        child: widget.value!
            ? Image.asset(
                'assets/heart.png', // Ruta de la imagen personalizada
                color: Colors.white,
                width: 20,
                height: 20,
              )
            : Image.asset(
                'assets/heart-break.png', // Ruta de la imagen personalizada
                color: Colors.white,
                width: 20,
                height: 20,
              ),
      ),
    );
  }
}
