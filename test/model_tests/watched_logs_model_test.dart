import 'package:flutter_test/flutter_test.dart';
import 'package:mukuru_app/models/watched_logs_model.dart';

void main() {
  group('watched logs model', () {
    test('watchedLogsModelResponseToJson', () async {
      var watchedLogs = WatchedLogsModel(
        checkedAt: DateTime.tryParse('2021-12-08T17:42:58.000000Z'),
        rate: 22,
        minimumRate: 20,
      );
      var refinedCurrencyString = watchedLogsModelToJson(watchedLogs);
      expect(refinedCurrencyString.contains('22'), true);
    });
  });
}
