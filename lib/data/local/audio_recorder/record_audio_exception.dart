sealed class RecordAudioException implements Exception {}

class MicrophonePermissionDenied extends RecordAudioException {}

class MicrophonePermissionDeniedForever extends RecordAudioException {}
