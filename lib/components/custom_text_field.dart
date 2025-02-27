import "package:flutter/material.dart";

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.label,
    this.password = false,
    this.keyboardType,
    required this.onChanged,
    required TextEditingController controller,
    required String hint,
  });
  final String label;
  final bool password;
  final Function(String) onChanged;
  final TextInputType? keyboardType;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obsecure = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextField(
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          suffixIcon:
              widget.password
                  ? IconButton(
                    icon: Icon(
                      _obsecure ? Icons.visibility : Icons.visibility_off,
                      color: Colors.blue.shade400,
                    ),
                    onPressed: () {
                      setState(() {
                        _obsecure = !_obsecure;
                      });
                    },
                  )
                  : null,
          border: const OutlineInputBorder(borderSide: BorderSide(width: 1)),
          labelText: widget.label,
          labelStyle: const TextStyle(color: Colors.black),
        ),
        cursorColor: Colors.black,
        obscureText: widget.password ? _obsecure : false,
        onChanged: widget.onChanged,
      ),
    );
  }
}
