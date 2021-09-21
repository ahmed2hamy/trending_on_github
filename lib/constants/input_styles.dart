part of 'constants.dart';

const TextStyle kWhiteTextStyle = TextStyle(
  color: Colors.white,
);
const TextStyle kTitleWhiteTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 18,
);

const TextStyle kTitleBlackTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
);

const TextStyle kTitlePrimaryColorTextStyle = TextStyle(
  color: kPrimaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 18,
);

const kTextInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
