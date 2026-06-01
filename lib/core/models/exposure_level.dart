enum Difficulty { easy, medium, hard }

class ExposureLevel {
  final String id;
  final String title;
  final String description;
  final Difficulty difficulty;
  final bool isCompleted;
  final int progress;

  const ExposureLevel({
    required this.id,
    required this.title,
    required this.description,
    this.difficulty = Difficulty.easy,
    this.isCompleted = false,
    this.progress = 0,
  });

  ExposureLevel copyWith({
    String? id,
    String? title,
    String? description,
    Difficulty? difficulty,
    bool? isCompleted,
    int? progress,
  }) {
    return ExposureLevel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      difficulty: difficulty ?? this.difficulty,
      isCompleted: isCompleted ?? this.isCompleted,
      progress: progress ?? this.progress,
    );
  }
}
