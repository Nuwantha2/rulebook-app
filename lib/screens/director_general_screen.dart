import 'package:flutter/material.dart';

class DirectorGeneralScreen extends StatefulWidget {
  const DirectorGeneralScreen({super.key});

  @override
  State<DirectorGeneralScreen> createState() => _DirectorGeneralScreenState();
}

class _DirectorGeneralScreenState extends State<DirectorGeneralScreen> {
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
                          'Director-General',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Ruler of New Amsterdam',
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
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFD4AF37), Color(0xFFC19A2E)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFD4AF37).withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.emoji_events,
                                color: Color(0xFFD4AF37),
                                size: 36,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'The Director-General represents political control of the city.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      height: 1.5,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    'Only one player may hold the title at a time, marked by the Director-General Hat.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Section Header
                      const Text(
                        'Claiming the Title',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C4558),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'You may become Director-General in two ways:',
                        style: TextStyle(fontSize: 14, height: 1.5),
                      ),
                      const SizedBox(height: 16),

                      // Dice Roll Method
                      _DirectorCard(
                        title: '🎲 Dice Roll',
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
                            _buildBullet('During Phase 1, roll a natural 6'),
                            _buildBullet(
                              'Take the Director-General Hat immediately',
                            ),
                            _buildBullet(
                              'If another player holds the hat, they lose it without compensation',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Wild Card Method
                      _DirectorCard(
                        title: '🃏 Wild Card',
                        icon: Icons.style,
                        iconColor: const Color(0xFFFF9800),
                        isExpanded: _expandedCards['wild_card'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['wild_card'] =
                                !(_expandedCards['wild_card'] ?? false);
                          });
                        },
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildBullet(
                              'Play the Become Director-General Wild Card',
                            ),
                            _buildBullet('Claim the hat instantly'),
                            _buildBullet('No dice roll required'),
                            const SizedBox(height: 12),
                            _buildNote(
                              'You may claim the title at any time during your turn if using the Wild Card',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Benefits Section
                      const Text(
                        'Benefits of Office',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C4558),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'While you hold the Director-General Hat, you gain:',
                        style: TextStyle(fontSize: 14, height: 1.5),
                      ),
                      const SizedBox(height: 16),

                      // Tax Collection
                      _DirectorCard(
                        title: '💰 Tax Collection',
                        icon: Icons.monetization_on,
                        iconColor: const Color(0xFF4CAF50),
                        isExpanded: _expandedCards['tax_collection'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['tax_collection'] =
                                !(_expandedCards['tax_collection'] ?? false);
                          });
                        },
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F5E9),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFF4CAF50),
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: RichText(
                                      text: const TextSpan(
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'During Phase 1, collect ',
                                          ),
                                          TextSpan(
                                            text: '75 money',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF4CAF50),
                                            ),
                                          ),
                                          TextSpan(text: ' from each opponent'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildBullet('Add this directly to your capital'),
                            _buildBullet(
                              'Taxes are owed even if opponents cannot pay immediately',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Building Advantage
                      _DirectorCard(
                        title: '🏗️ Building Advantage',
                        icon: Icons.home_work,
                        iconColor: const Color(0xFF5B8FA3),
                        isExpanded: _expandedCards['building'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['building'] =
                                !(_expandedCards['building'] ?? false);
                          });
                        },
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE3F2FD),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFF5B8FA3),
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: RichText(
                                      text: const TextSpan(
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                'During Phase 2, build up to ',
                                          ),
                                          TextSpan(
                                            text: '2 houses',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF5B8FA3),
                                            ),
                                          ),
                                          TextSpan(text: ' per turn'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildBullet(
                              'Butler (King of Clubs) must be active',
                            ),
                            _buildBullet('Ship must be docked'),
                            _buildBullet('Each house still costs 1500'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Stacking Bonuses
                      _DirectorCard(
                        title: 'Stacking Bonuses',
                        icon: Icons.add_circle,
                        iconColor: const Color(0xFFFF9800),
                        isExpanded: _expandedCards['stacking'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['stacking'] =
                                !(_expandedCards['stacking'] ?? false);
                          });
                        },
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'If the Builder Jack is also active:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF8E1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFFFF9800),
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: RichText(
                                      text: const TextSpan(
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'You may build up to ',
                                          ),
                                          TextSpan(
                                            text: '3 houses',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFFF9800),
                                            ),
                                          ),
                                          TextSpan(text: ' per turn'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildNote(
                              'This is the maximum possible building limit',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Losing the Title
                      const Text(
                        'Losing the Title',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C4558),
                        ),
                      ),
                      const SizedBox(height: 16),

                      _DirectorCard(
                        title: 'How You Lose the Hat',
                        icon: Icons.remove_circle_outline,
                        iconColor: const Color(0xFFF44336),
                        isExpanded: _expandedCards['losing'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['losing'] =
                                !(_expandedCards['losing'] ?? false);
                          });
                        },
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'You lose the Director-General Hat if:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildBullet('Another player rolls a natural 6'),
                            _buildBullet(
                              'Another player plays the Become Director-General Wild Card',
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFEBEE),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFFF44336),
                                  width: 1,
                                ),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.warning_amber,
                                    color: Color(0xFFF44336),
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Loss is immediate, and all benefits end at once',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Additional Rules
                      Container(
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
                            const Text(
                              'Additional Rules',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildBullet(
                              'There is no limit to how many times a player may reclaim the title',
                            ),
                            _buildBullet(
                              'Tax collection happens every turn you hold the hat',
                            ),
                            _buildBullet(
                              'Taxes are collected before other Phase 1 effects',
                            ),
                            _buildBullet(
                              'Owed taxes must be paid as soon as the player has sufficient funds',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Strategy Note
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF5B8FA3), Color(0xFF4A7A8E)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF5B8FA3).withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.lightbulb,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'Strategy Note',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'The Director-General title provides strong economic momentum. Claim it early to accelerate construction, but defend it—power changes hands quickly in New Amsterdam.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                height: 1.6,
                              ),
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
}

// Director Card Widget
class _DirectorCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final bool isExpanded;
  final VoidCallback onToggle;
  final Widget content;

  const _DirectorCard({
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
