// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MiEstado extends ChangeNotifier {
  // Agregar ChangeNotifier para notificar los cambios en el estado
  int _valor = 0;

  int get valor => _valor;

  set valor(int valor) {
    _valor = valor;
    notifyListeners(); // Notificar los cambios en el estado
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final miEstado = Provider.of<MiEstado>(context);
    return Text('El valor es: ${miEstado.valor}', key: const Key('myWidgetText'));
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  test('Debe guardar y obtener un valor de SharedPreferences', () async {
    // Crear una instancia de SharedPreferences y guardar un valor
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('nombre', 'Juan');

    // Obtener el valor guardado y verificar si es correcto
    final nombre = preferences.getString('nombre');
    expect(nombre, 'Juan');
    // Obtener el valor guardado y verificar no es correcto
    expect(nombre, isNot('Pepe'));
  });

testWidgets('Debe mostrar el valor correcto del estado global',
      (WidgetTester tester) async {
    // Crear una instancia del estado global MiEstado
    final miEstado = MiEstado();
    miEstado.valor = 5;

    // Montar el widget MyWidget con el estado global MiEstado
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MiEstado>.value(value: miEstado),
        ],
        child: const MaterialApp(
          home: MyWidget(),
        ),
      ),
    );

    // Verificar que el widget MyWidget muestra el valor correcto del estado global
    expect(find.byKey(const Key('myWidgetText')), findsOneWidget);

    // Actualizar el estado global y forzar al widget MyWidget a reconstruirse
    miEstado.valor = 10;
    await tester.pumpAndSettle();

    // Verificar que el widget MyWidget muestra el nuevo valor del estado global
    expect(find.text('El valor es: 10'), findsOneWidget);
  });
}
