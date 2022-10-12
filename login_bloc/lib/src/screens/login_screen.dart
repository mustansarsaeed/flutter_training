import 'package:flutter/material.dart';
import '../blocs/bloc.dart';

class LoginScreen extends StatelessWidget {
  Widget build(context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          emailField(),
          passwordField(),
          Container(
            margin: EdgeInsets.only(top: 20.0),
          ),
          submitButton(),
        ],
      ),
    );
  }

  Widget emailField() {
    return StreamBuilder(
        stream: bloc.email,
        builder: ((context, snapshot) {
          return TextField(
            onChanged: bloc.changeEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email:',
              hintText: 'abc@gmail.com',
              errorText: '${snapshot.error ?? ""}',
            ),
          );
        }));
  }

  Widget passwordField() {
    return StreamBuilder(
        stream: bloc.password,
        builder: (context, snapshot) {
          return TextField(
            obscureText: true,
            decoration: InputDecoration(
                labelText: 'Password:',
                hintText: 'Password',
                errorText: '${snapshot.error ?? ''}'),
            onChanged: bloc.changePassword,
          );
        });
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {},
      child: Text('Submit'),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    );
  }
}
