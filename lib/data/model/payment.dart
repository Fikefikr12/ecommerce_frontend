class PaymentModel {
  final String? id;
  final String orderId;
  final String userId;
  final double amount;
  final String currency; // ADDED (schema default "ETB")
  final String paymentMethod;
  final String? txRef; // ADDED: what we send to Chapa, used to verify
  final String? transactionId;
  final String? checkoutUrl; // ADDED
  final String status; // pending | success | failed
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PaymentModel({
    this.id,
    required this.orderId,
    required this.userId,
    required this.amount,
    this.currency = 'ETB',
    required this.paymentMethod,
    this.txRef,
    this.transactionId,
    this.checkoutUrl,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  // ADDED: handy status checks
  bool get isPaid => status == 'success';
  bool get isPending => status == 'pending';
  bool get isFailed => status == 'failed';

  // CHANGED: orderId is a String normally, but a Map when the backend populated it
  static String _idOf(dynamic v) =>
      v is Map ? (v['_id'] ?? '').toString() : (v ?? '').toString();

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['_id']?.toString(),
      orderId: _idOf(json['orderId']),
      userId: json['userId']?.toString() ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0, // no crash on null
      currency: json['currency']?.toString() ?? 'ETB',
      paymentMethod: json['paymentMethod']?.toString() ?? '',
      txRef: json['txRef']?.toString(),
      transactionId: json['transactionId']?.toString(),
      checkoutUrl: json['checkoutUrl']?.toString(),
      status: json['status']?.toString() ?? 'pending',
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? ''),
      updatedAt: DateTime.tryParse(json['updatedAt']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() => {
    if (id != null) '_id': id, // CHANGED: don't send a null id
    'orderId': orderId,
    'userId': userId,
    'amount': amount,
    'currency': currency,
    'paymentMethod': paymentMethod,
    'txRef': txRef,
    'transactionId': transactionId,
    'checkoutUrl': checkoutUrl,
    'status': status,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };

  PaymentModel copyWith({
    String? id,
    String? orderId,
    String? userId,
    double? amount,
    String? currency,
    String? paymentMethod,
    String? txRef,
    String? transactionId,
    String? checkoutUrl,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      txRef: txRef ?? this.txRef,
      transactionId: transactionId ?? this.transactionId,
      checkoutUrl: checkoutUrl ?? this.checkoutUrl,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
