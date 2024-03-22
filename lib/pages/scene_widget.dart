import 'package:app/game_provider.dart';
import 'package:app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SceneWidget extends StatelessWidget {
  const SceneWidget({super.key, required this.scene});
  final Scene scene;

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider = Provider.of<GameProvider>(context);
    Widget nextButton = scene.options.isEmpty
        ? ElevatedButton(
            onPressed: gameProvider.showNextPage, child: const Text("Next"))
        : const SizedBox();

    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black.withOpacity(0.6)),
        constraints: const BoxConstraints(minHeight: 500, maxWidth: 1000),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(scene.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
              const SizedBox(
                height: 30,
              ),
              ...scene.options
                  .asMap()
                  .entries
                  .map((e) => _SceneOption(option: e.value, index: e.key))
                  .toList(),
              nextButton
            ],
          ),
        ));
  }
}

class _SceneOption extends StatefulWidget {
  const _SceneOption({required this.option, required this.index});
  final String option;
  final int index;

  @override
  State<_SceneOption> createState() => _SceneOptionState();
}

class _SceneOptionState extends State<_SceneOption> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider = Provider.of<GameProvider>(context);
    return InkWell(
      onHover: (value) {
        setState(() {
          isHovering = value;
        });
      },
      onTap: () => gameProvider.showNextPage(choice: widget.index),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: isHovering
                    ? Colors.white.withOpacity(0.5)
                    : Colors.white.withOpacity(0.2)),
            color: isHovering
                ? Colors.white.withOpacity(0.2)
                : Colors.white.withOpacity(0.1)),
        width: double.infinity,
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(20),
        child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.topLeft,
            child: Text(
              widget.option,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            )),
      ),
    );
  }
}
