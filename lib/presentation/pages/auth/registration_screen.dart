import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name, _email, _password, _photoUrl;
  DateTime? _birthDate;
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  final TextEditingController __birthDateController = TextEditingController();
  // Метод для выбора даты
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000), // Начальная дата
      firstDate: DateTime(1900), // Самая ранняя дата
      lastDate: DateTime.now(), // Самая поздняя дата
    );
    if (picked != null && picked != _birthDate) {
      setState(() {
        _birthDate = picked;
        __birthDateController.text = _dateFormat.format(_birthDate!);
      });
    }
  }

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
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: TextFormField(
                controller: __birthDateController,
                decoration: InputDecoration(
                  labelText: 'Дата рождения',
                  hintText: _birthDate == null
                      ? 'Выберите дату'
                      : _dateFormat.format(_birthDate!),
                ),
                validator: (value) =>
                    _birthDate == null ? 'Выберите дату рождения' : null,
              ),
            ),
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
