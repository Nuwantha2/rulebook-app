import 'package:flutter/material.dart';

class GameSetupScreen extends StatefulWidget {
  const GameSetupScreen({super.key});

  @override
  State<GameSetupScreen> createState() => _GameSetupScreenState();
}

class _GameSetupScreenState extends State<GameSetupScreen> {
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
                          'Game Setup',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Prepare Harbour of Fortune before the first round begins',
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
                      // Step 1: Choose Number of Rounds
                      _StepCard(
                        stepNumber: '1',
                        title: 'Choose Number of Rounds',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Before starting, players agree on the game length.',
                              style: TextStyle(fontSize: 14, height: 1.5),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Recommended options:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildOption('8 rounds → approx. 45–75 minutes'),
                            _buildOption('10 rounds → approx. 60–115 minutes'),
                            _buildOption('12 rounds → approx. 70–135 minutes'),
                            const SizedBox(height: 12),
                            const Text(
                              'The chosen number of rounds determines when the game ends.',
                              style: TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Step 2: Prepare the Game Board
                      _StepCard(
                        stepNumber: '2',
                        title: 'Prepare the Game Board',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildBulletPoint(
                              'Place the game board in the center of the table',
                            ),
                            _buildBulletPoint(
                              'Ensure the harbor, districts, and Wild Card areas are clearly visible',
                            ),
                            _buildBulletPoint(
                              'Place the Wild Card pile on its designated space',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Step 3: Choose a Family & Components
                      _StepCard(
                        stepNumber: '3',
                        title: 'Choose a Family & Components',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Each player selects one family color and takes:',
                              style: TextStyle(fontSize: 14, height: 1.5),
                            ),
                            const SizedBox(height: 12),
                            _buildBulletPoint(
                              'Their 54-card deck (matching family color)',
                            ),
                            _buildBulletPoint(
                              '1 ship token, placed at sea (outside the harbor)',
                            ),
                            _buildBulletPoint(
                              '6 house tokens, kept in personal supply',
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Each family begins with the same components.',
                              style: TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Step 4: Assign Initial Household Members
                      _StepCard(
                        stepNumber: '4',
                        title: 'Assign Initial Household Members',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Each player takes the 8 Court Cards (Kings & Queens) from their deck and places them face-up on the table.',
                              style: TextStyle(fontSize: 14, height: 1.5),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'These represent the starting active household members:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildHouseholdMember('Father'),
                            _buildHouseholdMember('Mother'),
                            _buildHouseholdMember('Butler'),
                            _buildHouseholdMember('Housekeeper'),
                            _buildHouseholdMember('Oldest Son'),
                            _buildHouseholdMember('Youngest Son'),
                            _buildHouseholdMember('Oldest Daughter'),
                            _buildHouseholdMember('Youngest Daughter'),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF8E1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFFD4AF37),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Important:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  _buildBulletPoint('These cards start active'),
                                  _buildBulletPoint(
                                    'The 4 Jack cards remain face-down and inactive',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Step 5: Distribute Starting Money
                      _StepCard(
                        stepNumber: '5',
                        title: 'Distribute Starting Money',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildBulletPoint(
                              'Each player starts with 8,000 money',
                            ),
                            _buildBulletPoint(
                              'Money is taken from the General Bank',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Step 6: Set Up the General Bank
                      _StepCard(
                        stepNumber: '6',
                        title: 'Set Up the General Bank',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildBulletPoint(
                              'Place all remaining money tokens aside as the General Bank',
                            ),
                            _buildBulletPoint(
                              'Place the Director-General Hat at the bank',
                            ),
                            _buildBulletPoint(
                              'No player begins the game as Director-General',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Step 7: Prepare the Draw Pile
                      _StepCard(
                        stepNumber: '7',
                        title: 'Prepare the Draw Pile',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'For each player:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildBulletPoint('Shuffle the remaining 42 cards'),
                            _buildBulletPoint(
                              'Place them face-down as your draw pile',
                            ),
                            _buildBulletPoint(
                              'Draw 8 cards to form your starting hand',
                            ),
                            _buildBulletPoint(
                              'Keep your hand hidden from opponents',
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'There is no hand limit unless stated otherwise.',
                              style: TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Step 8: Determine First Player
                      _StepCard(
                        stepNumber: '8',
                        title: 'Determine First Player',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildBulletPoint(
                              'Each player rolls the dice once',
                            ),
                            _buildBulletPoint(
                              'The highest roll takes the first turn',
                            ),
                            _buildBulletPoint('Resolve ties by re-rolling'),
                            _buildBulletPoint('Play proceeds clockwise'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Setup Complete
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF5B8FA3),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '✓ Setup Complete',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Once all steps are finished:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildWhiteBulletPoint(
                              'The game begins with Round 1',
                            ),
                            _buildWhiteBulletPoint(
                              'The first player starts with Phase 1 – Roll & Reap',
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

  Widget _buildOption(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 14, height: 1.5)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 14, height: 1.5)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhiteBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(fontSize: 14, height: 1.5, color: Colors.white),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHouseholdMember(String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          const SizedBox(width: 12),
          const Icon(Icons.circle, size: 6, color: Color(0xFF5B8FA3)),
          const SizedBox(width: 8),
          Text(name, style: const TextStyle(fontSize: 14, height: 1.5)),
        ],
      ),
    );
  }
}

// Step Card Widget
class _StepCard extends StatelessWidget {
  final String stepNumber;
  final String title;
  final Widget child;

  const _StepCard({
    required this.stepNumber,
    required this.title,
    required this.child,
  });

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
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFD4AF37),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    stepNumber,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
