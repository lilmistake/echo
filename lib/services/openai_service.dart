import 'dart:convert';
import 'package:app/models/models.dart';
import 'package:app/data/prompts.dart';
import 'package:app/services/replicate_service.dart';
import 'package:dart_openai/dart_openai.dart';

Future<Map<String, dynamic>> getJsonCompletion(String prompt) async {
  var response = await OpenAI.instance.chat
      .create(model: "gpt-4-turbo-preview", responseFormat: {
    "type": "json_object"
  }, messages: [
    OpenAIChatCompletionChoiceMessageModel(
      content: [OpenAIChatCompletionChoiceMessageContentItemModel.text(prompt)],
      role: OpenAIChatMessageRole.system,
    ),
  ]);
  return jsonDecode(response.choices.first.message.content?.first.text ?? "{}");
}

Future<GameData> createGameData(String name, String gender) async {
  var lorePrompt = getLorePrompt(name, gender);
  var response = await getJsonCompletion(lorePrompt);
  GameData gameData = GameData.fromJson(response);
  var image = await Replicate.getImage(gameData.splashImagePrompt);
  return gameData.copyWith(splashImage: image);
}