class BookmarkManager {
  static final BookmarkManager _instance = BookmarkManager._internal();
  factory BookmarkManager() => _instance;
  BookmarkManager._internal();

  final Set<String> _bookmarkedRules = {};
  final Set<String> _bookmarkedCards = {};
  final Set<String> _bookmarkedTerms = {};

  // Rules
  Set<String> get bookmarkedRules => Set.from(_bookmarkedRules);
  bool isRuleBookmarked(String rule) => _bookmarkedRules.contains(rule);
  void toggleRuleBookmark(String rule) {
    if (_bookmarkedRules.contains(rule)) {
      _bookmarkedRules.remove(rule);
    } else {
      _bookmarkedRules.add(rule);
    }
  }

  // Cards
  Set<String> get bookmarkedCards => Set.from(_bookmarkedCards);
  bool isCardBookmarked(String card) => _bookmarkedCards.contains(card);
  void toggleCardBookmark(String card) {
    if (_bookmarkedCards.contains(card)) {
      _bookmarkedCards.remove(card);
    } else {
      _bookmarkedCards.add(card);
    }
  }

  // Terms
  Set<String> get bookmarkedTerms => Set.from(_bookmarkedTerms);
  bool isTermBookmarked(String term) => _bookmarkedTerms.contains(term);
  void toggleTermBookmark(String term) {
    if (_bookmarkedTerms.contains(term)) {
      _bookmarkedTerms.remove(term);
    } else {
      _bookmarkedTerms.add(term);
    }
  }

  // Clear all
  void clearAllRules() => _bookmarkedRules.clear();
  void clearAllCards() => _bookmarkedCards.clear();
  void clearAllTerms() => _bookmarkedTerms.clear();
  void clearAll() {
    _bookmarkedRules.clear();
    _bookmarkedCards.clear();
    _bookmarkedTerms.clear();
  }
}
