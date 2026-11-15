import 'package:flutter/material.dart';
import 'package:galaxy_defender/ui/widgets/neon_button.dart';
import 'package:go_router/go_router.dart';

class NeonBackButon extends StatelessWidget {
  final String backRoute;
  const NeonBackButon({super.key, required this.backRoute});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: NeonButton(
        icon: Icons.arrow_back,
        margin: 8,
        onTap: () {
          context.go(backRoute);
        },
      ),
    );
  }
}
