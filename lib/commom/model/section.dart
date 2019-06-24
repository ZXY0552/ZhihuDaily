library section;

import 'package:json_annotation/json_annotation.dart';

part 'section.g.dart';

@JsonSerializable()
class Section {
  factory Section.fromJson(Map<String, dynamic> json) =>
      _$SectionFromJson(json);

  Map<String, dynamic> toJson(Section instance) => _$SectionToJson(instance);

  String thumbnail;
  String name;
  int id;

  Section(this.thumbnail, this.name, this.id);
}
