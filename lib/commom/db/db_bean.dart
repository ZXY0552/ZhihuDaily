abstract class BaseDbBean {
  int id;

  BaseDbBean({this.id});

  Map<String, dynamic> toMap();

  List<String> toKeyList();


}
