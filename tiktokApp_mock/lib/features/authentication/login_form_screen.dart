import 'package:TikTok/features/authentication/view_models/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:TikTok/constants/gaps.dart';
import 'package:TikTok/constants/sizes.dart';
import 'package:TikTok/features/authentication/widgets/form_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginFormScreen extends ConsumerStatefulWidget {
  const LoginFormScreen({super.key});

  @override
  ConsumerState<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends ConsumerState<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};
  bool _obscureText = true;

  // String? _isIdEmail(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return "Email is required";
  //   }
  //   final regExp = RegExp(
  //       r"^[a-zA-Z0-9!#$%^&*()_+\-={}|[\];':,./<>?]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  //   if (!regExp.hasMatch(value)) {
  //     return "Invalid email format.";
  //   }
  //   return null;
  // }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        ref
            .read(loginProvider.notifier)
            .login(formData["email"]!, formData["password"]!, context);
        // context.goNamed(InterestsScreen.routeName);
      }
    }
  }

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Log in"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size36,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Gaps.v28,
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1.5, color: Theme.of(context).primaryColor),
                    ),
                  ),
                  onSaved: (newValue) {
                    if (newValue != null) {
                      formData['email'] = newValue;
                    }
                  },
                ),
                Gaps.v16,
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: "Password",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1.5, color: Theme.of(context).primaryColor),
                    ),
                  ),
                  onSaved: (newValue) {
                    if (newValue != null) {
                      formData['password'] = newValue;
                    }
                  },
                ),
                Gaps.v28,
                GestureDetector(
                  onTap: _onSubmitTap,
                  child:
                      FormButton(disabled: ref.watch(loginProvider).isLoading),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
