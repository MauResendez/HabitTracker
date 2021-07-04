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
      test("Logging into existing user", () async 
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
      
      test("- Move around the application", () async 
      {
        await Future.delayed(const Duration(seconds: 3), (){});
        await driver.waitFor(find.byValueKey('BNB'));
        await driver.tap(find.text('Home'));
        print('Clicked on First');
        await Future.delayed(const Duration(seconds: 3), (){});
        await driver.tap(find.text('List'));
        print('Clicked on Second');
        await Future.delayed(const Duration(seconds: 3), (){});
        await driver.tap(find.text('Summary'));
        print('Clicked on Third');
        await Future.delayed(const Duration(seconds: 3), (){});
        await driver.tap(find.text('Calendar'));
        print('Clicked on Fourth');
        await Future.delayed(const Duration(seconds: 3), (){});
        await driver.tap(find.text('Profile'));
        print('Clicked on Fifth');
        await Future.delayed(const Duration(seconds: 3), (){});
        await driver.tap(find.text('List'));
        print('Clicked on Second');
      });
      test("- Create a habit", () async 
      {
        final floatingActionButton = find.byValueKey('AddButton');

        // Go into the create page
        await driver.tap(floatingActionButton);

        final habitTitle = find.byValueKey('HabitTitle');
        final timerType = find.byValueKey('TimerType');
        final monday = find.byValueKey('Monday');
        final thursday = find.byValueKey('Thursday');
        final saturday = find.byValueKey('Saturday');
        final sunday = find.byValueKey('Sunday');
        final yellow = find.byValueKey('Yellow');
        final add = find.byValueKey('Add');

        // Enter HabitTitle
        await driver.tap(habitTitle);
        await driver.enterText('Test 1');
        print('Typed in the Habit Title');
        await Future.delayed(const Duration(seconds: 3), (){});

        // Enter habit type
        await driver.tap(timerType);
        print('Clicked on a Habit Type');
        await Future.delayed(const Duration(seconds: 3), (){});

        // Enter days for the habit to show up
        await driver.tap(monday);        
        await Future.delayed(const Duration(seconds: 3), (){});
        await driver.tap(thursday);
        await Future.delayed(const Duration(seconds: 3), (){});
        await driver.scrollIntoView(saturday);
        await Future.delayed(const Duration(seconds: 3), (){});
        await driver.tap(sunday);
        print('Clicked on Monday, Thursday, Sunday');
        await Future.delayed(const Duration(seconds: 3), (){});

        // Enter LED Color

        await driver.tap(yellow);
        print('Clicked on Yellow for LED Color');
        await Future.delayed(const Duration(seconds: 3), (){});

        // Add the habit

        await driver.tap(add);
        print('Clicked on Add Button');
        await Future.delayed(const Duration(seconds: 3), (){});
      });
      test("- Edit a habit", () async 
      {
        await driver.waitFor(find.byValueKey('BNB'));
        await Future.delayed(const Duration(seconds: 3), (){});
        print('Found the bottom navigation bar');
        await driver.tap(find.text('List'));
        await Future.delayed(const Duration(seconds: 3), (){});
        print('Clicked on Second');

        // Delete the first habit created

        final editButton = find.byValueKey('EditButton0');

        await driver.tap(editButton);

        final habitTitle = find.byValueKey('HabitTitle');
        final defaultType = find.byValueKey('DefaultType');
        final monday = find.byValueKey('Monday');
        final thursday = find.byValueKey('Thursday');
        final sunday = find.byValueKey('Sunday');
        final tuesday = find.byValueKey('Tuesday');
        final saturday = find.byValueKey('Saturday');
        final blue = find.byValueKey('Blue');
        final edit = find.byValueKey('Edit');

        // Enter HabitTitle
        await driver.tap(habitTitle);
        await driver.enterText('Remade Test 1');
        print('Typed in the Habit Title');
        await Future.delayed(const Duration(seconds: 3), (){});

        // Enter habit type
        await driver.tap(defaultType);
        print('Clicked on a Habit Type');
        await Future.delayed(const Duration(seconds: 3), (){});

        // Enter days for the habit to show up
        await driver.tap(monday);        
        await Future.delayed(const Duration(seconds: 3), (){});
        await driver.tap(thursday);
        await Future.delayed(const Duration(seconds: 3), (){});
        await driver.scrollIntoView(saturday);
        await Future.delayed(const Duration(seconds: 3), (){});
        await driver.tap(sunday);
        await Future.delayed(const Duration(seconds: 3), (){});
        await driver.tap(tuesday);
        await Future.delayed(const Duration(seconds: 3), (){});
        await driver.tap(saturday);
        print('Clicked off Monday, Thursday, Sunday and clicked on Tuesday and Saturday');
        await Future.delayed(const Duration(seconds: 3), (){});

        // Enter LED Color

        await driver.tap(blue);
        print('Clicked on Blue for LED Color');
        await Future.delayed(const Duration(seconds: 3), (){});

        // Add the habit

        await driver.tap(edit);
        print('Clicked on Edit Button');
        await Future.delayed(const Duration(seconds: 3), (){});
        });
      });
      test(" - Delete created habit in the list page", () async 
      {
        await driver.waitFor(find.byValueKey('BNB'));
        await Future.delayed(const Duration(seconds: 3), (){});
        print('Found the bottom navigation bar');
        await driver.tap(find.text('List'));
        await Future.delayed(const Duration(seconds: 3), (){});
        print('Clicked on Second');

        // Delete the first habit created

        final deleteButton = find.byValueKey('DeleteButton0');

        await driver.tap(deleteButton);
        await Future.delayed(const Duration(seconds: 3), (){});
        print("Clicked on first 'habit's' delete button");
    });
  });
}
