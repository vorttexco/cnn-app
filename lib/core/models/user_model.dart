class UserModel {
  String? name;
  String? device;
  String? token;
  String? picture;
  String? email;
  String? ppid;

  UserModel({
    this.name,
    this.picture,
    this.email,
    this.ppid,
    this.token,
    this.device,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    device = json['device'];
    picture = json['picture'];
    email = json['email'];
    token = json['token'];
    ppid = json['ppid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['device'] = device;
    data['picture'] = picture;
    data['email'] = email;
    data['ppid'] = ppid;
    return data;
  }
}
