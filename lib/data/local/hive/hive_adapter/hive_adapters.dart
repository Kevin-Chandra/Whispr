import 'package:hive_ce/hive.dart';
import 'package:whispr/data/models/audio_recording_model.dart';
import 'package:whispr/data/models/recording_tag_model.dart';
import 'package:whispr/domain/entities/mood.dart';

@GenerateAdapters([
  AdapterSpec<AudioRecordingModel>(),
  AdapterSpec<RecordingTagModel>(),
  AdapterSpec<Mood>(),
])
part 'hive_adapters.g.dart';
