import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFun, this.registerUser);

  final void Function(
    String username,
    String password,
    String role,
  ) submitFun;

  final void Function(
    String username,
    String password,
    String role,
  ) registerUser;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _islogin = true;
  String _role = '';
  String _userPassword = '';
  String _userName = '';
  void _trySubmit(bool buttons) {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      FocusScope.of(context).unfocus();
      buttons
          ? widget.submitFun(
              _userName.trim(), _userPassword.trim(), _role.trim())
          : widget.registerUser(
              _userName.trim(), _userPassword.trim(), _role.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      key: const ValueKey('username'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'Please enter at least 4 characters.';
                        } else {
                          return null;
                        }
                      },
                      // keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'username',
                        icon: Icon(Icons.supervised_user_circle),
                      ),
                      onSaved: (value) {
                        _userName = value as String;
                      },
                    ),
                    if (!_islogin)
                      TextFormField(
                        key: const ValueKey('Role'),
                        decoration: const InputDecoration(
                          labelText: 'Role',
                          icon: Icon(Icons.person),
                        ),
                        onSaved: (value) {
                          _role = value as String;
                        },
                      ),
                    TextFormField(
                      key: const ValueKey('password'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return 'Please must be at least 7 charcters';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        icon: Icon(Icons.key),
                      ),
                      onSaved: (value) {
                        _userPassword = value as String;
                      },
                      obscureText: true,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _islogin
                          ? () {
                              _trySubmit(true);
                            }
                          : () {
                              _trySubmit(false);
                            },
                      child: Text(_islogin ? 'Login' : 'Signup'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          primary: Theme.of(context).primaryColor),
                      onPressed: () {
                        setState(() {
                          _islogin = !_islogin;
                        });
                      },
                      child: Text(_islogin
                          ? 'Create new account'
                          : 'I already have an account'),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
