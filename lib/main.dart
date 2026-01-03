import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'features/splash/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home.dart';
import 'screens/quick_start_screen.dart';
import 'screens/turn_flow_screen.dart';
import 'screens/how_to_win_screen.dart';
import 'screens/rules_hub_screen.dart';
import 'screens/game_setup_screen.dart';
import 'screens/actions_screen.dart';
import 'screens/roles_characters_screen.dart';
import 'screens/director_general_screen.dart';
import 'screens/glossary_screen.dart';
import 'screens/ledger_screen.dart';
import 'screens/card_library_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock portrait orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Harbour of Fortune',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const SplashScreen(),
        '/onboarding': (_) => const OnboardingScreen(),
        '/home': (_) => const HomeScreen(),
        '/quick-start': (_) => const QuickStartScreen(),
        '/turn-flow': (_) => const TurnFlowScreen(),
        '/how-to-win': (_) => const HowToWinScreen(),
        '/rules-hub': (_) => const RulesHubScreen(),
        '/game-setup': (_) => const GameSetupScreen(),
        '/actions': (_) => const ActionsScreen(),
        '/roles-characters': (_) => const RolesCharactersScreen(),
        '/director-general': (_) => const DirectorGeneralScreen(),
        '/glossary': (_) => const GlossaryScreen(),
        '/ledger': (_) => const LedgerScreen(),
        '/card-library': (_) => const CardLibraryScreen(),
      },
    );
  }
}
