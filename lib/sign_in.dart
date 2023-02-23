class User {
  String email;
  String password;

  User(this.email, this.password);
}

var USER_SAMPLE = [
  User(
    "firstSecond@gmail.com",
    "Password1234",
  ), //correct sample
  User(
    "",
    "Password1234",
  ), //Missing email
  User(
    "firstSecond@gmail.com",
    "",
  ), //Missing Password
  User("firstSecond@gmail.com",
      "1234"), //Password too short must be 8 characters
  User(
    "",
    "",
  ), //Missing all fields
  User("12345", "pass123") //Incorrect email
];
