import 'package:freezed_annotation/freezed_annotation.dart';

part 'character.freezed.dart';
part 'character.g.dart';

@freezed
class Character with _$Character{
  const factory Character({
    required List<Results> results,
}) = _Character;
  factory Character.fromJson(Map<String,dynamic> json) => _$CharacterFromJson(json);
}

@freezed
class Info with _$Info {
  const factory Info({
    required int count,
    required int pages,
    String? next,
    String? prev,
}) = _Info;
  factory Info.fromJson(Map<String,dynamic> json) => _$InfoFromJson(json);
}


@freezed
class Results with _$Results {
  const factory Results({
    required int id,
    required String name,
    required String status,
    required String species,
    required String gender,
    required String image,
}) = _Results;
  factory Results.fromJson(Map<String,dynamic> json) => _$ResultsFromJson(json);
}