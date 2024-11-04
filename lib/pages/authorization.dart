// TODO: you finished with authorization page. you have updated
// the main.dart but didn't test it. you just added the `FlutterSecureStorage`. start
// from testing it. it is used to pass the data from place to place.

import 'package:fambb_mobile/widgets/popup.dart';
import 'package:flutter/cupertino.dart';

import 'package:fambb_mobile/data/api.dart';
import 'package:fambb_mobile/data/user.dart';
import 'package:fambb_mobile/widgets/section.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late String? secret;
  ApiService api = ApiService();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: buildPage(context),
        ),
      ),
    );
  }

  Widget buildPage(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 280),
        Section(
          border: 3,
          title: "🔑 Authorization",
          child: Column(
            children: [
              CupertinoTextField(
                placeholder: "secret",
                onChanged: (value) {
                  setState(() {
                    secret = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              CupertinoButton(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                color: CupertinoColors.activeBlue,
                onPressed: () async {
                  _storage.write(key: "userSecret", value: secret);
                  User? user = await api.fetchUser();

                  if (context.mounted && user == null) {
                    showPopup(context,
                        color: CupertinoColors.destructiveRed,
                        message: "Invalid secret");
                  } else {}
                },
                child: const Text(
                  "verify",
                  style: TextStyle(
                    color: CupertinoColors.white,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
