import 'package:flutter_news_app/utility/utilityClass.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('get difference between current days and article published date', () {
    //setup
    String publishedDate = "2020-09-18T18:53:08Z";

    //run
    int days = Utility.getDifferenceInDaysFromToday(publishedDate);

    //verify
    expect(
        days, DateTime.now().difference(DateTime.parse(publishedDate)).inDays);
  });

  test('format date', () {
    //setup
    String publishedDate = "2020-09-18T18:53:08Z";

    //run
    String formattedDate = Utility.getFormattedDate(publishedDate);

    //verify
    expect(formattedDate, "18 September 2020");
  });
}
