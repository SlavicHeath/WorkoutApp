class User {
  String email;
  String password;
  String passrepeat;

  User(this.email, this.password, this.passrepeat);
}

var USER_SAMPLE = [
  User(
      "firstSecond@gmail.com", "Password1234", "Password1234"), //correct sample
  User("", "Password1234", "Password1234"), //Missing email
  User("firstSecond@gmail.com", "", ""), //Missing Password
  User("firstSecond@gmail.com", "1234",
      "1234"), //Password too short must be 8 characters
  User("firstSecond@gmail.com", "1234", ""), //Missing password repeat
  User("", "", ""), //Missing all fields
  User("12345", "pass123", "pass123") //Incorrect email
];
