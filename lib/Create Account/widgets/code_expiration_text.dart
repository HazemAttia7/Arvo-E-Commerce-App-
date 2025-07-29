import 'dart:async';
import 'package:flutter/material.dart';

class CodeExpirationText extends StatefulWidget {
  final int durationInSeconds;
  final Function() onTimerEnd;
  final Function() onTimerStart;

  const CodeExpirationText({
    super.key,
    required this.durationInSeconds,
    required this.onTimerEnd,
    required this.onTimerStart,
  });

  @override
  State<CodeExpirationText> createState() => CodeExpirationTextState();
}

class CodeExpirationTextState extends State<CodeExpirationText> {
  late Timer _timer;
  late int _remainingSeconds;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.durationInSeconds;
    _startTimer();
  }

  void _startTimer() {
    widget.onTimerStart();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        if (mounted) {
          setState(() {
            _remainingSeconds--;
          });
        }
      } else {
        _timer.cancel();
        if (mounted) {
          widget.onTimerEnd();
        }
      }
    });
  }

  void restartTimer() {
    widget.onTimerStart();
    _timer.cancel();
    setState(() {
      _remainingSeconds = widget.durationInSeconds;
    });
    _startTimer();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          if (_remainingSeconds > 0) ...[
            const TextSpan(
              text: 'Code expires in: ',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: _formatTime(_remainingSeconds),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black, // Timer countdown is BLACK
                fontWeight: FontWeight.w500,
              ),
            ),
          ] else ...[
            const TextSpan(
              text: 'You can now resend OTP',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
