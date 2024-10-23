import 'package:flutter/cupertino.dart';
import 'package:fambb_mobile/widgets/section.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: buildPage(),
        ),
      ),
    );
  }

  Widget buildPage() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Section(
          border: 3,
          title: "🔧 Settings",
          child: Row(
            children: [
              Center(child: Text("🚧 Work in progress")),
            ],
          ),
        )
      ],
    );
  }
}
