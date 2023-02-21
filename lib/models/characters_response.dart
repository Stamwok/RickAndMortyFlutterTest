import 'character.dart';

class CharactersResponse {
  const CharactersResponse({ required this.info, required this.results });

  final PageInfo info;
  final List<Character> results;

  factory CharactersResponse.fromJson(Map<String, dynamic> json) {
    return CharactersResponse(
      info: PageInfo.fromJson(json['info']),
      results: (json['results'] as List).map((data) => Character.fromJson(data)).toList()
    );
  }
}

class PageInfo {
  const PageInfo({ required this.count, required this.pages, required this.next, required this.prev });

  final int count;
  final int pages;
  final String? next;
  final String? prev;

  factory PageInfo.fromJson(Map<String, dynamic> json) {
    return PageInfo(
        count: json['count'],
        pages: json['pages'],
        next: json['next'],
        prev: json['prev']
    );
  }
}