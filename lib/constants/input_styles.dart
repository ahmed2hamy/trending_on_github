part of 'constants.dart';

const kTitleText = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w700,
  fontSize: 46,
);

const kBodyText = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w300,
  fontSize: 24,
);

const kHeadText = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.w700,
  fontSize: 30,
);

const kTextInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
