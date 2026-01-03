import 'package:flutter/material.dart';

class RolesCharactersScreen extends StatefulWidget {
  const RolesCharactersScreen({super.key});

  @override
  State<RolesCharactersScreen> createState() => _RolesCharactersScreenState();
}

class _RolesCharactersScreenState extends State<RolesCharactersScreen> {
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
      Navigator.pushReplacementNamed(context, '/card-library');
    } else if (index == 3) {
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
                          'Roles & Characters',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Court Cards and Jacks',
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
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your household is made up of Court Cards and Jacks.',
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Only active (face-up) characters can perform their roles.',
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Court Cards Section
                      const Text(
                        'Court Cards',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C4558),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Starting Household Members',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Each player begins the game with these 8 active characters.',
                        style: TextStyle(fontSize: 14, height: 1.5),
                      ),
                      const SizedBox(height: 16),

                      // Father
                      _CharacterCard(
                        name: 'Father',
                        icon: Icons.business_center,
                        iconColor: const Color(0xFF8B6F47),
                        role: 'Business Leader',
                        ability:
                            'Collects business profit during Phase 1 based on dice roll',
                        rules: [
                          'If inactive (e.g. Sickness), no business profit is collected',
                          'Only one Father per household',
                        ],
                        isExpanded: _expandedCards['father'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['father'] =
                                !(_expandedCards['father'] ?? false);
                          });
                        },
                      ),
                      const SizedBox(height: 12),

                      // Mother
                      _CharacterCard(
                        name: 'Mother',
                        icon: Icons.favorite,
                        iconColor: const Color(0xFFE91E63),
                        role: 'Matchmaker',
                        ability: 'Arranges marriages during Phase 2',
                        rules: [
                          'Required to perform the Arrange Marriage action',
                          'Must be active to arrange a marriage',
                        ],
                        isExpanded: _expandedCards['mother'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['mother'] =
                                !(_expandedCards['mother'] ?? false);
                          });
                        },
                      ),
                      const SizedBox(height: 12),

                      // Butler
                      _CharacterCard(
                        name: 'Butler',
                        icon: Icons.home_work,
                        iconColor: const Color(0xFF5B8FA3),
                        role: 'Master Builder',
                        ability: 'Builds houses in your district',
                        rules: [
                          'Required to perform the Build Houses action',
                          'Must be active to build houses',
                        ],
                        isExpanded: _expandedCards['butler'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['butler'] =
                                !(_expandedCards['butler'] ?? false);
                          });
                        },
                      ),
                      const SizedBox(height: 12),

                      // Housekeeper
                      _CharacterCard(
                        name: 'Housekeeper',
                        icon: Icons.healing,
                        iconColor: const Color(0xFF4CAF50),
                        role: 'Healer',
                        ability:
                            'Once per round, may heal Sickness affecting one household member',
                        rules: [
                          'Pay 400 to the General Bank to heal',
                          'The Housekeeper cannot become sick',
                        ],
                        isExpanded: _expandedCards['housekeeper'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['housekeeper'] =
                                !(_expandedCards['housekeeper'] ?? false);
                          });
                        },
                      ),
                      const SizedBox(height: 12),

                      // Oldest Son
                      _CharacterCard(
                        name: 'Oldest Son',
                        icon: Icons.person,
                        iconColor: const Color(0xFF2196F3),
                        role: 'Heir',
                        ability: 'May be married when active',
                        rules: [
                          'Used in the Arrange Marriage action',
                          'Must be active to marry',
                        ],
                        isExpanded: _expandedCards['oldest_son'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['oldest_son'] =
                                !(_expandedCards['oldest_son'] ?? false);
                          });
                        },
                      ),
                      const SizedBox(height: 12),

                      // Youngest Son
                      _CharacterCard(
                        name: 'Youngest Son',
                        icon: Icons.person,
                        iconColor: const Color(0xFF2196F3),
                        role: 'Heir',
                        ability: 'May be married when active',
                        rules: ['Same rules as the Oldest Son'],
                        isExpanded: _expandedCards['youngest_son'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['youngest_son'] =
                                !(_expandedCards['youngest_son'] ?? false);
                          });
                        },
                      ),
                      const SizedBox(height: 12),

                      // Oldest Daughter
                      _CharacterCard(
                        name: 'Oldest Daughter',
                        icon: Icons.person_outline,
                        iconColor: const Color(0xFFE91E63),
                        role: 'Marriage Candidate',
                        ability: 'May be married when active',
                        rules: [
                          'Can be taken by another player through marriage',
                        ],
                        isExpanded: _expandedCards['oldest_daughter'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['oldest_daughter'] =
                                !(_expandedCards['oldest_daughter'] ?? false);
                          });
                        },
                      ),
                      const SizedBox(height: 12),

                      // Youngest Daughter
                      _CharacterCard(
                        name: 'Youngest Daughter',
                        icon: Icons.person_outline,
                        iconColor: const Color(0xFFE91E63),
                        role: 'Marriage Candidate',
                        ability: 'May be married when active',
                        rules: [
                          'Can be taken by another player through marriage',
                        ],
                        isExpanded:
                            _expandedCards['youngest_daughter'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['youngest_daughter'] =
                                !(_expandedCards['youngest_daughter'] ?? false);
                          });
                        },
                      ),
                      const SizedBox(height: 24),

                      // Active vs Inactive
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF8E1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFD4AF37),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Active vs Inactive Characters',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildStatusRow(
                              'Active:',
                              'Face-up, abilities usable, count toward household size',
                            ),
                            const SizedBox(height: 8),
                            _buildStatusRow(
                              'Inactive:',
                              'Face-down, abilities disabled, do not count',
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Common Cause of Inactivity: Sickness (Black 4)',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[800],
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Inactive characters remain inactive until healed or neutralized.',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Jacks Section
                      const Text(
                        'Jacks',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2C4558),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Hired Specialists',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Jacks are hired during Phase 2 once capital milestones are reached.',
                        style: TextStyle(fontSize: 14, height: 1.5),
                      ),
                      const SizedBox(height: 16),

                      // Captain
                      _CharacterCard(
                        name: 'Captain',
                        icon: Icons.sailing,
                        iconColor: const Color(0xFF0288D1),
                        role: 'Navigator',
                        ability: 'Adds +1 ship movement to every dice roll',
                        rules: ['Pay 100 per turn to use ability'],
                        activationCost: '100 per turn',
                        isExpanded: _expandedCards['captain'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['captain'] =
                                !(_expandedCards['captain'] ?? false);
                          });
                        },
                      ),
                      const SizedBox(height: 12),

                      // Builder
                      _CharacterCard(
                        name: 'Builder',
                        icon: Icons.construction,
                        iconColor: const Color(0xFFFF9800),
                        role: 'Construction Expert',
                        ability: 'Build one extra house per turn',
                        rules: [
                          'Butler must also be active',
                          'Stacks with Director-General bonus',
                        ],
                        activationCost: '100 per turn',
                        isExpanded: _expandedCards['builder'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['builder'] =
                                !(_expandedCards['builder'] ?? false);
                          });
                        },
                      ),
                      const SizedBox(height: 12),

                      // Trader
                      _CharacterCard(
                        name: 'Trader',
                        icon: Icons.swap_horiz,
                        iconColor: const Color(0xFF9C27B0),
                        role: 'Negotiator',
                        ability:
                            'Trade one card from your hand with one random card from an opponent',
                        rules: [
                          'You choose which card to give',
                          'Opponent\'s card is taken without looking',
                        ],
                        activationCost: '100 per turn',
                        isExpanded: _expandedCards['trader'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['trader'] =
                                !(_expandedCards['trader'] ?? false);
                          });
                        },
                      ),
                      const SizedBox(height: 12),

                      // Spy
                      _CharacterCard(
                        name: 'Spy',
                        icon: Icons.visibility,
                        iconColor: const Color(0xFF607D8B),
                        role: 'Informant',
                        ability: 'Look at one opponent\'s hand per turn',
                        rules: [
                          'Information gained may be used freely',
                          'No cost to look beyond activation fee',
                        ],
                        activationCost: '100 per turn',
                        isExpanded: _expandedCards['spy'] ?? false,
                        onToggle: () {
                          setState(() {
                            _expandedCards['spy'] =
                                !(_expandedCards['spy'] ?? false);
                          });
                        },
                      ),
                      const SizedBox(height: 24),

                      // Jack Rules Summary
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
                              'Jack Rules Summary',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildWhiteBullet(
                              'Jacks start inactive and face-down',
                            ),
                            _buildWhiteBullet(
                              'Only one Jack may be hired per turn',
                            ),
                            _buildWhiteBullet('Hiring cost: 300'),
                            _buildWhiteBullet('Activation cost: 100 per turn'),
                            _buildWhiteBullet(
                              'Jacks remain yours even if capital drops later',
                            ),
                            _buildWhiteBullet(
                              'Wild Card: Add a Jack for Free bypasses all requirements',
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

  Widget _buildStatusRow(String label, String description) {
    return Row(
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
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 14, color: Colors.grey[800]),
          ),
        ),
      ],
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

// Character Card Widget
class _CharacterCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color iconColor;
  final String role;
  final String ability;
  final List<String> rules;
  final String? activationCost;
  final bool isExpanded;
  final VoidCallback onToggle;

  const _CharacterCard({
    required this.name,
    required this.icon,
    required this.iconColor,
    required this.role,
    required this.ability,
    required this.rules,
    this.activationCost,
    required this.isExpanded,
    required this.onToggle,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          role,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
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
                  const Text(
                    'Ability:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    ability,
                    style: const TextStyle(fontSize: 14, height: 1.5),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Rules:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ...rules.map((rule) => _buildBullet(rule)),
                  if (activationCost != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFF4CAF50),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.monetization_on,
                            size: 18,
                            color: Color(0xFF4CAF50),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Activation Cost: $activationCost',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBullet(String text) {
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
