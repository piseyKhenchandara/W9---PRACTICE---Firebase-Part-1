import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/songs/song.dart';
import '../../states/player_state.dart';
import '../../theme/theme.dart';

class SongDetailScreen extends StatelessWidget {
  final Song song;

  const SongDetailScreen({super.key, required this.song});

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final playerState = context.watch<PlayerState>();
    final isPlaying = playerState.currentSong == song;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.neutralDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Song Detail',
          style: AppTextStyles.label.copyWith(color: AppColors.neutralDark),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            // Cover image
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: song.imageUrl.isNotEmpty
                  ? Image.network(
                      song.imageUrl,
                      width: 240,
                      height: 240,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _placeholder(),
                    )
                  : _placeholder(),
            ),
            const SizedBox(height: 40),
            // Title
            Text(
              song.title,
              style: AppTextStyles.body.copyWith(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: AppColors.neutralDark,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // Artist id
            Text(
              song.artistId,
              style: AppTextStyles.label.copyWith(color: AppColors.textLight),
            ),
            const SizedBox(height: 8),
            // Duration
            Text(
              _formatDuration(song.duration),
              style: AppTextStyles.label.copyWith(
                color: AppColors.neutralLighter,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            // Play / Stop button
            GestureDetector(
              onTap: () {
                if (isPlaying) {
                  context.read<PlayerState>().stop();
                } else {
                  context.read<PlayerState>().start(song);
                }
              },
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.neutralDark,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isPlaying ? Icons.stop : Icons.play_arrow,
                  color: Colors.white,
                  size: 38,
                ),
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 240,
      height: 240,
      color: AppColors.greyLight,
      child: Icon(Icons.music_note, size: 100, color: AppColors.neutralLighter),
    );
  }
}
