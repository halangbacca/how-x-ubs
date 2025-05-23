import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gestao_ubs/screens/health_services_screen.dart';
import 'package:gestao_ubs/screens/health_unit_address_screen.dart';
import 'package:gestao_ubs/screens/medications_screen.dart';
import 'package:gestao_ubs/screens/vaccine_appointment_screen.dart';
import 'providers/auth_provider.dart';
import 'screens/login_screen.dart';
import 'screens/user_registration_screen.dart';
import 'screens/appointment_screen.dart';
import 'screens/appointment_list_screen.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/symptom_check_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'UBS+',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const UserRegistrationScreen(),
          '/home': (context) => const HomeScreen(),
          '/appointment': (context) => const AppointmentScreen(),
          '/vaccine': (context) => const VaccineAppointmentScreen(),
          '/services': (context) => HealthUnitServicesScreen(),
          '/address': (context) => const HealthUnitContactScreen(),
          '/medications': (context) => const MedicationsScreen(),
          '/symptom-check': (context) => const SymptomCheckScreen(),
          '/appointments_list': (context) =>
              const AppointmentListScreen(appointments: []),
        });
  }
}
