import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'package:catbreeds/data/services/breed_api_service.dart';
import 'package:catbreeds/providers/breed_provider.dart';
import 'package:catbreeds/repositories/breed_repository.dart';
import 'package:catbreeds/ui/pages/breed_list_page.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BreedProvider(BreedRepository(BreedApiService())),
        ),
      ],
      child: MaterialApp(
        title: 'Catbreeds',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          dividerColor: Colors.blueAccent,
          dividerTheme: DividerThemeData(
            color: Colors.blue[100],
            thickness: 4,
            space: 4,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blueAccent,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Colors.blueAccent,
          ),
          textTheme: const TextTheme(
            headlineMedium: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            bodySmall: TextStyle(
              fontSize: 20,
            ),
            bodyMedium: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        home: const BreedListPage(),
      ),
    );
  }
}
