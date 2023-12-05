class model {
  int? id;
  String? name;
  String? description;
  String? date;
  // model(this.id, this.name, this.description);
  Map map1() {
    Map<String, dynamic> m1 = {
      'id': id ?? null,
      'name': name,
      'description': description,
      'date': date
      /* var m1 = Map<String, dynamic>();
    m1['id'] = id ?? null;
    m1['name'] = name;
    m1['description'] = description;
    m1['date'] = date;*/
    };
    return m1;
  }
}
