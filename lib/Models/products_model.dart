class Product {
  String uniqueID = '';
  String user = '';
  String title = '';
  String description = '';
  String price = '';
  String condition = '';
  String semester = '';
  String subject = '';
  String image = '';
  String number = '';

  Product({
    this.title = '',
    this.description = '',
    this.price = '',
    this.condition = '',
    this.semester = '',
    this.subject = '',
    this.uniqueID = '',
    this.image = '',
    this.number = '',
    this.user = '',
  });

  Map<String, dynamic> toJson() => {
        'uniqueID': uniqueID,
        'user': user,
        'number': number,
        'image': image,
        'subject': subject,
        'semester': semester,
        'condition': condition,
        'description': description,
        'title': title,
        'price': price,
      };

  static Product fromJson(Map<String, dynamic> json) => Product(
        uniqueID: json['uniqueID'],
        user: json['user'],
        number: json['number'],
        image: json['image'],
        subject: json['subject'],
        semester: json['semester'],
        condition: json['condition'],
        description: json['description'],
        title: json['title'],
        price: json['price'],
      );
}
