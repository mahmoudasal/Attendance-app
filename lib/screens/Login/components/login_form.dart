import 'package:flutter/material.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';
import '../../navbar.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordInVisible = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: InputDecoration(
              hintText: "Your UserName",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(20),
                child: Icon(Icons.person),
              ),
            ),
            validator: (mailCurrentValue) {
              var mailNonNullValue = mailCurrentValue ?? "";
              if (mailNonNullValue.isEmpty) {
                return ("UserName is required");
              } else if (mailNonNullValue.length < 4) {
                return ("UserName Must be more than 4 characters");
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(),
            child: TextFormField(
              controller: passwordController,
              obscureText: _passwordInVisible,
              textInputAction: TextInputAction.done,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(20),
                  child: Icon(Icons.lock),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _passwordInVisible = !_passwordInVisible;
                    });
                  },
                  child: Icon(_passwordInVisible ? Icons.visibility_off : Icons.visibility),
                ),
              ),
              validator: (PassCurrentValue) {
                var passNonNullValue = PassCurrentValue ?? "";
                if (passNonNullValue.isEmpty) {
                  return ("Password is required");
                } else if (passNonNullValue.length < 6) {
                  return ("Password Must be more than 5 characters");
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) {
                        return NavigatorScreen();
                      },
                    ),
                  );
                }
              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
