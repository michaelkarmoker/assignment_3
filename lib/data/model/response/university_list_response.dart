






import 'package:floor/floor.dart';

@entity
class University {

  @primaryKey
  int? id;
  String? name;
   String ? webPages;
  String? country;
   String ? domains;
  University(
      {this.name,
        this.webPages,
        this.country,
        this.domains});

  University.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    webPages = json['web_pages'].cast<String>().join(",");
    country = json['country'];
    domains = json['domains'].cast<String>().join(",")  ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['web_pages'] = this.webPages;
    data['country'] = this.country;
    data['domains'] = this.domains;
    return data;
  }
}