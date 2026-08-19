import 'package:flutter/material.dart';
import 'explore_screen.dart';
import 'favourites_screen.dart';
import 'profile_screen.dart';
import 'tourist_spot.dart';

// Card screens
import 'stay_card.dart';
import 'food_card.dart';
import 'safety_alerts_card.dart';
import 'package:pakvista/screens/ai_trip_planner_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool isDarkMode = false;
  List<TouristSpot> favourites = [];

  void _updateFavourites(List<TouristSpot> updatedFavourites) {
    setState(() {
      favourites = updatedFavourites;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HomePageContent(
        onThemeToggle: (value) {
          setState(() => isDarkMode = value);
        },
        isDarkMode: isDarkMode,
      ),
      ExploreScreen(
        favourites: favourites,
        onFavouritesUpdated: _updateFavourites,
        onBackToHome: () {
          setState(() {
            _currentIndex = 0;
          });
        },
      ),
      FavouritesScreen(
        favourites: favourites,
        onFavouritesUpdated: _updateFavourites,
      ),
      const ProfileScreen(),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() => _currentIndex = value);
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favourites"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------
// HOME PAGE CONTENT (About/Contact Fixed)
// -------------------------------------------------
class HomePageContent extends StatelessWidget {
  final Function(bool) onThemeToggle;
  final bool isDarkMode;

  const HomePageContent({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text(
                "Menu",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            const ListTile(
              title: Text(
                "Settings",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SwitchListTile(
              title: const Text("Dark Theme"),
              value: isDarkMode,
              onChanged: (value) {
                onThemeToggle(value);
              },
            ),

            // ✅ ABOUT BUTTON
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About"),
              onTap: () async {
                Navigator.pop(context); // close drawer
                await showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("About PakVista"),
                    content: const Text(
                      "PakVista is a smart tourism guide app designed to help "
                      "travelers explore Pakistan. It offers destination discovery, "
                      "AI-based trip planning, safety alerts, and travel assistance "
                      "to make journeys smooth and enjoyable.",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // close dialog
                          Navigator.of(context).popUntil((route) => route.isFirst); // ensure home
                        },
                        child: const Text("Close"),
                      ),
                    ],
                  ),
                );
              },
            ),

            // ✅ CONTACT BUTTON
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text("Contact"),
              onTap: () async {
                Navigator.pop(context); // close drawer
                await showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Contact Us"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        ListTile(
                          leading: Icon(Icons.email),
                          title: Text("Email"),
                          subtitle: Text("pakvista.support@gmail.com"),
                        ),
                        ListTile(
                          leading: Icon(Icons.phone),
                          title: Text("Phone"),
                          subtitle: Text("+92 300 1234567"),
                        ),
                        ListTile(
                          leading: Icon(Icons.link),
                          title: Text("LinkedIn"),
                          subtitle: Text("linkedin.com/company/pakvista"),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // close dialog
                          Navigator.of(context).popUntil((route) => route.isFirst); // ensure home
                        },
                        child: const Text("Close"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("PakVista", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Welcome to Pak Vista",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              "A partner for your dream journey",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 25),

            _buildCard(
              title: "Stay ",
              subtitle: "Find places to stay",
              color: Colors.teal,
              icon: Icons.hotel,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => StayCardScreen()),
                );
              },
            ),
            const SizedBox(height: 16),

            _buildCard(
              title: "Food ",
              subtitle: "Discover restaurants",
              color: Colors.orange,
              icon: Icons.restaurant,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => FoodCardScreen()),
                );
              },
            ),
            const SizedBox(height: 16),

            _buildCard(
              title: "Safety Alerts",
              subtitle: "Important travel alerts",
              color: Colors.redAccent,
              icon: Icons.warning,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SafetyAlertsCardScreen()),
                );
              },
            ),
            const SizedBox(height: 16),

            _buildCard(
              title: "AI Trip Planner",
              subtitle: "Plan trips with AI",
              color: Colors.blue,
              icon: Icons.smart_toy,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AITripPlannerScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String subtitle,
    required Color color,
    required IconData icon,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: color,
              child: Icon(icon, color: Colors.white, size: 30),
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(subtitle,
                    style: const TextStyle(fontSize: 15, color: Colors.grey)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
