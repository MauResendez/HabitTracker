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
        // final completeFInder = find.byValueKey('complete-button');
        // await driver.tap(completeFInder);
      });
      
      test("move around the application", () async 
      {
        await Future.delayed(const Duration(seconds: 5), (){});
        // final itemscreen = find.byValueKey('items');
        // await driver.tap(itemscreen);
        await driver.waitFor(find.byValueKey('BNB'));
        await driver.tap(find.text('Home'));
        print('clicked on first');
        await Future.delayed(const Duration(seconds: 3), (){});
        await driver.tap(find.text('List'));
        print('clicked on second too');
        await Future.delayed(const Duration(seconds: 3), (){});
        await driver.tap(find.text('Summary'));
        print('clicked on third too');
        await Future.delayed(const Duration(seconds: 3), (){});
        await driver.tap(find.text('Calendar'));
        print('clicked on fourth too');
        await Future.delayed(const Duration(seconds: 3), (){});
        await driver.tap(find.text('Profile'));
        print('clicked on fifth too');
        await Future.delayed(const Duration(seconds: 3), (){});
        await driver.tap(find.text('Home'));
        print('clicked on first');
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
