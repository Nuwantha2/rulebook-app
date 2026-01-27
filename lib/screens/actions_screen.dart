import 'package:flutter/material.dart';

class ActionsScreen extends StatefulWidget {
  const ActionsScreen({super.key});

  @override
  State<ActionsScreen> createState() => _ActionsScreenState();
}

class _ActionsScreenState extends State<ActionsScreen> {
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
                          'Actions',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Phase 2 – Act & Attack',
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
                      // Introduction
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF5B8FA3),
                            width: 1,
                          ),
                        ),
                        child: const Text(
                          'During Phase 2 of your turn, you may perform any number of actions, in any order, as long as you meet their requirements and have enough money. You may stop at any time.',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Neutralize Disasters
                      _ActionCard(
                        title: 'Neutralize Disasters',
                        subtitle:
                            'Resolve Black disaster cards affecting your household, income, ship, or houses.',
                        children: [
                          _ActionSection(
                            title: 'What this does:',
                            items: [
                              'Ends the effects of lingering disasters',
                              'Restores blocked income or damaged assets',
                            ],
                          ),
                          const SizedBox(height: 12),
                          _ActionSection(
                            title: 'How to do it:',
                            items: [
                              'Play a Red card of equal or higher value',
                              'Pay the required cost to the General Bank',
                              'Use special abilities (e.g. Housekeeper healing Sickness)',
                            ],
                          ),
                          const SizedBox(height: 12),
                          _ActionSection(
                            title: 'When to use:',
                            items: [
                              'Before collecting blocked income',
                              'When disasters carry over into future rounds',
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Hire a Jack
                      _ActionCard(
                        title: 'Hire a Jack',
                        subtitle:
                            'Expand your household with powerful specialists.',
                        children: [
                          _ActionSection(
                            title: 'Available Jacks:',
                            items: ['Captain', 'Builder', 'Trader', 'Spy'],
                          ),
                          const SizedBox(height: 12),
                          _ActionSection(
                            title: 'Requirements:',
                            items: [
                              'Reach a capital milestone: 8,500 / 9,000 / 9,500 / 10,000',
                              'Pay 200 to the General Bank',
                            ],
                          ),
                          const SizedBox(height: 12),
                          _ActionSection(
                            title: 'Notes:',
                            items: [
                              'Only one Jack per turn',
                              'Jack abilities require an additional 100 per turn to activate',
                              'Wild Card: Add a Jack for Free bypasses cost and milestones',
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Build Houses
                      _ActionCard(
                        title: 'Build Houses',
                        subtitle:
                            'Expand your district and increase rent income.',
                        children: [
                          _ActionSection(
                            title: 'Requirements:',
                            items: [
                              'Butler (King of Clubs) must be active',
                              'Ship must be docked in the harbor',
                              'Sufficient money available',
                            ],
                          ),
                          const SizedBox(height: 12),
                          _ActionSection(
                            title: 'Cost:',
                            items: ['1500 per house'],
                          ),
                          const SizedBox(height: 12),
                          _ActionSection(
                            title: 'Limits:',
                            items: [
                              '1 house per turn',
                              '2 houses if Director-General',
                              '3 houses if Director-General + Builder Jack',
                              'Maximum of 6 houses total',
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Arrange Marriage
                      _ActionCard(
                        title: 'Arrange Marriage',
                        subtitle:
                            'Grow your household through political marriages.',
                        children: [
                          _ActionSection(
                            title: 'Requirements:',
                            items: [
                              'Mother (Queen of Hearts) must be active',
                              'At least one house built',
                              'Pay 1000 dowry to the General Bank',
                            ],
                          ),
                          const SizedBox(height: 12),
                          _ActionSection(
                            title: 'Effect:',
                            items: [
                              'Marry your son to an opponent\'s daughter',
                              'The daughter joins your household as an active member',
                              'The opponent cannot refuse',
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFEBEE),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFFE57373),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Risk: ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Divorce (Black 5) returns the daughter to her birth family',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Play Red Ace
                      _ActionCard(
                        title: 'Play Red Ace',
                        subtitle: 'The Great Investment',
                        children: [
                          const Text(
                            'Initiate a major investment opportunity.',
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _ActionSection(
                            title: 'How it works:',
                            items: [
                              'Play a Red Ace',
                              'Pay 100 administration fee',
                              'Invite other players to invest (minimum 100)',
                            ],
                          ),
                          const SizedBox(height: 12),
                          _ActionSection(
                            title: 'Outcome:',
                            items: [
                              'If total investment is under 600 → canceled',
                              'If successful → initiator gains up to 800 profit',
                            ],
                          ),
                          const SizedBox(height: 12),
                          _ActionSection(
                            title: 'Profit Phase:',
                            items: [
                              'Investors roll the dice to determine returns',
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Play Black Cards
                      _ActionCard(
                        title: 'Play Black Cards',
                        subtitle: 'Attack your opponents with disasters.',
                        children: [
                          _ActionSection(
                            title: 'Rules:',
                            items: [
                              'Play one Black card per opponent',
                              'Effects apply immediately unless neutralized',
                              'Opponents may respond with Red cards',
                            ],
                          ),
                          const SizedBox(height: 12),
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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Strategy Tip: ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Time your attacks when opponents are low on money or defenses',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // End of Turn
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8B6F47),
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
                              'End of Turn',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Finish your turn once all actions are complete.',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Steps:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildWhiteBulletPoint(
                              'From Round 2 onward, draw 2 cards',
                            ),
                            _buildWhiteBulletPoint(
                              'Pass play clockwise to the next player',
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
}

// Action Card Widget
class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;

  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.children,
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
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

// Action Section Widget
class _ActionSection extends StatelessWidget {
  final String title;
  final List<String> items;

  const _ActionSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        ...items.map((item) => _buildBulletPoint(item)),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
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
}
