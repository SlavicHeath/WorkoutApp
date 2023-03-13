import 'dart:html';

class personal {
  double personalWeight;
  double personalHeight;
  personal(this.personalWeight, this.personalHeight);
}

var personal_sample = [
  personal(155.5, 70), // sample of personal data that is correct

  personal(130,
      65), // sample of personal data that is incorrect by including feeet and inches

  personal(0, 60), // sample of personal data that is imcomplete

  personal(145, 0), //sample of personal data that is incomplete

  personal(0, 0), //Sample of data with both fields that are incomplete

  personal(145,
      71) //Sample of Data is that is complete and correct (should debate whether real or int )
];
