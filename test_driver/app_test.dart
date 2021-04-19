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
    group("Habit Tracker UX", () {
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
        final loginFinder = find.byValueKey('login-button');
        await driver.tap(loginFinder);
        //move into profile page
        //click on the complete button
      });
      test("move around the application", () async {
        //move into main habit page
        //move into the habit page
        //move into the calender page
        //move into the profil page
        //return to the main habit page
      });
      test("move to habit page and create a habit", () async {
        //move into main habit page
        //move into the habit page
        //move into the calender page
        //move into the profil page
        //return to the main habit page
      });
      test("delete created habit in the habit page", () async {
        //move into main habit page
        //move into the habit page
        //move into the calender page
        //move into the profil page
        //return to the main habit page
      });
    });
  });
}
