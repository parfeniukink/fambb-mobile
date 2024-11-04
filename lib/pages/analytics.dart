import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:fambb_mobile/widgets/section.dart';
import 'package:fambb_mobile/data/api.dart';
import 'package:fambb_mobile/data/analytics.dart';
import 'package:fambb_mobile/domain/services.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  ApiService api = ApiService();
  bool _isLoading = true;
  List<Analytics>? _currentMonthData;
  List<Analytics>? _previousMonthData;
  List<Analytics>? _customRangeData;

  // Date variables for the custom range
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchAnalyticsData();
  }

  Future<void> _fetchAnalyticsData({DateTime? start, DateTime? end}) async {
    final currentData = await api.fetchBasicAnalytics("current-month");
    final previousData = await api.fetchBasicAnalytics("previous-month");

    List<Analytics>? customData;
    if (start != null && end != null) {
      customData = await api.fetchBasicAnalyticsByRange(start, end);
    }
    if (mounted) {
      setState(() {
        _currentMonthData = currentData;
        _previousMonthData = previousData;
        _customRangeData = customData;
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshPageState() async {
    setState(() {
      _isLoading = true;
    });
    await _fetchAnalyticsData();
  }

  Widget buildAnalyticsSection(String title, List<Analytics> data) {
    return Section(
      border: 3,
      title: title,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: data.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${entry.currency.name} (${entry.currency.sign})",
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 20),
                  Text("Costs: ${formatAmount(entry.costs.total)}"),
                  Text("Incomes: ${formatAmount(entry.incomes.total)}"),
                  Text("From Exchanges: ${formatAmount(entry.fromExchanges)}"),
                  Text("Total Ratio: ${formatAmount(entry.totalRatio)}%"),
                  const SizedBox(height: 20),
                  ...entry.costs.categories.map((category) => Text(
                        "${category.name}: ${formatAmount(category.total)} (${category.ratio}%)",
                      )),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget buildDateRangePicker() {
    return Section(
      title: "📅 Selective Analytics",
      border: 3,
      child: Column(
        children: [
          const Text("select start date"),
          SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              initialDateTime: _startDate,
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDate) {
                setState(() {
                  _startDate = newDate;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          const Text("select end date"),
          SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              initialDateTime: _endDate,
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDate) {
                setState(() {
                  _endDate = newDate;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          CupertinoButton(
            child: const Text("fetch analytics"),
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });
              await _fetchAnalyticsData(start: _startDate, end: _endDate);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            CupertinoSliverRefreshControl(onRefresh: _refreshPageState),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                    child: _isLoading
                        ? const Center(child: CupertinoActivityIndicator())
                        : Column(
                            children: [
                              buildAnalyticsSection(
                                  "📊 Current Month Analytics",
                                  _currentMonthData!),
                              const SizedBox(height: 20),
                              buildAnalyticsSection(
                                  "📊 Previous Month Analytics",
                                  _previousMonthData!),
                              const SizedBox(height: 20),
                              buildDateRangePicker(),
                              const SizedBox(height: 20),
                              if (_customRangeData != null)
                                buildAnalyticsSection(
                                    "📊 Custom Range Analytics ${formatter.format(_startDate)}..${formatter.format(_endDate)}",
                                    _customRangeData!),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
