import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy_defender/ui/widgets/neon_button.dart';

class PauseButtonOverlay extends StatelessWidget {
  static final String overlayKey = "PauseButtonOverlay";
  const PauseButtonOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: NeonButton(icon: Icons.pause, onTap: () {}),
    );
  }
}
