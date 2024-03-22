class Scene {
  final String description;
  final List<String> options;
  final String backgroundImage;

  toJson() {
    return {
      "description": description,
      "options": options,
    };
  }

  factory Scene.fromJson(Map<String, dynamic> json) {
    return Scene(
        description: json['description'],
        backgroundImage: json['backgroundImage'],
        options: (json['options'] as List<dynamic>)
            .map((e) => e.toString())
            .toList());
  }

  Scene(
      {required this.description,
      required this.options,
      required this.backgroundImage});
}

class Player {
  final List<String> inventory = [];
  int health = 100;
  int distance = 0;

  Player();

  toJson() {
    return {
      "inventory": inventory,
      "health": health,
      "distance": distance,
    };
  }

  modifyFromJson(Map<String, dynamic> json) {
    health = json['health'];
    distance = json['distance'];
    inventory.clear();
    var k =
        (json['inventory'] as List<dynamic>).map((e) => e.toString()).toList();
    inventory.addAll(k);
  }

  decrementHealth({int amt = 10}) {
    health -= amt;
  }

  addToInventory(String item) {
    inventory.add(item);
  }

  removeFromInventory(String item) {
    inventory.remove(item);
  }
}

class GameData {
  final Player player = Player();
  final String title;
  final String lore;
  final String splashImagePrompt;
  final String? splashImage;
  final String titleFont;
  final List<String> storyTillNow = [];
  final List<Scene> scenes = [];

  GameData({
    this.lore = 'Error',
    this.splashImagePrompt = 'Error',
    this.title = 'Error',
    this.titleFont = 'Roboto',
    this.splashImage,
  });

  Map<String, dynamic> lastScene() {
    if (scenes.isEmpty) {
      return player.toJson();
    }
    return {
      ...player.toJson(),
      ...scenes.last.toJson(),
    };
  }

  factory GameData.fromJson(Map<String, dynamic> json) {
    return GameData(
      title: json['gametitle'],
      titleFont: json['gametitlefont'],
      lore: json['lore'],
      splashImagePrompt: json['prompt'] ?? 'Error',
      splashImage: json['gameScreen'],
    );
  }

  GameData copyWith({
    String? title,
    String? lore,
    String? titleFont,
    String? splashImagePrompt,
    String? splashImage,
    String? font,
  }) {
    return GameData(
      titleFont: font ?? this.titleFont,
      title: title ?? this.title,
      lore: lore ?? this.lore,
      splashImagePrompt: splashImagePrompt ?? this.splashImagePrompt,
      splashImage: splashImage ?? this.splashImage,
    );
  }
}