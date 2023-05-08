import '../constant/message.dart';

 validInput(String val, int min, int max) {
  if (val.length > max) {
    return {'$messageMaxInput'};
  }
  if (val.isEmpty) {
    return {'$messageEmptyInput'};
  }
 
   if (val.length < min) {
    return {'$messageMinInput'};
  }
  
}
