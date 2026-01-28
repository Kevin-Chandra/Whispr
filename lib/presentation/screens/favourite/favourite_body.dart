import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:whispr/data/models/audio_player_state.dart';
import 'package:whispr/domain/entities/audio_recording.dart';
import 'package:whispr/presentation/bloc/audio_player/audio_player_cubit.dart';
import 'package:whispr/presentation/screens/favourite/favourite_empty_body.dart';
import 'package:whispr/presentation/screens/journal/journal_body.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/widgets/whispr_journal_item.dart';
import 'package:whispr/util/date_time_util.dart';

class FavouriteBody extends StatelessWidget {
  const FavouriteBody({
    super.key,
    required this.audioRecordings,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.onRefreshPressed,
    required this.onFavouritePressed,
    required this.onAddFavouritePressed,
  });

  final Map<DateTime, List<AudioRecording>> audioRecordings;
  final VoidCallback onRefreshPressed;
  final VoidCallback onAddFavouritePressed;
  final Function(AudioRecording) onEditPressed;
  final Function(AudioRecording) onDeletePressed;
  final Function(AudioRecording) onFavouritePressed;

  @override
  Widget build(BuildContext context) {
    return audioRecordings.isEmpty
        ? FavouriteEmptyBody(onAddFavouriteClick: onAddFavouritePressed)
        : _FavouriteListBody(
            audioRecordings: audioRecordings,
            onEditPressed: onEditPressed,
            onDeletePressed: onDeletePressed,
            onRefreshPressed: onRefreshPressed,
            onFavouritePressed: onFavouritePressed,
          );
  }
}

class _FavouriteListBody extends StatelessWidget {
  const _FavouriteListBody({
    super.key,
    required this.audioRecordings,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.onRefreshPressed,
    required this.onFavouritePressed,
  });

  final Map<DateTime, List<AudioRecording>> audioRecordings;
  final VoidCallback onRefreshPressed;
  final Function(AudioRecording) onEditPressed;
  final Function(AudioRecording) onDeletePressed;
  final Function(AudioRecording) onFavouritePressed;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        onRefreshPressed();
      },
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
            ...audioRecordings.keys.map<Widget>(
              (date) {
                final recordings = audioRecordings[date]!;
                return _GroupedAudioRecordings(
                  text: date.formattedDate,
                  recordings: recordings,
                  onEditPressed: onEditPressed,
                  onDeletePressed: onDeletePressed,
                  onFavouritePressed: onFavouritePressed,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupedAudioRecordings extends StatefulWidget {
  const _GroupedAudioRecordings({
    super.key,
    required this.text,
    required this.recordings,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.onFavouritePressed,
  });

  final String text;
  final List<AudioRecording> recordings;
  final Function(AudioRecording) onEditPressed;
  final Function(AudioRecording) onDeletePressed;
  final Function(AudioRecording) onFavouritePressed;

  @override
  State<_GroupedAudioRecordings> createState() =>
      _GroupedAudioRecordingsState();
}

class _GroupedAudioRecordingsState extends State<_GroupedAudioRecordings> {
  late final AudioPlayerCubit _audioPlayerCubit;
  String? currentSelectedRecordingId;

  @override
  void initState() {
    super.initState();
    _audioPlayerCubit = context.read<AudioPlayerCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerCubit, AudioPlayerScreenState>(
      builder: (context, state) => SliverMainAxisGroup(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyHeaderDelegate(text: widget.text, height: 50),
          ),
          SliverClip(
            child: SliverList.builder(
              itemCount: widget.recordings.length,
              itemBuilder: (context, index) {
                final currentRecording = widget.recordings[index];
                return WhisprJournalItem(
                  cardPadding: const EdgeInsets.symmetric(vertical: 8),
                  useDotAndLine: false,
                  isSelected: currentSelectedRecordingId == currentRecording.id,
                  audioRecording: currentRecording,
                  onFavouritePressed: () {
                    widget.onFavouritePressed(currentRecording);
                  },
                  isLastItem: index == widget.recordings.length - 1,
                  expandedWidget: RecordingCardExpandedContent(
                    state: state,
                    audioRecording: currentRecording,
                    onEditPressed: () {
                      widget.onEditPressed(currentRecording);
                    },
                    onDeletePressed: () {
                      widget.onDeletePressed(currentRecording);
                    },
                    onPrepare: () {
                      _audioPlayerCubit.prepareAudio(
                        currentRecording.filePath,
                        playImmediately: true,
                      );
                    },
                    onPlay: _audioPlayerCubit.play,
                    onPause: _audioPlayerCubit.pause,
                    playerDuration: _audioPlayerCubit.position,
                  ),
                  onPressed: () {
                    setState(() {
                      currentSelectedRecordingId == currentRecording.id
                          ? currentSelectedRecordingId = null
                          : currentSelectedRecordingId = currentRecording.id;
                    });
                  },
                  isPlayingAudio:
                      state.currentPlayingFile == currentRecording.filePath &&
                          state.state == AudioPlayerState.playing,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  const StickyHeaderDelegate({
    required this.text,
    required this.height,
  });

  final String text;
  final double height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      height: 50,
      child: Row(
        spacing: 16,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: WhisprColors.vistaBlue,
            ),
            width: 10,
            height: 10,
          ),
          Text(
            text,
            style: WhisprTextStyles.heading5
                .copyWith(color: WhisprColors.spanishViolet),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return text != (oldDelegate as StickyHeaderDelegate).text;
  }
}
