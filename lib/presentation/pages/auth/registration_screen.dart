import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name, _email, _password, _photoUrl;
  int _age;

  // Метод для загрузки фото профиля
  void _pickImage() async {
    // Логика для выбора и загрузки изображения
  }

  // Метод для регистрации
  void _register() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // Логика для регистрации пользователя и сохранения данных в Firestore
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Регистрация'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Имя'),
              validator: (value) => value.isEmpty ? 'Введите имя' : null,
              onSaved: (value) => _name = value,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Возраст'),
              keyboardType: TextInputType.number,
              validator: (value) => value.isEmpty ? 'Введите возраст' : null,
              onSaved: (value) => _age = int.parse(value),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) =>
                  !value.contains('@') ? 'Введите корректный email' : null,
              onSaved: (value) => _email = value,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Пароль'),
              obscureText: true,
              validator: (value) => value.length < 6
                  ? 'Пароль должен быть не менее 6 символов'
                  : null,
              onSaved: (value) => _password = value,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: Text('Зарегистрироваться'),
            ),
          ],
        ),
      ),
    );
  }
}
