import 'package:app/game_provider.dart';
import 'package:app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailFormPage extends StatelessWidget {
  UserDetailFormPage({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  onPressed(context) {
    if (!_formKey.currentState!.validate()) return;
    String name = _nameController.value.text;
    String gender = _genderController.value.text;
    Provider.of<GameProvider>(context, listen: false).init(name, gender);

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500, maxHeight: 250),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                  controller: _nameController,
                  decoration: const InputDecoration(hintText: "Your Name"),
                ),
                TextFormField(
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Please enter your pronouns";
                    }
                    return null;
                  },
                  controller: _genderController,
                  decoration:
                      const InputDecoration(hintText: "Your Gender/ Pronouns"),
                ),
                ElevatedButton(
                    onPressed: () => onPressed(context),
                    child: const Text("Start A Story"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
