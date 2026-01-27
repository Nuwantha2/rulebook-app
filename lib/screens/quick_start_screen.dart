import 'package:flutter/material.dart';

class QuickStartScreen extends StatefulWidget {
  const QuickStartScreen({super.key});

  @override
  State<QuickStartScreen> createState() => _QuickStartScreenState();
}

class _QuickStartScreenState extends State<QuickStartScreen> {
  int _selectedIndex = 0;
  int _selectedRoundOption = 1; // Default to Standard (10 Rounds)

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pop(context); // Go back to home
    } else if (index == 1) {
      Navigator.pushNamed(context, '/rules-hub');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/roles-characters');
    } else if (index == 3) {
      Navigator.pushNamed(context, '/card-library');
    } else if (index == 4) {
      Navigator.pushNamed(context, '/ledger');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4ED), // Cream background
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            decoration: const BoxDecoration(
              color: Color(0xFF1E3A4C), // Dark blue
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/rules-hub');
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quick Start',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Setup & round options',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Game Objective Card
                    _ContentCard(
                      title: 'Game Objective',
                      child: Text(
                        'Finish the final round with the most money. Accumulate wealth through trading, building, and strategic actions across multiple rounds.',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Round Options Card
                    _ContentCard(
                      title: 'Round Options',
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          _RoundOptionCard(
                            rounds: '8 Rounds',
                            duration: '45 minutes',
                            label: 'Quick',
                            labelColor: const Color(0xFFD4AF37), // Golden
                            isSelected: _selectedRoundOption == 0,
                            onTap: () {
                              setState(() {
                                _selectedRoundOption = 0;
                              });
                            },
                          ),
                          const SizedBox(height: 12),
                          _RoundOptionCard(
                            rounds: '10 Rounds',
                            duration: '60 minutes',
                            label: 'Standard',
                            labelColor: const Color(0xFF5B8FA3), // Blue
                            isSelected: _selectedRoundOption == 1,
                            onTap: () {
                              setState(() {
                                _selectedRoundOption = 1;
                              });
                            },
                          ),
                          const SizedBox(height: 12),
                          _RoundOptionCard(
                            rounds: '12 Rounds',
                            duration: '90-135 minutes',
                            label: 'Epic',
                            labelColor: const Color(0xFF4A7C59), // Green
                            isSelected: _selectedRoundOption == 2,
                            onTap: () {
                              setState(() {
                                _selectedRoundOption = 2;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Win Condition Card
                    _ContentCard(
                      title: 'Win Condition',
                      child: Text(
                        'The player with the highest total wealth at the end of the final round wins. In case of a tie, the player with the most buildings wins. If still tied, the player with the most houses wins.',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Learn Turn Flow Button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/turn-flow');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5B8FA3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Learn Turn Flow',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
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

class _ContentCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _ContentCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF1E3A4C),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _RoundOptionCard extends StatelessWidget {
  final String rounds;
  final String duration;
  final String label;
  final Color labelColor;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoundOptionCard({
    required this.rounds,
    required this.duration,
    required this.label,
    required this.labelColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFE8E8E8),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? labelColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rounds,
                    style: const TextStyle(
                      color: Color(0xFF1E3A4C),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    duration,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: labelColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
