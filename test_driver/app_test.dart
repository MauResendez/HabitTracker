import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('habittracker App - ', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    group("HAPPY TESTING", () {
      test("should be able to log into existing user", () async {
        //click on User entey
        final usertnFinder = find.byValueKey('user-textfield');
        await driver.tap(usertnFinder);
        //enter email
        await driver.enterText('salinas772089@yahoo.com');
        //check in user passward
        final pwrdtnFinder = find.byValueKey('pwrd-textfield');
        await driver.tap(pwrdtnFinder);
        //enter password
        await driver.enterText('1Likecookies');
        //hit log in
        //move into profile page
        //move into main habit page
        //move into habits page
        //move into summary page
        //move into calender page
      });
    });
  });

  test("should be able to log into existing user", () async {
    //move into main habit page
    //click on log out
    //re-enter username
    //re-enter password
    //hit log in
    //
  });
}
