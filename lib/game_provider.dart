import 'package:app/data/prompts.dart';
import 'package:app/models/models.dart';
import 'package:app/pages/scene_widget.dart';
import 'package:app/pages/splash_page.dart';
import 'package:app/services/openai_service.dart';
import 'package:app/services/replicate_service.dart';
import 'package:flutter/material.dart';

class GameProvider extends ChangeNotifier {
  Map<int, Future<Map<String, dynamic>>> sceneBuffer = {};
  List<Future<Scene>> buff = [];
  String background = "https://via.placeholder.com/1080";
  bool generatingGame = true;
  int currentSceneIndex = 0;
  GameData? _data;
  GameData? get data => _data;

  Future<GameData> init(String name, String gender) async {
    _data = _data ?? (await createGameData(name, gender));
    background = _data!.splashImage!;
    generatingGame = false;
    notifyListeners();
    return _data!;
  }

  Future<Scene> generateScene(int? choice) async {
    /* Generates a scene if `choice` was made at current situation */
    var prompt =
        scenePrompt(_data!.lore, _data!.scenes, _data!.lastScene(), choice);
    var response = await getJsonCompletion(prompt);
    _data!.player.modifyFromJson(response);

    response = {
      ...response,
      "backgroundImage": await Replicate.getImage(response['backgroundImage']),
    };

    var scene = Scene.fromJson(response);
    return scene;
  }

  addNextScene(int? choice, {Future<Scene>? s}) async {
    Scene scene;
    if (s == null) {
      scene = await generateScene(choice);
    } else {
      scene = await s;
    }
    background = scene.backgroundImage;
    _data!.scenes.add(scene);

    // start rendering this scene's options
    buff = [];
    for (int i = 0; i < scene.options.length; i++) {
      buff.add(generateScene(i)); // repeating the same for all.
    }

    generatingGame = false;
    notifyListeners();
  }

  showNextPage({int? choice}) async {
    currentSceneIndex++;
    if (currentSceneIndex > 1) {
      generatingGame = true;
      if (currentSceneIndex == 2) {
        addNextScene(choice);
      } else {
        addNextScene(choice, s: buff[choice!]);
      }
    }
    notifyListeners();
  }

  Widget currentScreen() {
    if (generatingGame) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_data == null) {
      return const Center(child: Text("An Error Occured"));
    }

    if (currentSceneIndex == 0) {
      return SplashPage(data: _data!);
    } else if (currentSceneIndex == 1) {
      return SceneWidget(
          scene: Scene(
              description: _data!.lore,
              options: [],
              backgroundImage: _data!.splashImage!));
    }
    return SceneWidget(scene: _data!.scenes.elementAt(currentSceneIndex - 2));
  }
}