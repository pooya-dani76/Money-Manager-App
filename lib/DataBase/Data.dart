class Transaction {
  int transactionId;
  int day;
  int month;
  int year;
  int hour;
  int minute;
  String originAccount;
  String destenationAccount;
  String note;
  String extraNote;
  int price;
  String transactionType;

  Transaction(
      {this.transactionId,
      this.note,
      this.price,
      this.destenationAccount,
      this.extraNote,
      this.originAccount,
      this.day,
      this.month,
      this.year,
      this.hour,
      this.minute, 
      this.transactionType});

  Map<String, dynamic> toMap() {
    return {
      'id': transactionId,
      'note': note,
      'price': price,
      'destenationAccount' : destenationAccount,
      'extraNote' : extraNote,
      'originAccount' : originAccount,
      'day' : day,
      'month' : month,
      'year' : year,
      'hour' : hour,
      'minute' : minute,
      'transactionType' : transactionType
    };
  }
}