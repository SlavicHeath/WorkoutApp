class User {
  String email;
  User(this.email);
}

var USER_SAMPLE = [
  User("firstSecond@gmail.com"), //correct sample
  User(""), // No values entered
  User("daswerfwe"), //Incorrect email
];
