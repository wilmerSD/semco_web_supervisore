class OptionSelectModel {
  final String id;
  final String text;

  OptionSelectModel({required this.id, required this.text});
  OptionSelectModel copyWith({
    String? id,
    String? text,
  }) {
    return OptionSelectModel(
      id: id ?? this.id,
      text: text ?? this.text,
    );
  }
}
