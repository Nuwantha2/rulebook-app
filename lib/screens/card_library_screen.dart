import 'package:flutter/material.dart';
import '../services/bookmark_manager.dart';

class CardLibraryScreen extends StatefulWidget {
  const CardLibraryScreen({super.key});

  @override
  State<CardLibraryScreen> createState() => _CardLibraryScreenState();
}

class _CardLibraryScreenState extends State<CardLibraryScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 3; // Cards tab is selected
  late TabController _tabController;
  final BookmarkManager _bookmarkManager = BookmarkManager();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Card Library',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'All Cards at a Glance',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Browse every card in Harbour of Fortune.\nTap a card to view its full effect, neutralization rules, and special notes.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Search bar
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              color: const Color(0xFFF7F4ED),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search by name or number...',
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF5B8FA3),
                  ),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),

            // Tab Bar
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                labelColor: const Color(0xFF2C4558),
                unselectedLabelColor: Colors.grey,
                indicatorColor: const Color(0xFF2C4558),
                indicatorWeight: 3,
                isScrollable: true,
                tabs: const [
                  Tab(text: '🖤 Black'),
                  Tab(text: '❤️ Red'),
                  Tab(text: '🃏 Jokers'),
                  Tab(text: '🌟 Wild'),
                ],
              ),
            ),

            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildBlackCardsTab(),
                  _buildRedCardsTab(),
                  _buildJokersTab(),
                  _buildWildCardsTab(),
                ],
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
              icon: Icon(Icons.style),
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

  Widget _buildBlackCardsTab() {
    final cards = _getBlackCards();
    final filteredCards = _filterCards(cards);

    return _buildCardGrid(
      filteredCards,
      'Black Cards — Disasters',
      'Cards that harm opponents by affecting households, ships, money, or houses.',
      const Color(0xFF2C2C2C),
    );
  }

  Widget _buildRedCardsTab() {
    final cards = _getRedCards();
    final filteredCards = _filterCards(cards);

    return _buildCardGrid(
      filteredCards,
      'Red Cards — Neutralizers',
      'Cards used to counter Black disasters. Must match or exceed disaster\'s value.',
      const Color(0xFFE53935),
    );
  }

  Widget _buildJokersTab() {
    final cards = _getJokers();
    final filteredCards = _filterCards(cards);

    return _buildCardGrid(
      filteredCards,
      'Jokers — Wild Forces',
      'Powerful one-off cards with dramatic effects.',
      const Color(0xFF9C27B0),
    );
  }

  Widget _buildWildCardsTab() {
    final cards = _getWildCards();
    final filteredCards = _filterCards(cards);

    return _buildCardGrid(
      filteredCards,
      'Wild Cards — Game Changers',
      'Special effects drawn on a natural roll of 4. Returned to pile after use.',
      const Color(0xFFD4AF37),
    );
  }

  Widget _buildCardGrid(
    List<Map<String, String>> cards,
    String title,
    String description,
    Color accentColor,
  ) {
    if (cards.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 64, color: Colors.grey[300]),
              const SizedBox(height: 16),
              Text(
                'No cards found for this filter',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Try a different search term',
                style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        // Category Header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: accentColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accentColor.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Cards Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemCount: cards.length,
          itemBuilder: (context, index) {
            return _CardTile(
              card: cards[index],
              accentColor: accentColor,
              isBookmarked: _bookmarkManager.isCardBookmarked(
                cards[index]['name']!,
              ),
              onTap: () => _showCardDetails(cards[index], accentColor),
              onBookmark: () {
                setState(() {
                  _bookmarkManager.toggleCardBookmark(cards[index]['name']!);
                });
              },
            );
          },
        ),
      ],
    );
  }

  List<Map<String, String>> _filterCards(List<Map<String, String>> cards) {
    if (_searchQuery.isEmpty) return cards;
    return cards
        .where(
          (card) =>
              card['name']!.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
              card['number']!.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ),
        )
        .toList();
  }

  void _showCardDetails(Map<String, String> card, Color accentColor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _CardDetailSheet(
        card: card,
        accentColor: accentColor,
        isBookmarked: _bookmarkManager.isCardBookmarked(card['name']!),
        onBookmark: () {
          setState(() {
            _bookmarkManager.toggleCardBookmark(card['name']!);
          });
        },
      ),
    );
  }

  // Card Data
  List<Map<String, String>> _getBlackCards() => [
    {
      'name': 'Black Ace – Misfortune',
      'number': '1',
      'type': 'Disaster',
      'effect':
          'Target opponent loses their next income collection from households.',
      'neutralize': 'Red Ace or higher',
      'image':
          'assets/images/black/Kaart-symbols-voor-appSpades_0000_Laag-10.png',
    },
    {
      'name': 'Black 2 – Business Failure',
      'number': '2',
      'type': 'Disaster',
      'effect':
          'Target opponent\'s Father becomes inactive. No business profit until healed.',
      'neutralize': 'Red 2 or higher, or Housekeeper ability',
      'image':
          'assets/images/black/Kaart-symbols-voor-appSpades_0001_Laag-11.png',
    },
    {
      'name': 'Black 3 – Pirate Raid',
      'number': '3',
      'type': 'Disaster',
      'effect':
          'If target opponent\'s ship is at sea, it returns to start position.',
      'neutralize': 'Red 3 or higher, or Captain Jack ability',
      'image':
          'assets/images/black/Kaart-symbols-voor-appSpades_0002_Laag-12.png',
    },
    {
      'name': 'Black 4 – Sickness',
      'number': '4',
      'type': 'Disaster',
      'effect':
          'Choose one household member of target opponent. That member becomes inactive.',
      'neutralize': 'Red 4 or higher, or Housekeeper ability',
      'image':
          'assets/images/black/Kaart-symbols-voor-appSpades_0003_Laag-13.png',
    },
    {
      'name': 'Black 5 – Divorce',
      'number': '5',
      'type': 'Disaster',
      'effect':
          'Target opponent must discard one married daughter if they have any.',
      'neutralize': 'Red 5 or higher, or Mother\'s protection',
      'image':
          'assets/images/black/Kaart-symbols-voor-appSpades_0004_Laag-14.png',
    },
    {
      'name': 'Black 6 – Bribe Demand',
      'number': '6',
      'type': 'Disaster',
      'effect': 'Target opponent must pay 500 money to the General Bank.',
      'neutralize': 'Red 6 or higher, or Trader Jack ability',
      'image':
          'assets/images/black/Kaart-symbols-voor-appSpades_0005_Laag-15.png',
    },
    {
      'name': 'Black 7 – Theft',
      'number': '7',
      'type': 'Disaster',
      'effect': 'Target opponent loses 1000 money to the General Bank.',
      'neutralize': 'Red 7 or higher',
      'image':
          'assets/images/black/Kaart-symbols-voor-appSpades_0006_Laag-16.png',
    },
    {
      'name': 'Black 8 – Storm Damage',
      'number': '8',
      'type': 'Disaster',
      'effect':
          'Damage one of target opponent\'s houses. It provides no rent until repaired.',
      'neutralize': 'Red 8 or higher, or Builder Jack ability',
      'image':
          'assets/images/black/Kaart-symbols-voor-appSpades_0007_Laag-17.png',
    },
    {
      'name': 'Black 9 – Infestation',
      'number': '9',
      'type': 'Disaster',
      'effect': 'Target opponent must pay 1500 to the bank or lose one house.',
      'neutralize': 'Red 9 or higher',
      'image':
          'assets/images/black/Kaart-symbols-voor-appSpades_0008_Laag-18.png',
    },
    {
      'name': 'Black 10 – House Fire',
      'number': '10',
      'type': 'Disaster',
      'effect':
          'Destroy one of target opponent\'s houses. It is removed from the board.',
      'neutralize': 'Red 10 or higher, or Red Joker',
      'image':
          'assets/images/black/Kaart-symbols-voor-appSpades_0009_Laag-19.png',
    },
  ];

  List<Map<String, String>> _getRedCards() => [
    {
      'name': 'Red 2',
      'number': '2',
      'type': 'Neutralizer',
      'effect': 'Cancels Black 2 (Business Failure) or lower disasters.',
      'neutralize': 'Automatic when played',
      'image':
          'assets/images/red/Kaart-symbols-voor-appHearts_0001_Laag-11-kopie-2.png',
    },
    {
      'name': 'Red 3',
      'number': '3',
      'type': 'Neutralizer',
      'effect': 'Cancels Black 3 (Pirate Raid) or lower disasters.',
      'neutralize': 'Automatic when played',
      'image':
          'assets/images/red/Kaart-symbols-voor-appHearts_0002_Laag-12-kopie-2.png',
    },
    {
      'name': 'Red 4',
      'number': '4',
      'type': 'Neutralizer',
      'effect': 'Cancels Black 4 (Sickness) or lower disasters.',
      'neutralize': 'Automatic when played',
      'image':
          'assets/images/red/Kaart-symbols-voor-appHearts_0003_Laag-13-kopie-2.png',
    },
    {
      'name': 'Red 5',
      'number': '5',
      'type': 'Neutralizer',
      'effect': 'Cancels Black 5 (Divorce) or lower disasters.',
      'neutralize': 'Automatic when played',
      'image':
          'assets/images/red/Kaart-symbols-voor-appHearts_0004_Laag-14-kopie-2.png',
    },
    {
      'name': 'Red 6',
      'number': '6',
      'type': 'Neutralizer',
      'effect': 'Cancels Black 6 (Bribe Demand) or lower disasters.',
      'neutralize': 'Automatic when played',
      'image':
          'assets/images/red/Kaart-symbols-voor-appHearts_0005_Laag-15-kopie-2.png',
    },
    {
      'name': 'Red 7',
      'number': '7',
      'type': 'Neutralizer',
      'effect': 'Cancels Black 7 (Theft) or lower disasters.',
      'neutralize': 'Automatic when played',
      'image':
          'assets/images/red/Kaart-symbols-voor-appHearts_0006_Laag-16-kopie-2.png',
    },
    {
      'name': 'Red 8',
      'number': '8',
      'type': 'Neutralizer',
      'effect': 'Cancels Black 8 (Storm Damage) or lower disasters.',
      'neutralize': 'Automatic when played',
      'image':
          'assets/images/red/Kaart-symbols-voor-appHearts_0007_Laag-17-kopie-2.png',
    },
    {
      'name': 'Red 9',
      'number': '9',
      'type': 'Neutralizer',
      'effect': 'Cancels Black 9 (Infestation) or lower disasters.',
      'neutralize': 'Automatic when played',
      'image':
          'assets/images/red/Kaart-symbols-voor-appHearts_0008_Laag-18-kopie-2.png',
    },
    {
      'name': 'Red 10',
      'number': '10',
      'type': 'Neutralizer',
      'effect': 'Cancels any Black numbered disaster card.',
      'neutralize': 'Automatic when played',
      'image':
          'assets/images/red/Kaart-symbols-voor-appHearts_0009_Laag-19-kopie-2.png',
    },
  ];

  List<Map<String, String>> _getJokers() => [
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

  List<Map<String, String>> _getWildCards() => [
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

// Card Tile Widget
class _CardTile extends StatelessWidget {
  final Map<String, String> card;
  final Color accentColor;
  final bool isBookmarked;
  final VoidCallback onTap;
  final VoidCallback onBookmark;

  const _CardTile({
    required this.card,
    required this.accentColor,
    required this.isBookmarked,
    required this.onTap,
    required this.onBookmark,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = card['image'] != null && card['image']!.isNotEmpty;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: accentColor.withOpacity(0.3), width: 2),
          boxShadow: [
            BoxShadow(
              color: accentColor.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card header with bookmark
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      card['number']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onBookmark,
                    child: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),

            // Card image (if available)
            if (hasImage)
              Expanded(
                flex: 3,
                child: ClipRRect(
                  child: Image.asset(
                    card['image']!,
                    width: double.infinity,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: accentColor.withOpacity(0.1),
                        child: Icon(Icons.style, size: 40, color: accentColor),
                      );
                    },
                  ),
                ),
              ),

            // Card content
            Expanded(
              flex: hasImage ? 2 : 3,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        card['name']!,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        card['type']!,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
  final bool isBookmarked;
  final VoidCallback onBookmark;

  const _CardDetailSheet({
    required this.card,
    required this.accentColor,
    required this.isBookmarked,
    required this.onBookmark,
  });

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
                      child: Row(
                        children: [
                          Expanded(
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
                          IconButton(
                            onPressed: () {
                              onBookmark();
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              isBookmarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_outline,
                              color: Colors.white,
                              size: 28,
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
