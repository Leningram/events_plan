import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name, _email, _password, _photoUrl;
  late int _age;
// Метод для регистрации
  void _register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Логика для регистрации пользователя и сохранения данных в Firestore
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(labelText: 'Имя'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Введите имя';
              }
              return null;
            },
            // onSaved: (value) => _name = value,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Возраст'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Введите возраст';
              }
              return null;
            },
            onSaved: (value) => _age = int.parse(value!),
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || !value.contains('@')) {
                return 'Введите корректный email';
              }
              return null;
            },
            onSaved: (value) => _email = value!,
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Пароль'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.length < 6) {
                return 'Пароль должен быть не менее 6 символов';
              }
              return null;
            },
            onSaved: (value) => _password = value!,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _register,
            child: const Text('Зарегистрироваться'),
          ),
        ],
      ),
    );
  }
}
