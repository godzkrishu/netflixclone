import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:netflixclone/views/detailview.dart';
import 'package:netflixclone/views/homescreen.dart';
import 'package:netflixclone/views/searchscreen.dart';
import 'package:netflixclone/views/splashscreen.dart';
import 'package:netflixclone/models/moviemodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = true;
  int _selectedIndex = 0; // State for selected index

  // List of pages for the bottom navigation
  final List<Widget> _pages = [
    HomeScreen(),
    SearchScreen(),
  ];

  splashscreen() {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    splashscreen();
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => isLoading
              ? const SplashScreen()
              : Scaffold(
            body: _pages[_selectedIndex], // Render the selected page
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped, // Handle tap
            ),
          ),
        ),
        GoRoute(
          path: '/detail',
          builder: (context, state) {
            final Moviemodel movie = state.extra as Moviemodel;
            return DetailScreen(movie: movie);
          },
        ),
    GoRoute(path: '/search', builder: (context, state) => SearchScreen()),
        
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
