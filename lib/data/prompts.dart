import 'dart:convert';

import 'package:app/models/models.dart';

List<String> genres = [
  "Fiction",
  "Nonfiction",
  "Poetry",
  "Drama",
  "Fantasy",
  "High Fantasy",
  "Urban Fantasy",
  "Dark Fantasy",
  "Science Fiction",
  "Hard Science Fiction",
  "Soft Science Fiction",
  "Space Opera",
  "Dystopian",
  "Historical Fiction",
  "Romance",
  "Contemporary Romance",
  "Historical Romance",
  "Paranormal Romance",
  "Mystery",
  "Thriller",
  "Cozy Mystery",
  "Detective",
  "Horror",
  "Gothic Horror",
  "Psychological Horror",
  "Young Adult",
  "Children's Literature",
  "Biography",
  "History",
  "Science",
  "Self-Help",
  "Travel Writing",
  "Literary Fiction",
  "Graphic Novel",
  "Speculative Fiction",
  "Magical Realism",
  "Fanfiction"
];

String getLorePrompt(String name, String gender) {
  return """
You are a very creative and unique script writer. Your job is to write and play through an adventure game with the player the details of which will be shared below. So, let's take the player on a journey of a story that they'd love to play.
Keep the story UNIQUE, INTERESTING and OUT-OF-THE-BOX.

---
Player name: $name
Player Gender: $gender

---
Pick any genre of ${genres.join(", ")}

Write an interesting lore of the setting we are in and how the player ended up in this situation, within the lore mention a challenging and interesting aim for the player.
Along with that give a prompt that can be used to generate the cover image for this game and a title for this game. For the title, give an appropriate Google Font that I can use to render the text.
Return your response in a json format

{
  "gametitle":"",
  "gametitlefont":"",
  "lore": "",
  "prompt": ""
}

""";
}

String scenePrompt(String lore, List<Scene> scenes, Map lastScene, int? userChoice) {
  return """
You are a very creative and unique script writer. Your job is to write and play through an adventure game with the player the details of which will be shared below. So, let's take the player on a journey of a story that they'd love to play.
Keep the story UNIQUE, INTERESTING and OUT-OF-THE-BOX.


PROLOGUE
---
$lore
---

STORY TILL NOW
---
{
  "story-till-now":[
    ${scenes.sublist(0, (scenes.length-1).clamp(0, 9999)).map((e) => '"${e.description}"').join(",")}
  ],
  "last-scene": ${jsonEncode(lastScene)}
  ${(scenes.isEmpty || userChoice == null) ? "" : "user-choice: $userChoice"}
}
---

You'll be playing through with the player and for each "scene" you have to return a JSON formatted response with the following fields ONLY:
{
    "description": "Describe the environment in as much detail as possible while still using a very easy-to-understand language. The aim is to fully immerse the reader",
    "options":[
        "List out appropriate number (3-5) of meaningful actions that the player can take in this situation"
    ],
    "inventory":[], // Current inventory of the player
    "distance":0, // number of decisions they have made till now (scenes crossed)
    "backgroundImage": "Describe the background image that can be used for this scene in as much detail as possible so as to encapsulate the environment.",
    "health": 100
}
The player should also have a developing inventory with items they can use later in the game. Make sure you create scenarios where the player can make use of their inventory. You can also block access to certain places unless the player has a particular item in their inventory. They can then search for the item through further exploration.

The player can also run against enemies villains or threats. These threats can reduce the health of the player or cause them to lose certain items from the inventory. If a player reaches 0 health, they perish and the game ends. Feel free to create NPC's with whom the player can interact through dialogs.

When the game ends, either by 0 health or by finishing, simply return your response without any choseable options.

You must start wrapping up the game after 10 decisions.
Let's start with the next scene
---
""";
}
