import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Form Application')),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset('images/3d_avatar_21.png', width: 100, height: 100),
              // Custom text fields for user input
              const CustomTextField(label: 'First Name'),
              const CustomTextField(label: 'Last Name'),
              const CustomTextField(
                  label: 'Email ID', suffixText: '@mlritm.ac.in'),
              const CustomTextField(
                prefixText: '+91 ',
                label: 'Mobile Number',
                keyboardType: TextInputType.phone,
                maxLength: 10,
              ),
              const Divider(indent: 8, endIndent: 8), // Divider
              const CustomTextField(label: 'Username'),
              const CustomTextField(label: 'Password', obscureText: true),
              const CustomTextField(label: 'Confirm Password'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.login),
                      label: const Text('Register'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom text field widget
class CustomTextField extends StatefulWidget {
  final String label;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? prefixText, suffixText;
  final int? maxLength;

  const CustomTextField({
    super.key,
    required this.label,
    this.keyboardType,
    this.suffixText,
    this.prefixText,
    this.maxLength,
    this.obscureText = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        obscureText: _obscureText,
        inputFormatters: widget.maxLength != null
            ? [LengthLimitingTextInputFormatter(widget.maxLength)]
            : null,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.label,
          suffixText: widget.suffixText,
          prefixText: widget.prefixText,
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility_outlined
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
