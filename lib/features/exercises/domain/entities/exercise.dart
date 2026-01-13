class Exercise {
  final String id;
  final String name;
  final String muscleGroup;
  final String equipment;
  final String difficulty;
  final String? description;
  final String? videoUrl;

  const Exercise({
    required this.id,
    required this.name,
    required this.muscleGroup,
    required this.equipment,
    required this.difficulty,
    this.description,
    this.videoUrl,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as String,
      name: json['name'] as String,
      muscleGroup: json['muscle_group'] as String,
      equipment: json['equipment'] as String,
      difficulty: json['difficulty'] as String,
      description: json['description'] as String?,
      videoUrl: json['video_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'muscle_group': muscleGroup,
      'equipment': equipment,
      'difficulty': difficulty,
      'description': description,
      'video_url': videoUrl,
    };
  }
}
