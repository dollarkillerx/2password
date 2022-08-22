bool isNotEmpty(String? text) {
  return text?.isNotEmpty ?? false;
}

bool isEmpty(String? text) {
  return text?.isEmpty ?? false;
}

filling(String input, int len, String fil) {
  if (input.length < len) {
    var end = len - input.length;
    for (var i=0;i<end;i++){
      input += fil;
    }
  }

  return input;
}