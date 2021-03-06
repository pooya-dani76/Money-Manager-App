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
  String description;
  double price;
  String transactionType;

  Transaction(
      {this.transactionId,
      this.note,
      this.price,
      this.destenationAccount,
      this.description,
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
      'destenationAccount': destenationAccount,
      'description': description,
      'originAccount': originAccount,
      'day': day,
      'month': month,
      'year': year,
      'hour': hour,
      'minute': minute,
      'transactionType': transactionType
    };
  }
}

class Date {
  int day;
  int month;
  int year;

  Date(this.day, this.month, this.year);
}
