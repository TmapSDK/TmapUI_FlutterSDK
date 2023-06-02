enum InitResult {
  notGranted('notGranted'),
  granted('granted');

  final String text;
  const InitResult(this.text);

  factory InitResult.getByText(String text){
    return InitResult.values.firstWhere((value) => value.text == text,
        orElse: () => InitResult.notGranted);
  }
}