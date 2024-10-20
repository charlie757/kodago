import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/services/provider/common/common_provider.dart';
import 'package:kodago/services/provider/file_rack/add_record_provider.dart';
import 'package:kodago/services/provider/group/contact_provider.dart';
import 'package:kodago/services/provider/group/topic_provider.dart';
import 'package:kodago/services/provider/auth_provider/forgot_password_provider.dart';
import 'package:kodago/services/provider/auth_provider/login_provider.dart';
import 'package:kodago/services/provider/auth_provider/otp_provider.dart';
import 'package:kodago/services/provider/auth_provider/signup_provider.dart';
import 'package:kodago/services/provider/dashboard_provider.dart';
import 'package:kodago/services/provider/file_rack/file_rack_details_provider.dart';
import 'package:kodago/services/provider/file_rack/file_rack_provider.dart';
import 'package:kodago/services/provider/group/chat_provider.dart';
import 'package:kodago/services/provider/group/group_details_provider.dart';
import 'package:kodago/services/provider/group/group_provider.dart';
import 'package:kodago/services/provider/group/new_group_provider.dart';
import 'package:kodago/services/provider/home/home_provider.dart';
import 'package:kodago/services/provider/notification/notification_provider.dart';
import 'package:kodago/services/provider/onboarding_provider.dart';
import 'package:kodago/services/provider/profile_provider.dart';
import 'package:kodago/services/provider/splash_provider.dart';
import 'package:kodago/presentation/splash_screen.dart';
import 'package:kodago/services/provider/view_feeds_provider.dart';
import 'package:kodago/uitls/session_manager.dart';
import 'package:kodago/uitls/utils.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionManager().init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: SplashProvider(),
        ),
        ChangeNotifierProvider.value(
          value: OnboardingProvider(),
        ),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => SignupProvider()),
        ChangeNotifierProvider(create: (_) => OtpProvider()),
        ChangeNotifierProvider(create: (_) => ForgotPasswordProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => ContactProvider()),
        ChangeNotifierProvider(create: (_) => GroupProvider()),
        ChangeNotifierProvider(create: (_) => GroupDetailsProvider()),
        ChangeNotifierProvider(create: (_) => FileRackProvider()),
        ChangeNotifierProvider(create: (_) => FileRackDetailsProvider()),
        ChangeNotifierProvider(create: (_) => TopicProvider()),
        ChangeNotifierProvider(create: (_) => CommonProvider()),
        ChangeNotifierProvider(create: (_) => AddRecordProvider()),
        ChangeNotifierProvider(create: (_) => ViewFeedsProvider()),
        ChangeNotifierProvider(
          create: (_) => NewGroupProvider(),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          Utils.hideTextField();
        },
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Kodago',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColor.whiteColor,
              scrolledUnderElevation: 0.0,
            ),
            scaffoldBackgroundColor: AppColor.whiteColor,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: SplashScreen(),
          builder: (context, child) {
            return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child!);
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
