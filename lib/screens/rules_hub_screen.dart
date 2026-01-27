import 'package:flutter/material.dart';

class RulesHubScreen extends StatefulWidget {
  const RulesHubScreen({super.key});

  @override
  State<RulesHubScreen> createState() => _RulesHubScreenState();
}

class _RulesHubScreenState extends State<RulesHubScreen> {
  int _selectedIndex = 1; // Rules tab is selected

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle navigation to other screens
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/roles-characters');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/card-library');
    } else if (index == 4) {
      Navigator.pushReplacementNamed(context, '/ledger');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4ED), // Cream background
      body: SafeArea(
        child: Column(
          children: [
            // Header section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: const BoxDecoration(
                color: Color(0xFF2C4558), // Dark blue
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rules Hub',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Complete reference guide',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _RuleItem(
                      icon: '🎲',
                      title: 'Game Setup',
                      subtitle: 'Initial board & card setup',
                      onTap: () {
                        Navigator.pushNamed(context, '/game-setup');
                      },
                    ),
                    const SizedBox(height: 12),
                    _RuleItem(
                      icon: '🔄',
                      title: 'Turn Flow',
                      subtitle: 'Phase 1 & Phase 2 breakdown',
                      onTap: () {
                        Navigator.pushNamed(context, '/turn-flow');
                      },
                    ),
                    const SizedBox(height: 12),
                    _RuleItem(
                      icon: '⚡',
                      title: 'Actions',
                      subtitle: 'Complete action list',
                      onTap: () {
                        Navigator.pushNamed(context, '/actions');
                      },
                    ),
                    const SizedBox(height: 12),
                    _RuleItem(
                      icon: '👑',
                      title: 'Roles & Characters',
                      subtitle: 'Jacks and Court Cards',
                      onTap: () {
                        Navigator.pushNamed(context, '/roles-characters');
                      },
                    ),
                    const SizedBox(height: 12),
                    _RuleItem(
                      icon: '🎩',
                      title: 'Director-General',
                      subtitle: 'Title rules & benefits',
                      onTap: () {
                        Navigator.pushNamed(context, '/director-general');
                      },
                    ),
                    const SizedBox(height: 12),
                    _RuleItem(
                      icon: '🏁',
                      title: 'Endgame',
                      subtitle: 'How to win & tiebreakers',
                      onTap: () {
                        Navigator.pushNamed(context, '/how-to-win');
                      },
                    ),
                    const SizedBox(height: 12),
                    _RuleItem(
                      icon: '📖',
                      title: 'Glossary',
                      subtitle: 'Terms & definitions with search',
                      onTap: () {
                        Navigator.pushNamed(context, '/glossary');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF5B8FA3),
          unselectedItemColor: Colors.grey,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined),
              activeIcon: Icon(Icons.menu_book),
              label: 'Rules',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              activeIcon: Icon(Icons.people),
              label: 'Roles',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.style_outlined),
              activeIcon: Icon(Icons.style),
              label: 'Cards',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline),
              activeIcon: Icon(Icons.bookmark),
              label: 'Bookmarks',
            ),
          ],
        ),
      ),
    );
  }
}

// Rule Item Widget
class _RuleItem extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _RuleItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon container
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F4ED),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(icon, style: const TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(width: 16),
              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              // Arrow icon
              Icon(Icons.chevron_right, color: Colors.grey[400], size: 24),
            ],
          ),
        ),
      ),
    );
  }
}
