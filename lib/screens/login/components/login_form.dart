import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//////// import of config files ////////
import '../../../configs/size_config.dart';
import '../../../form_validation/error_dialog.dart';
import '../../../form_validation/form_validators.dart';
//////// import of other screens, widgets ////////
import '../../../models/http_exception.dart';
import '../../../providers/auth_provider.dart';
import '../../../widgets/default_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? password;
  String? confirmPassword;
  final _passwordController = TextEditingController();
  var _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      bool loginSuccess = await Provider.of<AuthProvider>(
        context,
        listen: false,
      ).login(
        email,
        password,
      );
      if (loginSuccess) {
        Navigator.of(context).pop();
      }
    } on HttpException catch (error) {
      ErrorDialog.showErrorDialog(context, error.toString());
    } catch (error) {
      print(error);
      ErrorDialog.showErrorDialog(
          context, 'Login Failed. Please try again later.');
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          emailOrPhoneField(),
          sized_box,
          passwordField(),
          sized_box,
          if (_isLoading)
            CircularProgressIndicator()
          else
            DefaultButton(
              text: "Login",
              onPressed: _submit,
            )
        ],
      ),
    );
  }

/////////////////////////////////////
  var sized_box = SizedBox(height: SizeConfig.screenHeight * 0.02);
////////////email or phone form field
  TextFormField emailOrPhoneField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) => email = value,
      validator: (value) => FormValidators.emailOrPhoneValidator(value),
      decoration: InputDecoration(
        labelText: "Email/Phone",
        // hintText: "Enter your email/phone",
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField passwordField() {
    return TextFormField(
      obscureText: true,
      controller: _passwordController,
      onSaved: (value) => password = value,
      validator: (value) => FormValidators.passwordValidator(value),
      decoration: InputDecoration(
        labelText: "Password",
        // hintText: "Enter password",
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
