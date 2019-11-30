class CoffeeModel {
  String coffee_address;
  String coffee_description;
  String coffee_email;
  String coffee_image_url;
  String coffee_name;
  String coffee_payment;
  String coffee_phone;
  String coffee_working_time;
  double lat;
  double long;

  CoffeeModel(
      {this.coffee_address,
      this.coffee_description,
      this.coffee_email,
      this.coffee_image_url,
      this.coffee_name,
      this.coffee_payment,
      this.coffee_phone,
      this.coffee_working_time,
      this.lat,
      this.long});

  factory CoffeeModel.fromJson(Map<String, dynamic> json) {
    return CoffeeModel(
      coffee_address: json['coffee_address'],
      coffee_description: json['coffee_description'],
      coffee_email: json['coffee_email'],
      coffee_image_url: json['coffee_image_url '],
      coffee_name: json['coffee_name'],
      coffee_payment: json['coffee_payment'],
      coffee_phone: json['coffee_phone'],
      coffee_working_time: json['coffee_working_time'],
      lat: json['lat'],
      long: json['long'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coffee_address'] = this.coffee_address;
    data['coffee_description'] = this.coffee_description;
    data['coffee_email'] = this.coffee_email;
    data['coffee_image_url '] = this.coffee_image_url;
    data['coffee_name'] = this.coffee_name;
    data['coffee_payment'] = this.coffee_payment;
    data['coffee_phone'] = this.coffee_phone;
    data['coffee_working_time'] = this.coffee_working_time;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}
