import 'package:authenticate/bolc/login_bloc.dart';
import 'package:authenticate/model/user.dart';
import 'package:authenticate/res/string_values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _userTextEditingController;
  late TextEditingController _passTextEditingController;
  @override
  void initState() {
    _userTextEditingController = TextEditingController();
    _passTextEditingController = TextEditingController();
    super.initState();
  }

  final _loginBloc = LoginBloc();
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<UserState>(
      builder: (context, userState, _) => Center(
        child: Card(
            elevation: 8.0,
            margin: const EdgeInsets.symmetric(horizontal: 32.0),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder<String>(
                      stream: _loginBloc.userStream,
                      builder: (context, snapshot) {
                        String? txtError;
                        Color border = Colors.blue;
                        if (snapshot.error.toString().isEmpty ||
                            snapshot.error.toString().compareTo('null') == 0) {
                          border = Colors.blue;
                          txtError = null;
                        } else {
                          txtError = snapshot.error.toString();
                          border = Colors.red;
                        }
                        return TextFormField(
                          enabled: !userState.isLoadingUser,
                          decoration: InputDecoration(
                            errorText: txtError,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: border),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                            ),
                            labelText: user,
                          ),
                          maxLines: 1,
                          onChanged: _loginBloc.changeUser,
                          controller: _userTextEditingController,
                        );
                      }),
                  const SizedBox(
                    height: 20.0,
                  ),
                  StreamBuilder<String>(
                      stream: _loginBloc.passwordStream,
                      builder: (context, snapshot) {
                        String? txtError;
                        Color border = Colors.blue;
                        if (snapshot.error.toString().isEmpty ||
                            snapshot.error.toString().compareTo('null') == 0) {
                          border = Colors.blue;
                          txtError = null;
                        } else {
                          txtError = snapshot.error.toString();
                          border = Colors.red;
                        }
                        return TextFormField(
                          enabled: !userState.isLoadingUser,
                          decoration: InputDecoration(
                              errorText: txtError,
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: border),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: border),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                              ),
                              labelText: pass,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: border,
                                  ))),
                          maxLines: 1,
                          obscureText: _passwordVisible,
                          onChanged: _loginBloc.changePassword,
                          controller: _passTextEditingController,
                        );
                      }),
                  SizedBox.fromSize(
                    size: const Size.fromHeight(20.0),
                  ),
                  StreamBuilder<bool>(
                    stream: _loginBloc.submitValid,
                    builder: (context, snapshot) => TextButton(
                      onPressed: () async {
                        if (snapshot.hasData) {
                          context.read<UserState>().checkUser(
                              context,
                              _passTextEditingController.text,
                              _userTextEditingController.text);
                        }
                      },
                      child: userState.isLoadingUser
                          ? const CircularProgressIndicator()
                          : const Text(login),
                    ),
                  ),
                ],
              ),
            )),
      ),
    ));
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}
