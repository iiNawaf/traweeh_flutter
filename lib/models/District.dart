
class District{
  final String districtID;
  final String districtName;

  District({required this.districtID, required this.districtName});

  static District fromJson(json) => District(
    districtID: json['district_id'],
    districtName: json['district_name']
    );

}