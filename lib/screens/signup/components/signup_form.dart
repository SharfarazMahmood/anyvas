import 'package:flutter/material.dart';
//////// import of config files ////////
import '../../../configs/size_config.dart';
import '../../../form_validation/error_dialog.dart';
import '../../../form_validation/form_validators.dart';
//////// import of other screens, widgets ////////
import '../../../models/http_exception.dart';
import '../../../widgets/default_button.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? password;
  String? confirmPassword;
  String _enteredPhone = "";
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
      // bool loginSuccess = await Provider.of<AuthProvider>(
      //   context,
      //   listen: false,
      // ).login(
      //   email,
      //   password,
      // );
      // if (loginSuccess) {
      //   Navigator.of(context).pop();
      // }
    } on HttpException catch (error) {
      ErrorDialog.showErrorDialog(context, error.toString());
    } catch (error) {
      print(error);
      ErrorDialog.showErrorDialog(
          context, 'Registration Failed. Please try again later.');
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
          firstNameField(),
          sized_box,
          lastNameField(),
          sized_box,
          emailOrPhoneField(),
          sized_box,
          phoneNumberField(),
          sized_box,
          passwordField(),
          sized_box,
          confirmPasswordField(),
          sized_box,
          if (_isLoading)
            CircularProgressIndicator()
          else
            DefaultButton(
              text: "Sign up",
              onPressed: _submit,
            )
        ],
      ),
    );
  }

  //////////////////////////////////////
  var sized_box = SizedBox(height: SizeConfig.screenHeight * 0.03);
  //////////// first name field
  TextFormField firstNameField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (value) => email = value,
      validator: (value) => FormValidators.nameValidator(value),
      decoration: InputDecoration(
        labelText: "First name",
        // hintText: "Enter a first name",
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  //////////// last name field
  TextFormField lastNameField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (value) => email = value,
      validator: (value) => FormValidators.nameValidator(value),
      decoration: InputDecoration(
        labelText: "Last name",
        // hintText: "Enter a last name",
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  ////////////email or phone form field
  TextFormField emailOrPhoneField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) => email = value,
      validator: (value) => FormValidators.emailValidator(value),
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter an email",
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  /////// phone field
  TextFormField phoneNumberField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (value) => password = value,
      validator: (value) => FormValidators.phoneValidator(value),
      onChanged: (value) {
        setState(() {
          _enteredPhone = value;
        });
      },
      decoration: InputDecoration(
        prefix: Container(
          child: Text('+88', style: TextStyle(color: Colors.black)),
        ),
        suffix: Container(
          child: Text(
            _enteredPhone.length > 0
                ? '${_enteredPhone.length.toString()}'
                : "",
            style: TextStyle(
              color: _enteredPhone.length == 11 ? Colors.black : Colors.red,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        labelText: "Phone",
        // hintText: "Enter a phone number",
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

//////////// password form field
  TextFormField passwordField() {
    return TextFormField(
      obscureText: true,
      controller: _passwordController,
      onSaved: (value) => password = value,
      validator: (value) => FormValidators.passwordValidator(value),
      decoration: InputDecoration(
        labelText: "Password",
        // hintText: "Enter a password",
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  /////// confirm password field
  TextFormField confirmPasswordField() {
    return TextFormField(
      obscureText: true,
      onSaved: (value) => password = value,
      validator: (value) => FormValidators.confirmPasswordValidator(value),
      decoration: InputDecoration(
        labelText: "Confirm Password",
        // hintText: "Re-enter password",
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}

///
///
