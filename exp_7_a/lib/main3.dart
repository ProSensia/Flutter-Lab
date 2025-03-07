import 'package:flutter/foundation.dart';
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
        body: const SafeArea(
          child: SingleChildScrollView(
            // SafeArea widget to avoid UI elements from being hidden by the device's notch, etc.
            child: RegisterForm(),
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  /* About TextEditingController:
   * https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
   */
  final List<TextEditingController> controllers = List.generate(
    7,
    (_) => TextEditingController(),
  );

  TextEditingController get _firstNameController       => controllers[0];
  TextEditingController get _lastNameController        => controllers[1];
  TextEditingController get _emailController           => controllers[2];
  TextEditingController get _phoneController           => controllers[3];
  TextEditingController get _usernameController        => controllers[4];
  TextEditingController get _passwordController        => controllers[5];
  TextEditingController get _confirmPasswordController => controllers[6];

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleSubmit() {
    if (kDebugMode) {
      print('''

    First Name: ${_firstNameController.text}
    Last Name: ${_lastNameController.text}
    Email: ${_emailController.text}@mlritm.ac.in
    Phone: +91 ${_phoneController.text}
    Username: ${_usernameController.text}
    Password: ${_passwordController.text}
    Confirm Password: ${_confirmPasswordController.text}
    ''');
    }
  }

  void _handleClear() {
    for (var controller in controllers) {
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset('images/3d_avatar_21.png', width: 100, height: 100),
        CustomTextField(controller: _firstNameController, label: 'First Name'),
        CustomTextField(controller: _lastNameController, label: 'Last Name'),
        CustomTextField(
            controller: _emailController,
            label: 'Email ID',
            suffixText: '@mlritm.ac.in'),
        CustomTextField(
          controller: _phoneController,
          prefixText: '+91 ',
          label: 'Mobile Number',
          keyboardType: TextInputType.phone,
          maxLength: 10,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9*]')),
            LengthLimitingTextInputFormatter(10)
          ],
        ),
        const Divider(indent: 8, endIndent: 8),
        CustomTextField(controller: _usernameController, label: 'Username'),
        CustomTextField(
            controller: _passwordController,
            label: 'Password',
            obscureText: true,
            passwordVisibilityToggle: false),
        CustomTextField(
            controller: _confirmPasswordController,
            label: 'Confirm Password',
            obscureText: true,
            passwordVisibilityToggle: true),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextButton(
                    onPressed: _handleClear, child: const Text('Clear')),
              ),
              FilledButton.icon(
                onPressed: _handleSubmit,
                icon: const Icon(Icons.login),
                label: const Text('Register'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController? controller; // Add controller
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? prefixText, suffixText;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final bool passwordVisibilityToggle;

  const CustomTextField({
    super.key,
    required this.label,
    this.controller, // Add controller
    this.keyboardType,
    this.suffixText,
    this.prefixText,
    this.maxLength,
    this.obscureText = false,
    this.passwordVisibilityToggle = false,
    this.inputFormatters,
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
        controller: widget.controller, // Add controller
        keyboardType: widget.keyboardType,
        obscureText: _obscureText,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.label,
          suffixText: widget.suffixText,
          prefixText: widget.prefixText,
          suffixIcon: widget.obscureText && widget.passwordVisibilityToggle
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
