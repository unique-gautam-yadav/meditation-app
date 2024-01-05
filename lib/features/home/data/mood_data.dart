import 'package:meditation_app/features/home/model/mood_model.dart';

class MoodData {
  static MoodModel calm =
      MoodModel(name: 'Calm', icon: 'assets/icons/calm.png');
  static MoodModel focus =
      MoodModel(name: 'Focus', icon: 'assets/icons/focus.png');
  static MoodModel healing =
      MoodModel(name: 'Healing', icon: 'assets/icons/healing.png');
  static MoodModel morning =
      MoodModel(name: 'Morning', icon: 'assets/icons/morning.png');
  static MoodModel nature =
      MoodModel(name: 'Nature', icon: 'assets/icons/nature.png');
  static MoodModel spiritual =
      MoodModel(name: 'Spiritual', icon: 'assets/icons/spiritual.png');

  static List<MoodModel> moods = [
    calm,
    spiritual,
    focus,
    nature,
    morning,
    healing,
  ];
}
