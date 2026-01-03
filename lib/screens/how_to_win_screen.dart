import 'package:flutter/material.dart';

class HowToWinScreen extends StatefulWidget {
  const HowToWinScreen({super.key});

  @override
  State<HowToWinScreen> createState() => _HowToWinScreenState();
}

class _HowToWinScreenState extends State<HowToWinScreen> {
  int _selectedIndex = 1; // Rules tab is selected

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle navigation to other screens
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/rules-hub');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/card-library');
    } else if (index == 3) {
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
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How to Win',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'End-game rules & scoring',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // When Does the Game End?
                      _SectionCard(
                        title: 'When Does the Game End?',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _NumberedPoint(
                              number: '1.',
                              text:
                                  'The game ends when the final round (8, 10, or 12 depending on chosen length) is completed.',
                            ),
                            const SizedBox(height: 12),
                            _NumberedPoint(
                              number: '2.',
                              text:
                                  'All players play their turns in the final round, following normal Phase 1 & Phase 2 rules.',
                            ),
                            const SizedBox(height: 12),
                            _NumberedPoint(
                              number: '3.',
                              text:
                                  'After the final player\'s turn, tally all player wealth before declaring a winner.',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Wealth Calculation
                      _SectionCard(
                        title: 'Wealth Calculation',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Each player\'s total wealth consists of:',
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _WealthItem(
                              emoji: '💰',
                              label: 'Gold in hand:',
                              description:
                                  'All coins the player currently holds',
                            ),
                            const SizedBox(height: 12),
                            _WealthItem(
                              emoji: '🏛️',
                              label: 'Property value:',
                              description:
                                  '1 gold per building, 2 gold per house',
                            ),
                            const SizedBox(height: 12),
                            _WealthItem(
                              emoji: '👑',
                              label: 'Court Cards:',
                              description: 'Kings = 2 gold, Queens = 1 gold',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // End-Game Bonuses
                      _SectionCard(
                        title: 'End-Game Bonuses',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _BonusItem(
                              bonus: '+3 gold:',
                              description: 'Player with most completed streets',
                            ),
                            const SizedBox(height: 10),
                            _BonusItem(
                              bonus: '+2 gold:',
                              description: 'Current Director-General',
                            ),
                            const SizedBox(height: 10),
                            _BonusItem(
                              bonus: '+1 gold:',
                              description: 'Most Court Cards collected',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Tiebreaker Order
                      _SectionCard(
                        title: 'Tiebreaker Order',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _NumberedPoint(
                              number: '1.',
                              text: 'Most buildings owned',
                            ),
                            const SizedBox(height: 10),
                            _NumberedPoint(
                              number: '2.',
                              text: 'Most houses built',
                            ),
                            const SizedBox(height: 10),
                            _NumberedPoint(
                              number: '3.',
                              text: 'Most Court Cards held',
                            ),
                            const SizedBox(height: 10),
                            _NumberedPoint(
                              number: '4.',
                              text: 'Youngest player wins',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
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

// Section Card Widget
class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

// Numbered Point Widget
class _NumberedPoint extends StatelessWidget {
  final String number;
  final String text;

  const _NumberedPoint({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

// Wealth Item Widget
class _WealthItem extends StatelessWidget {
  final String emoji;
  final String label;
  final String description;

  const _WealthItem({
    required this.emoji,
    required this.label,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Bonus Item Widget
class _BonusItem extends StatelessWidget {
  final String bonus;
  final String description;

  const _BonusItem({required this.bonus, required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          bonus,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFFD4AF37), // Gold color
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
