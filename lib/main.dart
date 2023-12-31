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
  List<String> dropdownItems = ['male', 'female', 'other'];
  String _gender = 'male';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            // example of passed parameter + example of providing options
            Text(
                '${AppLocalizations.of(context)!.hello('Cid')} (${AppLocalizations.of(context)!.pronoun(_gender)})'),
            // example of date formatting - there are 41 format variations
            Text(AppLocalizations.of(context)!.todaysDate(DateTime.now())),
            // counter from auto-generated template app
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            // example of pluralization
            Text(
                '${AppLocalizations.of(context)!.counterSentence} ${AppLocalizations.of(context)!.nClicks(_counter)}'),
            // example of providing options
            DropdownButton(
              value: _gender,
              onChanged: (gender) {
                setState(() {
                  _gender = gender!;
                });
              },
              items:
                  dropdownItems.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(AppLocalizations.of(context)!.genders(value)),
                );
              }).toList(),
            ),
            // example of escaped characters
            Text(AppLocalizations.of(context)!.escapedCharacter),
            // example of currency - there are many optional formatting parameters that can be set for currency - check documentation
            Text(AppLocalizations.of(context)!.currentBalance(_counter)),
            // example of specific/manual locale override (remains spanish no matter the device locale)
            Localizations.override(
              context: context,
              locale: const Locale('es'),
              child: Builder(
                builder: (context) {
                  return CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                    onDateChanged: (value) {},
                  );
                },
              ),
            ),
            // does not get automatically translated
            Localizations.override(
              context: context,
              locale: const Locale('es'),
              child: const Text('Hello'),
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
