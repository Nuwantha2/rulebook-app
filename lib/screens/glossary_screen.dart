import 'package:flutter/material.dart';
import '../services/bookmark_manager.dart';

class GlossaryScreen extends StatefulWidget {
  const GlossaryScreen({super.key});

  @override
  State<GlossaryScreen> createState() => _GlossaryScreenState();
}

class _GlossaryScreenState extends State<GlossaryScreen> {
  int _selectedIndex = 1; // Rules tab is selected
  final Map<String, bool> _expandedTerms = {};
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final BookmarkManager _bookmarkManager = BookmarkManager();

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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, String>> get _allTerms => [
    {
      'term': 'Active',
      'definition':
          'A card that is face-up and able to use its ability.\nOnly active cards count toward household size and income.',
    },
    {
      'term': 'Arrange Marriage',
      'definition':
          'An action allowing a son to marry an opponent\'s daughter, expanding the household.\nRequires the Mother to be active and at least one house built.',
    },
    {
      'term': 'Black Cards (Disasters)',
      'definition':
          'Black numbered cards representing negative events that affect households, ships, money, or houses.\nPlayed against opponents during Phase 2.',
    },
    {
      'term': 'Build Houses',
      'definition':
          'An action that places houses in your district to increase rent income.\nRequires an active Butler and a docked ship.',
    },
    {
      'term': 'Business Profit',
      'definition':
          'Money earned from the General Bank during Phase 1 based on the dice roll.\nCollected only if the Father is active.',
    },
    {
      'term': 'Captain',
      'definition':
          'A Jack that increases ship movement by +1 space per dice roll when active.',
    },
    {
      'term': 'Cards (Draw Pile)',
      'definition':
          'Each player\'s shuffled stack of remaining cards used to draw new cards during the game.',
    },
    {
      'term': 'Complete District',
      'definition':
          'A district with all 6 houses built and undamaged.\nGrants an endgame bonus.',
    },
    {
      'term': 'Director-General',
      'definition':
          'The political leader of New Amsterdam.\nGrants tax income and enhanced building abilities while held.',
    },
    {
      'term': 'Director-General Hat',
      'definition':
          'A physical token indicating which player currently holds the Director-General title.',
    },
    {
      'term': 'Disasters',
      'definition':
          'Effects caused by Black numbered cards.\nSome resolve immediately, others linger until neutralized.',
    },
    {
      'term': 'Docked Ship',
      'definition':
          'A ship that has reached the harbor.\nRequired to build houses and use certain Wild Cards.',
    },
    {
      'term': 'Draw Phase',
      'definition':
          'The step at the end of a turn where players draw new cards from their draw pile.',
    },
    {
      'term': 'Endgame Bonuses',
      'definition':
          'Extra money awarded at the end of the final round for achievements such as:\n• Complete district\n• Holding the Director-General title\n• Large household',
    },
    {
      'term': 'General Bank',
      'definition':
          'The shared supply of money tokens.\nAll payments and incomes are made to or from the bank unless stated otherwise.',
    },
    {
      'term': 'Great Investment',
      'definition':
          'A special event triggered by playing a Red Ace, allowing opponents to invest money for potential profit.',
    },
    {
      'term': 'Household',
      'definition':
          'All Kings, Queens, and Jacks belonging to a player.\nOnly active members count toward income and bonuses.',
    },
    {
      'term': 'Income',
      'definition':
          'Money gained during Phase 1 from:\n• Household size\n• Rent from houses\n• Director-General taxes',
    },
    {
      'term': 'Inactive',
      'definition':
          'A card that is face-down and unable to use its ability.\nInactive cards do not count toward income or household size.',
    },
    {
      'term': 'Jack',
      'definition':
          'A hired specialist card with unique abilities.\nIncludes Captain, Builder, Trader, and Spy.',
    },
    {
      'term': 'Joker',
      'definition':
          'A powerful card with special effects.\nRed Jokers neutralize disasters; Black Jokers damage opponents\' houses.',
    },
    {
      'term': 'Neutralization',
      'definition':
          'Canceling the effect of a disaster using:\n• A Red card of equal or higher value\n• A payment to the General Bank\n• A special ability',
    },
    {
      'term': 'Phase 1 – Roll & Reap',
      'definition':
          'The first part of a turn where players roll the dice, collect income, move ships, and resolve immediate effects.',
    },
    {
      'term': 'Phase 2 – Act & Attack',
      'definition':
          'The second part of a turn where players take actions such as building, hiring, attacking, or neutralizing disasters.',
    },
    {
      'term': 'Red Cards (Neutralizers)',
      'definition':
          'Red numbered cards used to counter Black disaster cards.\nMust match or exceed the disaster\'s value.',
    },
    {
      'term': 'Rent Income',
      'definition':
          'Money earned from undamaged houses in your district during Phase 1.',
    },
    {
      'term': 'Sickness',
      'definition':
          'A disaster that turns a household member inactive.\nCan be healed by the Housekeeper or neutralized by Red cards.',
    },
    {
      'term': 'Ship',
      'definition':
          'Each player\'s token that moves toward the harbor during Phase 1.\nResources carried by the ship are required for building houses.',
    },
    {
      'term': 'Storm Damage',
      'definition':
          'A disaster that damages a house, preventing rent income until repaired.',
    },
    {
      'term': 'Tiebreaker',
      'definition':
          'A sequence of checks used if players tie at the end of the game:\n• Most active houses\n• Largest active household\n• Most Jacks hired\n• Pre-bonus capital\n• Final dice roll',
    },
    {
      'term': 'Wild Cards',
      'definition':
          'Special cards drawn on a natural roll of 4.\nProvide powerful one-time effects and return to the pile after use.',
    },
  ];

