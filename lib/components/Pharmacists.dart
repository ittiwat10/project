class Pharmacists {
  String? id;
  String? Name;
  String? LastName;
  String? Email;
  String? Password;
  String? RePassword;
  String? Gender;
  String? Age;
  String? Province;
  String? Number;
  String? Pharmacy;

  Pharmacists(
      {this.id,
      this.Name,
      this.LastName,
      this.Email,
      this.Password,
      this.RePassword,
      this.Gender,
      this.Age,
      this.Province,
      this.Number,
      this.Pharmacy});

  Map<String, dynamic> EmailtoJson() {
    return {
      "Email": Email,
      "Password": Password,
      'Professional License Number': Number,
      'Phamacy': Pharmacy,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': Name,
      'LastName': LastName,
      'Age': Age,
      'Gender': Gender,
      'Province': Province,
    };
  }
}
