import 'dart:html';

class personal(Weight , Height) {
    String personalWeight;
    String personalHeight;
    personal(personalWeight, personalHeight)
    int bmi = personalWeight / personalHeight;
}

var personal_sample {
  personal("155.5" , "70"), // sample of personal data that is correct

  personal("130", "6 foot 5 inches"), // sample of personal data that is incorrect by including feeet and inches

  personal("", "60"), // sample of personal data that is imcomplete

  personal("145", ""), //sample of personal data that is incomplete

  personal("", ""), //Sample of data with both fields that are incomplete

  personal("145", "71") //Sample of Data is that is complete and correct (should debate whether real or int )
}