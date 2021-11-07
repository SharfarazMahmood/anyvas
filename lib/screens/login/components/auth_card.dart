import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/http_exception.dart';
import '../../../providers/auth_provider.dart';
import '../../../form_validation/error_dialog.dart';
import '../../../form_validation/form_validators.dart';

enum AuthMode {
  Signup,
  Login,
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

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
      if (_authMode == AuthMode.Login) {
        // Log user in
        bool loginSuccess =
            await Provider.of<AuthProvider>(context, listen: false).login(
          _authData['email'],
          _authData['password'],
        );
        if (loginSuccess) {
          Navigator.of(context).pop();
        }
      }
    } on HttpException catch (error) {
      ErrorDialog.showErrorDialog(context, error.toString());
    } catch (error) {
      print(error);
      ErrorDialog.showErrorDialog(
          context, 'Could not authenticate. Please try again later.');
    }
    setState(() {
      _isLoading = false;
    });
  }

  // void _switchAuthMode() {
  //   if (_authMode == AuthMode.Login) {
  //     setState(() {
  //       _authMode = AuthMode.Signup;
  //     });
  //   } else {
  //     setState(() {
  //       _authMode = AuthMode.Login;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      color: Color(0xff001a41),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 12.0,
      child: Container(
        constraints: BoxConstraints(),
        width: deviceSize.width < 600
            ? deviceSize.width * 0.80
            : deviceSize.width > 900
                ? deviceSize.width * 0.30
                : deviceSize.width * 20,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Phone or Email',
                    hintText: "",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      FormValidators.emailOrPhoneValidator(value),
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                   validator: (value) => FormValidators.passwordValidator(value),
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
                SizedBox(height: 20),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    child:
                        Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                      textStyle: TextStyle(
                        color: Theme.of(context).primaryTextTheme.button!.color,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
