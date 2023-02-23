import 'dart:html';

class Personal {
    double PersonalWeight;
    double PersonalHeight;
    Personal(this.PersonalWeight,this.PersonalHeight);

}

var personal_sample = [
  Personal(155.5 , 70), // sample of personal data that is correct

  Personal(130, 6), // sample of personal data that is incorrect by including feeet and inches

  Personal(5.5, 60), // sample of personal data that is imcomplete

  Personal(45, 0), //sample of personal data that is incomplete

  Personal(5, 5), //Sample of data with both fields that are incomplete
];