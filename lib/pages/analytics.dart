import 'package:flutter/cupertino.dart';

import 'package:fambb_mobile/widgets/section.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  late bool _isLoading = false;

  Widget buildPage() {
    return _isLoading
        ? const Center(
            child: CupertinoActivityIndicator(),
          )
        : const Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Section(
                border: 3,
                title: "📊 Basic Analytics",
                child: Row(children: [
                  Center(child: Text("🚧 Work in progress"))
                ]))
          ]);
  }

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
}
