import 'package:flutter/material.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';
import '../../attendance.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
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
              hintText: "Your email",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(20),
                child: Icon(Icons.person),
              ),
            ),
            validator: (mailCurrentValue) {
              var mailNonNullValue = mailCurrentValue ?? "";
              if (mailNonNullValue.isEmpty) {
                return ("Email is required");
              } else if (mailNonNullValue.length < 4) {
                return ("Email Must be more than 4 characters");
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
                  padding: const EdgeInsets.all(20),
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
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return DataTableExample();
                    },
                  ),
                );
              }
            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: 20),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
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
