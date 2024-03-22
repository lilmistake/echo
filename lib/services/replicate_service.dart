import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/main.dart';

Map<String, String> headers = {
  'Authorization': "Token $replicateKey",
  'Content-Type': "application/json"
};

class Replicate {
  static Future<dynamic> getImage(String prompt) async {
    var prediction = await create(prompt);
    var json = jsonDecode(prediction.body);
    while (!['canceled', 'succeeded', 'failed'].contains(json['status'])) {
      await Future.delayed(const Duration(milliseconds: 250));
      print("Waiting for Image...");
      prediction = await get(prediction);
      json = jsonDecode(prediction.body);
    }
    print(json['output']);
    return json['output'][0];
  }

  static Future<dynamic> get(http.Response prediction) async {
    return await http.get(Uri.parse(jsonDecode(prediction.body)['urls']['get']),
        headers: headers);
  }

  static Future<http.Response> create(String prompt) async {
    final response = await http.post(
      Uri.parse("https://api.replicate.com/v1/predictions"),
      headers: headers,
      body: jsonEncode({
        "version":
            "39ed52f2a78e934b3ba6e2a89f5b1c712de7dfea535525255b1aa35c5565e08b",
        "input": {
          "prompt": prompt,
          "negative_prompt": "",
          "width": 1920,
          "height": 1080,
          "num_outputs": 1,
          "scheduler": "K_EULER",
          "num_inference_steps": 25,
          "guidance_scale": 7.5,
          "prompt_strength": 0.8,
          "refine": "expert_ensemble_refiner",
          "lora_scale": 0.6,
          "apply_watermark": false,
          "high_noise_frac": 0.8,
        },
      }),
    );
    return response;
  }
}