  List<Map<String, String>> get _filteredTerms {
    if (_searchQuery.isEmpty) {
      return _allTerms;
    }
    return _allTerms
        .where(
          (term) =>
              term['term']!.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
              term['definition']!.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ),
        )
        .toList();
  }

  Map<String, List<Map<String, String>>> get _groupedTerms {
    final Map<String, List<Map<String, String>>> grouped = {};
    for (var term in _filteredTerms) {
      final firstLetter = term['term']![0].toUpperCase();
      if (!grouped.containsKey(firstLetter)) {
        grouped[firstLetter] = [];
      }
      grouped[firstLetter]!.add(term);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final sortedKeys = _groupedTerms.keys.toList()..sort();

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
                          'Glossary',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Terms & definitions',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
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
                  hintText: 'Search rules, cards, terms...',
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

            // Info text
            if (_searchQuery.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  'Tap a term to view its full explanation and related rules.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),

            // Scrollable content
            Expanded(
              child: _filteredTerms.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No terms found',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Try a different search term',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: sortedKeys.length,
                      itemBuilder: (context, index) {
                        final letter = sortedKeys[index];
                        final terms = _groupedTerms[letter]!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Letter header
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              color: const Color(0xFFE8E5DB),
                              child: Text(
                                letter,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2C4558),
                                ),
                              ),
                            ),
                            // Terms
                            ...terms.map(
                              (term) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 6,
                                ),
                                child: _GlossaryTerm(
                                  term: term['term']!,
                                  definition: term['definition']!,
                                  isExpanded:
                                      _expandedTerms[term['term']!] ?? false,
                                  onToggle: () {
                                    setState(() {
                                      _expandedTerms[term['term']!] =
                                          !(_expandedTerms[term['term']!] ??
                                              false);
                                    });
                                  },
                                  onBookmark: () {
                                    setState(() {
                                      _bookmarkManager.toggleTermBookmark(
                                        term['term']!,
                                      );
                                    });
                                  },
                                  isBookmarked: _bookmarkManager
                                      .isTermBookmarked(term['term']!),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
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

// Glossary Term Widget
class _GlossaryTerm extends StatelessWidget {
  final String term;
  final String definition;
  final bool isExpanded;
  final VoidCallback onToggle;
  final VoidCallback onBookmark;
  final bool isBookmarked;

  const _GlossaryTerm({
    required this.term,
    required this.definition,
    required this.isExpanded,
    required this.onToggle,
    required this.onBookmark,
    required this.isBookmarked,
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
                  Expanded(
                    child: Text(
                      term,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                      size: 20,
                    ),
                    color: const Color(0xFF5B8FA3),
                    onPressed: () {
                      onBookmark();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            !isBookmarked
                                ? 'Bookmarked: $term'
                                : 'Removed bookmark: $term',
                          ),
                          duration: const Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 8),
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
                  const SizedBox(height: 12),
                  Text(
                    definition,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
