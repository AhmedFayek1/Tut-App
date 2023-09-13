class UserModel {
  String id;
  String name;
  int numOfNotifications;

  UserModel(this.id, this.name, this.numOfNotifications);
}

class ContactModel {
  String phone;
  String email;
  String link;

  ContactModel(this.phone, this.email, this.link);
}

class AuthenticationModel {
  UserModel user;
  ContactModel contacts;

  AuthenticationModel(this.user, this.contacts);
}