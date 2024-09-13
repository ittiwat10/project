class Profile {
  String? id;
  String? Name;
  String? LastName;
  String? Email;
  String? Password;
  String? RePassword;
  String? Gender;
  String? Age;
  String? Province;
  String? Allergic;
  String? Con_disease;

  Profile(
      {this.id,
      this.Name,
      this.LastName,
      this.Email,
      this.Password,
      this.RePassword,
      this.Gender,
      this.Age,
      this.Province,
      this.Allergic,
      this.Con_disease});

  Map<String, dynamic> EmailtoJson() {
    return {
      "Email": Email,
      "Password": Password,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': Name,
      'LastName': LastName,
      'Age': Age,
      'Gender': Gender,
      'Province': Province,
      'ChronicDisease': Con_disease,
      'Allergic': Allergic,
    };
  }
}
