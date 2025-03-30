import 'dart:math' as math; // For math calculations
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/getUserTopicsProgress_listeningPracticeHub_response_entity.dart';
import '../cubit/listeningPracticeHub_cubit.dart';
import '../cubit/listeningPracticeHub_state.dart';

class UserListeningTopicsProgressPage extends StatelessWidget {
  final String userId;

  const UserListeningTopicsProgressPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Plain white background
      appBar: AppBar(
        title: const Text(
          'Listening Progress',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: BlocConsumer<ListeningpracticehubCubit, ListeningpracticehubState>(
        listener: (context, state) {
          if (state is GetusertopicsprogressListeningpracticehubError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is ListeningpracticehubLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetusertopicsprogressListeningpracticehubSuccess) {
            if (state.success.data == null || state.success.data!.isEmpty) {
              return const Center(
                child: Text("No topics found."),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: state.success.data!.length,
                itemBuilder: (context, index) {
                  final topic = state.success.data![index];
                  return TopicProgressCard(topic: topic,userId: userId);
                },
              ),
            );
          } else {
            return const Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}

class TopicProgressCard extends StatelessWidget {
  final GetusertopicsprogressListeningpracticehubTopicEntity topic;
  final String userId;

  const TopicProgressCard({super.key, required this.topic,required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Colors.white, Color(0xfff2f2f2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
          BoxShadow(
            color: Colors.white54,
            blurRadius: 2,
            offset: const Offset(-2, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildCardContent(context),
      ),
    );
  }

  Widget _buildCardContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Topic Name and Module
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                topic.topicName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                topic.module.name,
                style: const TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          topic.description.isNotEmpty
              ? topic.description
              : 'No description available.',
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const Divider(thickness: 1, height: 24, color: Colors.grey),
        // Horizontally scrollable list of levels
        SizedBox(
          height: 160, // Enough height for circular chart + text
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: topic.levelsProgress
                .map((level) => _buildLevelItem(context, level))
                .toList(),
          ),
        ),
      ],
    );
  }

  // Each level displayed as a horizontally scrolling "card"
  Widget _buildLevelItem(
    BuildContext context,
    GetusertopicsprogressListeningpracticehubLevelEntity level,
  ) {
    // Decide text/color based on didListenStory
    final storyStatus = level.didListenStory ? "Heard Story" : "Story pending";
    final storyColor = level.didListenStory ? Colors.green : Colors.red;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/listeningPractice',
          arguments: [userId,topic.topicId], // Pass the retrieved value as an argument
        );
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.deepPurple.withOpacity(0.1), width: 1),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Level name
            Text(
              level.levelName,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            // Custom radial progress + overlay icons
            SizedBox(
              width: 50,
              height: 50,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    painter: RadialProgressPainter(level.progressPercentage),
                    child: Center(
                      child: Text(
                        '${level.progressPercentage.toStringAsFixed(0)}%',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${level.completedSentences} / ${level.totalSentences}',
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
            // Show text-based story status with color
            Text(
              storyStatus,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: storyColor),
            ),
          ],
        ),
      ),
    );
  }
}

/// A custom painter to draw a radial/pie-style progress indicator
class RadialProgressPainter extends CustomPainter {
  final double progress; // Expects 0.0 - 100.0 range

  RadialProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    // Convert progress to a fraction of a full circle
    final fraction = (progress.clamp(0.0, 100.0)) / 100.0;
    final angle = 2 * math.pi * fraction;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    // Background circle
    final bgPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    canvas.drawCircle(center, radius, bgPaint);

    // Foreground arc
    final fgPaint = Paint()
      ..color = _getProgressColor(fraction)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    // Start from the top (-math.pi / 2) and sweep `angle`
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      angle,
      false,
      fgPaint,
    );
  }

  Color _getProgressColor(double fraction) {
    if (fraction >= 0.7) {
      return Colors.green;
    } else if (fraction >= 0.3) {
      return Colors.amber;
    } else {
      return Colors.redAccent;
    }
  }

  @override
  bool shouldRepaint(RadialProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
