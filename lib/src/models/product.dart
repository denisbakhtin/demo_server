class Product {
  int id;
  String title;
  String description;
  Product({
    this.id = 0,
    this.title = '',
    this.description = '',
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: toInt(map['id']),
      title: toStr(map['title']),
      description: toStr(map['description']),
    );
  }
}

// conversion helpers, may be moved to a separate file later
String toStr(dynamic value) {
  if (value == null) return '';
  if (value is String) return value;
  return value.toString();
}

int toInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  return int.tryParse(value.toString()) ?? 0;
}
