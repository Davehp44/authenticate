import 'dart:async';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final _userController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length >= 6) {
        sink.add(password);
      } else if (password.isNotEmpty && password.length < 6) {
        sink.addError('Password must have at least 6 characters');
      }
    },
  );

  final validateUserName = StreamTransformer<String, String>.fromHandlers(
    handleData: (user, sink) {
      if (user.length >= 4) {
        sink.add(user);
      } else if (user.isNotEmpty && user.length < 4) {
        sink.addError('User name must have at least 4 characters');
      }
    },
  );

  // Getters para obtener los Streams y las funciones para cambiar los valores
  Stream<String> get userStream =>
      _userController.stream.transform(validateUserName);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);
  Stream<bool> get submitValid => Rx.combineLatest2(
      _userController.stream.transform(validateUserName),
      _passwordController.stream.transform(validatePassword),
      (user, pass) => true);

  Function(String) get changeUser => _userController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  void dispose() {
    _userController.close();
    _passwordController.close();
  }
}
