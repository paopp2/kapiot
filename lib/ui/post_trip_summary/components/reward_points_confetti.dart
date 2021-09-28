import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class RewardPointsConfetti extends StatefulWidget {
  const RewardPointsConfetti({
    Key? key,
    required this.constraints,
  }) : super(key: key);

  final BoxConstraints constraints;

  @override
  State<RewardPointsConfetti> createState() => _RewardPointsConfettiState();
}

class _RewardPointsConfettiState extends State<RewardPointsConfetti> {
  final confettiController = ConfettiController(
    duration: const Duration(seconds: 2),
  );

  @override
  initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((_) {
      confettiController.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.constraints.maxHeight * 0.175,
      left: widget.constraints.maxWidth / 2,
      child: ConfettiWidget(
        confettiController: confettiController,
        blastDirectionality: BlastDirectionality.explosive,
        numberOfParticles: 20,
        colors: const [
          Color(0xffdbb3d4),
          Color(0xffe5d392),
        ],
      ),
    );
  }
}
