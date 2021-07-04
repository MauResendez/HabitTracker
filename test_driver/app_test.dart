import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Habit Tracker App - ', () 
  {
    FlutterDriver driver;

    setUpAll(() async 
    {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async 
    {
      if (driver != null) 
      {
        driver.close();
      }
    });
    group("Habit Tracker Functionality", () 
    {
      test("should be able to log into existing user", () async 
      {
        //  click on User entey
        final usertnFinder = find.byValueKey('user-textfield');
        await driver.tap(usertnFinder);
        //  enter email
        await driver.enterText('test@gmail.com');
        //  check in user passward
        final pwrdtnFinder = find.byValueKey('pwrd-textfield');
        await driver.tap(pwrdtnFinder);
        //  enter password
        await driver.enterText('12345678');
        //  hit log in
        final loginFinder = find.byValueKey('login-button');
        await driver.tap(loginFinder);
      });
      
      test("Move around the application", () async 
      {
        await Future.delayed(const Duration(seconds: 3), (){});
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
        await driver.tap(find.text('List'));
        print('clicked on second');
      });
      test("Go to list page and create a habit", () async 
      {
        final floatingActionButton = find.byValueKey('AddButton');

        // Go into the create page
        await driver.tap(floatingActionButton);

        final habitTitle = find.byValueKey('HabitTitle');
        final timerType = find.byValueKey('TimerType');
        final monday = find.byValueKey('Monday');
        final thursday = find.byValueKey('Thursday');
        final sunday = find.byValueKey('Sunday');
        final yellow = find.byValueKey('Yellow');
        final add = find.byValueKey('Add');

        // Enter HabitTitle
        await driver.tap(habitTitle);
        await driver.enterText('Test 1');

        // Enter habit type
        await driver.tap(timerType);

        // Enter days for the habit to show up
        await driver.tap(monday);
        await driver.tap(thursday);
        await driver.scrollIntoView(sunday);
        await driver.tap(sunday);

        // Enter LED Color

        await driver.tap(yellow);

        // Add the habit

        await driver.tap(add);
      });
      test("Go to list page and edit a habit", () async 
      {
        //  move into main habit page
        //  move into the habit page
        //  move into the calender page
        //  move into the profil page
        //  return to the main habit page
      });
      test("Delete created habit in the habit page", () async 
      {
        //  move into main habit page
        //  move into the habit page
        //  move into the calender page
        //  move into the profil page
        //  return to the main habit page
      });
    });
  });
}
