import 'package:flutter/material.dart';
import '../services/bookmark_manager.dart';

class LedgerScreen extends StatefulWidget {
  const LedgerScreen({super.key});

  @override
  State<LedgerScreen> createState() => _LedgerScreenState();
}

class _LedgerScreenState extends State<LedgerScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 4; // Bookmarks tab is selected
  late TabController _tabController;
  final BookmarkManager _bookmarkManager = BookmarkManager();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
    }
  }

  void _showClearConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Bookmarks?'),
        content: const Text(
          'This will remove all saved rules, cards, and terms from your Ledger. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _bookmarkManager.clearAll();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All bookmarks cleared'),
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ledger',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Your Saved Cards & Glossary',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: Colors.white70,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'The Ledger stores the rules, cards, and terms you\'ve marked for quick reference. All items are saved locally and available offline.',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Tab Bar
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                labelColor: const Color(0xFF5B8FA3),
                unselectedLabelColor: Colors.grey,
                indicatorColor: const Color(0xFF5B8FA3),
                indicatorWeight: 3,
                tabs: const [
                  Tab(text: 'Cards'),
                  Tab(text: 'Glossary'),
                ],
              ),
            ),

            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [_buildCardsTab(), _buildGlossaryTab()],
              ),
            ),

            // Clear All Button
            if (_bookmarkManager.bookmarkedCards.isNotEmpty ||
                _bookmarkManager.bookmarkedTerms.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                color: const Color(0xFFF7F4ED),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _showClearConfirmation,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    icon: const Icon(Icons.delete_outline, size: 20),
                    label: const Text('Clear All Bookmarks'),
                  ),
                ),
              ),

            // System Note
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: const Color(0xFFF7F4ED),
              child: Text(
                'Ledger items are stored on this device only.',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
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
              icon: Icon(Icons.bookmark),
              activeIcon: Icon(Icons.bookmark),
              label: 'Bookmarks',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardsTab() {
    final cards = _bookmarkManager.bookmarkedCards.toList();

    if (cards.isEmpty) {
      return _buildEmptyState(
        icon: Icons.style_outlined,
        title: 'No saved cards yet',
        subtitle: 'Save cards you often look up during play.',
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final cardName = cards[index];
        final cardData = _getCardData(cardName);
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _CardItem(
            name: cardName,
            type: cardData?['type'] ?? 'Card',
            onTap: () {
              if (cardData != null) {
                _showCardDetails(cardData, _getCardColor(cardData['type']!));
              }
            },
            onLongPress: () {
              setState(() {
                _bookmarkManager.toggleCardBookmark(cardName);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Removed from Ledger: $cardName'),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildGlossaryTab() {
    final terms = _bookmarkManager.bookmarkedTerms.toList();

    if (terms.isEmpty) {
      return _buildEmptyState(
        icon: Icons.menu_book_outlined,
        title: 'No saved terms yet',
        subtitle: 'Save glossary entries to resolve rules faster.',
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: terms.length,
      itemBuilder: (context, index) {
        final term = terms[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _TermItem(
            term: term,
            preview: _getTermPreview(term),
            onTap: () {
              Navigator.pushNamed(context, '/glossary');
            },
            onLongPress: () {
              setState(() {
                _bookmarkManager.toggleTermBookmark(term);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Removed from Ledger: $term'),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String _getTermPreview(String term) {
    final definitions = {
      'Active': 'A card that is face-up and able to use its ability.',
      'Inactive': 'A card that is face-down and unable to use its ability.',
      'Neutralization': 'Canceling the effect of a disaster using...',
      'Docked Ship': 'A ship that has reached the harbor.',
      'Complete District': 'A district with all 6 houses built and undamaged.',
    };
    return definitions[term] ?? 'Quick reference definition';
  }

  Map<String, String>? _getCardData(String cardName) {
    final allCards = [
      ..._getAllBlackCards(),
      ..._getAllRedCards(),
      ..._getAllJokers(),
      ..._getAllWildCards(),
    ];

    try {
      return allCards.firstWhere((card) => card['name'] == cardName);
    } catch (e) {
      return null;
    }
  }

  Color _getCardColor(String type) {
    if (type == 'Disaster') return const Color(0xFF2C2C2C);
    if (type == 'Neutralizer') return const Color(0xFFE53935);
    if (type == 'Joker') return const Color(0xFF9C27B0);
    if (type == 'Wild Card') return const Color(0xFFD4AF37);
    return const Color(0xFF5B8FA3);
  }

  void _showCardDetails(Map<String, String> card, Color accentColor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          _CardDetailSheet(card: card, accentColor: accentColor),
    );
  }

  // Card Data
  List<Map<String, String>> _getAllBlackCards() => [
    {
      'name': 'Black Ace – Misfortune',
      'number': '1',
      'type': 'Disaster',
      'effect':
          'Target opponent loses their next income collection from households.',
      'neutralize': 'Red Ace or higher',
    },
    {
      'name': 'Black 2 – Business Failure',
      'number': '2',
      'type': 'Disaster',
      'effect':
          'Target opponent\'s Father becomes inactive. No business profit until healed.',
      'neutralize': 'Red 2 or higher, or Housekeeper ability',
    },
    {
      'name': 'Black 3 – Pirate Raid',
      'number': '3',
      'type': 'Disaster',
      'effect':
          'If target opponent\'s ship is at sea, it returns to start position.',
      'neutralize': 'Red 3 or higher, or Captain Jack ability',
    },
    {
      'name': 'Black 4 – Sickness',
      'number': '4',
      'type': 'Disaster',
      'effect':
          'Choose one household member of target opponent. That member becomes inactive.',
      'neutralize': 'Red 4 or higher, or Housekeeper ability',
    },
    {
      'name': 'Black 5 – Divorce',
      'number': '5',
      'type': 'Disaster',
      'effect':
          'Target opponent must discard one married daughter if they have any.',
      'neutralize': 'Red 5 or higher, or Mother\'s protection',
    },
    {
      'name': 'Black 6 – Bribe Demand',
      'number': '6',
      'type': 'Disaster',
      'effect': 'Target opponent must pay 500 money to the General Bank.',
      'neutralize': 'Red 6 or higher, or Trader Jack ability',
    },
    {
      'name': 'Black 7 – Theft',
      'number': '7',
      'type': 'Disaster',
      'effect': 'Target opponent loses 1000 money to the General Bank.',
      'neutralize': 'Red 7 or higher',
    },
    {
      'name': 'Black 8 – Storm Damage',
      'number': '8',
      'type': 'Disaster',
      'effect':
          'Damage one of target opponent\'s houses. It provides no rent until repaired.',
      'neutralize': 'Red 8 or higher, or Builder Jack ability',
    },
    {
      'name': 'Black 9 – Infestation',
      'number': '9',
      'type': 'Disaster',
      'effect': 'Target opponent must pay 1500 to the bank or lose one house.',
      'neutralize': 'Red 9 or higher',
    },
    {
      'name': 'Black 10 – House Fire',
      'number': '10',
      'type': 'Disaster',
      'effect':
          'Destroy one of target opponent\'s houses. It is removed from the board.',
      'neutralize': 'Red 10 or higher, or Red Joker',
    },
  ];

  List<Map<String, String>> _getAllRedCards() => [
    {
      'name': 'Red 2',
      'number': '2',
      'type': 'Neutralizer',
      'effect': 'Cancels Black 2 (Business Failure) or lower disasters.',
      'neutralize': 'Automatic when played',
    },
    {
      'name': 'Red 3',
      'number': '3',
      'type': 'Neutralizer',
      'effect': 'Cancels Black 3 (Pirate Raid) or lower disasters.',
      'neutralize': 'Automatic when played',
    },
    {
      'name': 'Red 4',
      'number': '4',
      'type': 'Neutralizer',
      'effect': 'Cancels Black 4 (Sickness) or lower disasters.',
      'neutralize': 'Automatic when played',
    },
    {
      'name': 'Red 5',
      'number': '5',
      'type': 'Neutralizer',
      'effect': 'Cancels Black 5 (Divorce) or lower disasters.',
      'neutralize': 'Automatic when played',
    },
    {
      'name': 'Red 6',
      'number': '6',
      'type': 'Neutralizer',
      'effect': 'Cancels Black 6 (Bribe Demand) or lower disasters.',
      'neutralize': 'Automatic when played',
    },
    {
      'name': 'Red 7',
      'number': '7',
      'type': 'Neutralizer',
      'effect': 'Cancels Black 7 (Theft) or lower disasters.',
      'neutralize': 'Automatic when played',
    },
    {
      'name': 'Red 8',
      'number': '8',
      'type': 'Neutralizer',
      'effect': 'Cancels Black 8 (Storm Damage) or lower disasters.',
      'neutralize': 'Automatic when played',
    },
    {
      'name': 'Red 9',
      'number': '9',
      'type': 'Neutralizer',
      'effect': 'Cancels Black 9 (Infestation) or lower disasters.',
      'neutralize': 'Automatic when played',
    },
    {
      'name': 'Red 10',
      'number': '10',
      'type': 'Neutralizer',
      'effect': 'Cancels any Black numbered disaster card.',
      'neutralize': 'Automatic when played',
    },
  ];

  List<Map<String, String>> _getAllJokers() => [
    {
      'name': 'Red Joker – Salvation',
      'number': 'Joker',
      'type': 'Joker',
      'effect':
          'Immediately neutralize any disaster, or heal all inactive household members.',
      'neutralize': 'Cannot be countered',
    },
    {
      'name': 'Black Joker – Saboteur\'s Wrath',
      'number': 'Joker',
      'type': 'Joker',
      'effect':
          'Destroy up to 2 houses belonging to any opponent(s). Cannot be neutralized.',
      'neutralize': 'Cannot be neutralized',
    },
  ];

  List<Map<String, String>> _getAllWildCards() => [
    {
      'name': 'Become Director-General',
      'number': 'Wild',
      'type': 'Wild Card',
      'effect':
          'Claim the Director-General Hat instantly. Previous holder loses it without compensation.',
      'neutralize': 'N/A',
    },
    {
      'name': 'Build or Repair for Free',
      'number': 'Wild',
      'type': 'Wild Card',
      'effect':
          'Build one house for free (ship must be docked), or repair one damaged house.',
      'neutralize': 'N/A',
    },
    {
      'name': 'Add a Jack for Free',
      'number': 'Wild',
      'type': 'Wild Card',
      'effect': 'Hire any available Jack without paying the hiring cost.',
      'neutralize': 'N/A',
    },
    {
      'name': 'Hero Bonus',
      'number': 'Wild',
      'type': 'Wild Card',
      'effect': 'Collect 2000 money from the General Bank immediately.',
      'neutralize': 'N/A',
    },
    {
      'name': 'Roll Twice',
      'number': 'Wild',
      'type': 'Wild Card',
      'effect':
          'Roll the dice twice on your next turn and choose which result to use.',
      'neutralize': 'N/A',
    },
  ];
}

// Card Item Widget
class _CardItem extends StatelessWidget {
  final String name;
  final String type;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _CardItem({
    required this.name,
    required this.type,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
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
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _getCardColor(type),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.style, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    type,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(Icons.bookmark, color: Colors.grey[400], size: 20),
          ],
        ),
      ),
    );
  }

  Color _getCardColor(String type) {
    if (type == 'Disaster') return Colors.black87;
    if (type == 'Neutralizer') return Colors.red;
    if (type == 'Wild Card') return const Color(0xFFD4AF37);
    return const Color(0xFF5B8FA3);
  }
}

// Term Item Widget
class _TermItem extends StatelessWidget {
  final String term;
  final String preview;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _TermItem({
    required this.term,
    required this.preview,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
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
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFFF9800).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.menu_book,
                color: Color(0xFFFF9800),
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    term,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    preview,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(Icons.bookmark, color: Colors.grey[400], size: 20),
          ],
        ),
      ),
    );
  }
}

// Card Detail Sheet
class _CardDetailSheet extends StatelessWidget {
  final Map<String, String> card;
  final Color accentColor;

  const _CardDetailSheet({required this.card, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF7F4ED),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Content
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  children: [
                    // Card header
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            card['number']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            card['name']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Card type badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: accentColor.withOpacity(0.3)),
                      ),
                      child: Text(
                        card['type']!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: accentColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Effect section
                    _buildSection(
                      'Card Effect',
                      card['effect']!,
                      Icons.stars,
                      accentColor,
                    ),
                    const SizedBox(height: 16),

                    // Neutralization section
                    _buildSection(
                      'Neutralization',
                      card['neutralize']!,
                      Icons.shield,
                      const Color(0xFF5B8FA3),
                    ),

                    const SizedBox(height: 20),

                    // Close button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accentColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Close',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSection(
    String title,
    String content,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
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
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
