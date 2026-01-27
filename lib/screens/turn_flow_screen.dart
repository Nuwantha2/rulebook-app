import 'package:flutter/material.dart';

class TurnFlowScreen extends StatefulWidget {
  const TurnFlowScreen({super.key});

  @override
  State<TurnFlowScreen> createState() => _TurnFlowScreenState();
}

class _TurnFlowScreenState extends State<TurnFlowScreen> {
  int _selectedIndex = 1; // Rules tab is selected
  final Map<String, bool> _expandedCards = {};

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
      backgroundColor: const Color(0xFFF7F4ED),
      body: SafeArea(
        child: Column(
          children: [
            // Header section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: const BoxDecoration(color: Color(0xFF2C4558)),
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
                          'Turn Flow',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'The core gameplay loop',
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
                      // Phase 1 Header
                      _PhaseHeader(
                        phaseNumber: '1',
                        title: 'Roll & Reap',
                        color: const Color(0xFF4CAF50),
                      ),
                      const SizedBox(height: 16),

                      // Income – Household Income Table
                      _TurnFlowCard(
                        title: 'Income – Household Income Table',
                        icon: Icons.family_restroom,
                        iconColor: const Color(0xFF4CAF50),
                        isExpanded: _expandedCards['household_income'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['household_income'] =
                                !(_expandedCards['household_income'] ?? false);
                          });
                        },
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Income is based on active household members:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildIncomeRow('14 members', '700'),
                            _buildIncomeRow('13 members', '500'),
                            _buildIncomeRow('12 members', '400'),
                            _buildIncomeRow('11 members', '300'),
                            _buildIncomeRow('10 members', '200'),
                            _buildIncomeRow('9 members', '100'),
                            _buildIncomeRow('< 8 members', '50'),
                            const SizedBox(height: 12),
                            _buildNote(
                              'Active = face-up Court Cards and Jacks',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Income – Rent Income Table
                      _TurnFlowCard(
                        title: 'Income – Rent Income Table',
                        icon: Icons.home,
                        iconColor: const Color(0xFF5B8FA3),
                        isExpanded: _expandedCards['rent_income'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['rent_income'] =
                                !(_expandedCards['rent_income'] ?? false);
                          });
                        },
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Rent income based on undamaged houses built:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildIncomeRow(
                              '6 houses (complete district)',
                              '1,000',
                            ),
                            _buildIncomeRow('5 houses', '700'),
                            _buildIncomeRow('3 houses', '400'),
                            _buildIncomeRow('2 houses', '300'),
                            _buildIncomeRow('1 house', '150'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Taxes – Director-General Rules
                      _TurnFlowCard(
                        title: 'Taxes – Director-General Rules',
                        icon: Icons.account_balance,
                        iconColor: const Color(0xFFD4AF37),
                        isExpanded: _expandedCards['taxes'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['taxes'] =
                                !(_expandedCards['taxes'] ?? false);
                          });
                        },
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildBullet(
                              'If you are Director-General: collect 75 from each opponent',
                            ),
                            _buildBullet(
                              'If no one is Director-General: no taxes are paid',
                            ),
                            const SizedBox(height: 12),
                            _buildNote(
                              'Director-General title is gained by reaching capital milestones first',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Dice Roll Breakdown
                      _TurnFlowCard(
                        title: 'Dice Roll Breakdown (Results 1–6)',
                        icon: Icons.casino,
                        iconColor: const Color(0xFF9C27B0),
                        isExpanded: _expandedCards['dice_roll'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['dice_roll'] =
                                !(_expandedCards['dice_roll'] ?? false);
                          });
                        },
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Roll the dice to determine business profit and ship movement:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildDiceResult('1', [
                              'Ship Movement: 1 space (+1 with Captain)',
                              'Business Profit: 100',
                            ]),
                            _buildDiceResult('2', [
                              'Ship Movement: 1 space (Captain adds +1)',
                              'Business Profit: 200',
                            ]),
                            _buildDiceResult('3', [
                              'Ship Movement: 2 spaces (Captain adds +1)',
                              'Business Profit: 300',
                            ]),
                            _buildDiceResult('4', [
                              'Ship Movement: 2 spaces (Captain adds +1)',
                              'Business Profit: 400',
                              'Draw 1 Wild Card from the pile',
                            ]),
                            _buildDiceResult('5', [
                              'Ship Movement: 3 spaces (Captain adds +1)',
                              'Business Profit: 500',
                            ]),
                            _buildDiceResult('6', [
                              'Ship Movement: 3 spaces (Captain adds +1)',
                              'Business Profit: 600',
                              'Claim the Director-General Hat',
                            ]),
                            const SizedBox(height: 12),
                            _buildNote(
                              'Father must be active to collect business profit',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Phase 2 Header
                      _PhaseHeader(
                        phaseNumber: '2',
                        title: 'Act & Attack',
                        color: const Color(0xFFFF5722),
                      ),
                      const SizedBox(height: 16),

                      // Neutralize Disasters
                      _TurnFlowCard(
                        title: 'Neutralize Disasters',
                        icon: Icons.healing,
                        iconColor: const Color(0xFF4CAF50),
                        isExpanded: _expandedCards['neutralize'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['neutralize'] =
                                !(_expandedCards['neutralize'] ?? false);
                          });
                        },
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'How to neutralize:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildBullet(
                              'Play a Red card of equal or higher value',
                            ),
                            _buildBullet('Pay the required cost'),
                            _buildBullet(
                              'Use Housekeeper to heal sickness for 400 (only once per round!)',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Hire a Jack
                      _TurnFlowCard(
                        title: 'Hire a Jack',
                        icon: Icons.person_add,
                        iconColor: const Color(0xFF2196F3),
                        isExpanded: _expandedCards['hire_jack'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['hire_jack'] =
                                !(_expandedCards['hire_jack'] ?? false);
                          });
                        },
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildBullet(
                              'Reach required capital milestone: 8,500 / 9,000 / 9,500 / 10,000',
                            ),
                            _buildBullet('Pay 200 to General Bank'),
                            _buildBullet(
                              'Choose: Captain, Builder, Trader, or Spy',
                            ),
                            _buildBullet('Only one Jack per turn'),
                            const SizedBox(height: 12),
                            _buildNote('Activation cost: 100 per turn'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Build Houses
                      _TurnFlowCard(
                        title: 'Build Houses',
                        icon: Icons.home_work,
                        iconColor: const Color(0xFF795548),
                        isExpanded: _expandedCards['build_houses'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['build_houses'] =
                                !(_expandedCards['build_houses'] ?? false);
                          });
                        },
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Requirements:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildBullet('Butler must be active'),
                            _buildBullet('Your ship is docked'),
                            const SizedBox(height: 12),
                            const Text(
                              'Building Options:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildBullet(
                              'Build 1 house in your district: pay 1,500',
                            ),
                            _buildBullet(
                              'Build 2 if you are Director-General: pay 3,000',
                            ),
                            _buildBullet(
                              'Build 3 with Jack the Builder: pay 4,500',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Arrange Marriage
                      _TurnFlowCard(
                        title: 'Arrange Marriage',
                        icon: Icons.favorite,
                        iconColor: const Color(0xFFE91E63),
                        isExpanded: _expandedCards['marriage'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['marriage'] =
                                !(_expandedCards['marriage'] ?? false);
                          });
                        },
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Requirements:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildBullet('Mother must be active'),
                            _buildBullet('At least one house built'),
                            _buildBullet('Pay 1,000 dowry'),
                            const SizedBox(height: 12),
                            _buildNote(
                              'Risk: Divorce (Black 5) returns the daughter to her birth family',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Play Red Ace
                      _TurnFlowCard(
                        title: 'Play Red Ace (Great Investment)',
                        icon: Icons.trending_up,
                        iconColor: const Color(0xFFFF9800),
                        isExpanded: _expandedCards['red_ace'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['red_ace'] =
                                !(_expandedCards['red_ace'] ?? false);
                          });
                        },
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildBullet('Play a Red Ace'),
                            _buildBullet('Pay 100 administration fee'),
                            _buildBullet('Invite others to invest (min. 100)'),
                            const SizedBox(height: 12),
                            const Text(
                              'Investment Outcome:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildBullet(
                              'Each investing player rolls the die to determine their profit:',
                            ),
                            _buildBullet(
                              'Roll 1 or 2: No extra profit, but get full investment back from General Bank',
                            ),
                            _buildBullet(
                              'Roll 3 or 4: Double investment - receive twice contribution from General Bank',
                            ),
                            _buildBullet(
                              'Roll 5 or 6: Triple investment - receive three times contribution from General Bank',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Play Black Cards
                      _TurnFlowCard(
                        title: 'Play Black Cards (Attack)',
                        icon: Icons.warning,
                        iconColor: const Color(0xFFF44336),
                        isExpanded: _expandedCards['black_cards'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['black_cards'] =
                                !(_expandedCards['black_cards'] ?? false);
                          });
                        },
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildBullet('Play one Black card per opponent'),
                            _buildBullet('Effects apply immediately'),
                            _buildBullet(
                              'Opponents may respond with Red cards',
                            ),
                            const SizedBox(height: 12),
                            _buildNote(
                              'Strategy: Attack when opponents are low on defenses',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // End of Turn Summary
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2C4558),
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
                            const SizedBox(height: 16),
                            _buildWhiteBullet(
                              'From Round 2 onward: draw 2 cards',
                            ),
                            _buildWhiteBullet('Pass play clockwise'),
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

  Widget _buildIncomeRow(String condition, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(condition, style: const TextStyle(fontSize: 14)),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4CAF50),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBullet(String text) {
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

  Widget _buildNote(String text) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD4AF37), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, size: 18, color: Color(0xFFD4AF37)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[800],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiceResult(String number, List<String> effects) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CoolDice(number: int.parse(number)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: effects
                  .map(
                    (effect) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        effect,
                        style: const TextStyle(fontSize: 14, height: 1.4),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhiteBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
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

// Phase Header Widget
class _PhaseHeader extends StatelessWidget {
  final String phaseNumber;
  final String title;
  final Color color;

  const _PhaseHeader({
    required this.phaseNumber,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                phaseNumber,
                style: TextStyle(
                  color: color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Phase $phaseNumber: $title',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// Turn Flow Card Widget
class _TurnFlowCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final bool isExpanded;
  final VoidCallback onToggle;
  final Widget content;

  const _TurnFlowCard({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.isExpanded,
    required this.onToggle,
    required this.content,
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
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: iconColor, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(height: 1),
                  const SizedBox(height: 16),
                  content,
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// Cool Dice Widget
class _CoolDice extends StatelessWidget {
  final int number;

  const _CoolDice({required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFFFFF), Color(0xFFF0F0F0)],
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(2, 2),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.7),
            blurRadius: 4,
            offset: const Offset(-1, -1),
          ),
        ],
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: CustomPaint(painter: _DicePipsPainter(number)),
    );
  }
}

// Custom painter for dice pips
class _DicePipsPainter extends CustomPainter {
  final int number;

  _DicePipsPainter(this.number);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2C4558)
      ..style = PaintingStyle.fill;

    final double pipRadius = size.width * 0.08;
    final double padding = size.width * 0.18;
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double left = padding;
    final double right = size.width - padding;
    final double top = padding;
    final double bottom = size.height - padding;

    switch (number) {
      case 1:
        canvas.drawCircle(Offset(centerX, centerY), pipRadius, paint);
        break;
      case 2:
        canvas.drawCircle(Offset(left, top), pipRadius, paint);
        canvas.drawCircle(Offset(right, bottom), pipRadius, paint);
        break;
      case 3:
        canvas.drawCircle(Offset(left, top), pipRadius, paint);
        canvas.drawCircle(Offset(centerX, centerY), pipRadius, paint);
        canvas.drawCircle(Offset(right, bottom), pipRadius, paint);
        break;
      case 4:
        canvas.drawCircle(Offset(left, top), pipRadius, paint);
        canvas.drawCircle(Offset(right, top), pipRadius, paint);
        canvas.drawCircle(Offset(left, bottom), pipRadius, paint);
        canvas.drawCircle(Offset(right, bottom), pipRadius, paint);
        break;
      case 5:
        canvas.drawCircle(Offset(left, top), pipRadius, paint);
        canvas.drawCircle(Offset(right, top), pipRadius, paint);
        canvas.drawCircle(Offset(centerX, centerY), pipRadius, paint);
        canvas.drawCircle(Offset(left, bottom), pipRadius, paint);
        canvas.drawCircle(Offset(right, bottom), pipRadius, paint);
        break;
      case 6:
        canvas.drawCircle(Offset(left, top), pipRadius, paint);
        canvas.drawCircle(Offset(left, centerY), pipRadius, paint);
        canvas.drawCircle(Offset(left, bottom), pipRadius, paint);
        canvas.drawCircle(Offset(right, top), pipRadius, paint);
        canvas.drawCircle(Offset(right, centerY), pipRadius, paint);
        canvas.drawCircle(Offset(right, bottom), pipRadius, paint);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
