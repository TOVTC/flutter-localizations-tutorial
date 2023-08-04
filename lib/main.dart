import 'package:flutter/material.dart';
// import localizations
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // onGenerateTitle is a callback function that dynamically generates the app's title based on the current BuildContext
        // The title property is a static property that sets a fixed title for the entire app and does not change dynamically based on the context or state
        onGenerateTitle: (context) => AppLocalizations.of(context)!.title,

        // this provides manual localizationDelegates and supportedLocales
        // localizationsDelegates: const [
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        // supportedLocales: const [
        //   Locale('en'),
        //   Locale('es'),
        // ],

        // but after improting gen_l10n/app_localizations, you can use this syntax to automatically list localizationDelegates and supportedLocales
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Localizations Sample App'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? _gender;
    // List<String> dropdownItems = AppLocalizations.of(context)!.genders.split(":");
    // List<DropdownMenuItem<String>> items = [];
    // Map<String, String> genderList = {
    //   'male': dropdownItems[0],
    //   'female': dropdownItems[1],
    //   'other': dropdownItems[2]
    // };
    
    // void listItems () {
    //   setState(() {
    //   for (var item in genderList.entries) {
    //     items.add(DropdownMenuItem<String>(
    //       value: item.key,
    //       child: Text(item.value),
    //     ));
    //   }
    //   });
    // }

    // listItems();

    void changeGender(gender) {
                setState(() {
                  _gender = gender!;
                  print(_gender);
                });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // the locale will automatically change text depending on device settings
        title: Text(AppLocalizations.of(context)!.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // example of passed parameter
            Text(AppLocalizations.of(context)!.hello('Cid')),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            // example of pluralization
            Text(
                '${AppLocalizations.of(context)!.counterSentence} ${AppLocalizations.of(context)!.nClicks(_counter)}'),
            DropdownButton(
              value: _gender,
              onChanged: (gender) {
                changeGender(gender);
              },
              // items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
              //   return DropdownMenuItem<String>(
              //     value: value,
              //     child: Text(value),
              //   );
              // }).toList(),
              // items: [
              //   DropdownMenuItem<String>(
              //     value: 'male',
              //     child: Text(dropdownItems[0]),
              //   ),
              //   DropdownMenuItem<String>(
              //     value: 'female',
              //     child: Text(dropdownItems[1]),
              //   ),
              //   DropdownMenuItem<String>(
              //     value: 'other',
              //     child: Text(dropdownItems[2]),
              //   ),
              // ],
              // items: items
              // items: [
              //   DropdownMenuItem<String>(
              //     value: 'male',
              //     child: Text(AppLocalizations.of(context)!.genders('male')),
              //   ),
              //   DropdownMenuItem<String>(
              //     value: 'female',
              //     child: Text(AppLocalizations.of(context)!.genders('female')),
              //   ),
              //   DropdownMenuItem<String>(
              //     value: 'other',
              //     child: Text(AppLocalizations.of(context)!.genders('other')),
              //   ),
              // ],
              items: [
                DropdownMenuItem<String>(
                  value: 'male',
                  child: Text('male'),
                ),
                DropdownMenuItem<String>(
                  value: 'female',
                  child: Text('female'),
                ),
                DropdownMenuItem<String>(
                  value: 'other',
                  child: Text('other'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
