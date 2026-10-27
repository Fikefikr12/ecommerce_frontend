import 'dart:convert';

import 'package:ecommerce_frontend/data/model/payment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class ChapaInitResult {
  final String checkoutUrl;
  final String? txRef;
  const ChapaInitResult({required this.checkoutUrl, this.txRef});
}

class PaymentCheck {
  final bool paid;
  final String message;
  final PaymentModel? payment;
  const PaymentCheck({required this.paid, required this.message, this.payment});
}

class PaymentService {
  static const String defaultBaseUrl = 'http://192.168.0.117:3000';

  final String baseUrl;
  final String idToken;

  PaymentService({required this.idToken, String? baseUrl})
    : baseUrl = baseUrl ?? defaultBaseUrl;

  static Future<PaymentService> create() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Please login before making a payment');

    final token = await user.getIdToken();

    if (token == null || token.isEmpty) {
      throw Exception('Unable to get user token');
    }
    return PaymentService(idToken: token);
  }

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $idToken',
  };

  Future<ChapaInitResult> initializeChapaPayment(
    String orderId, {
    String paymentMethod = 'chapa',
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/chapa/init'),
      headers: _headers,
      body: jsonEncode({'orderId': orderId, 'paymentMethod': paymentMethod}),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode < 200 ||
        response.statusCode >= 300 ||
        data['success'] != true) {
      throw Exception(data['message'] ?? 'Payment initialization failed');
    }

    final url = data['checkoutUrl']?.toString() ?? '';
    if (url.isEmpty) throw Exception('Checkout URL was not returned');

    // tolerant: txRef or tx_ref, top level or inside data
    final inner = data['data'];
    final txRef =
        (data['txRef'] ??
                data['tx_ref'] ??
                (inner is Map ? (inner['txRef'] ?? inner['tx_ref']) : null))
            ?.toString();

    return ChapaInitResult(checkoutUrl: url, txRef: txRef);
  }

  Future<PaymentCheck> verifyChapaPayment(String txRef) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/chapa/verify/$txRef'),
      headers: {'Authorization': 'Bearer $idToken'},
    );

    final data = jsonDecode(response.body);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(data['message'] ?? 'Payment verification failed');
    }

    final payload = data['data'];
    PaymentModel? payment;
    if (payload is Map &&
        payload['orderId'] != null &&
        payload['amount'] != null) {
      payment = PaymentModel.fromJson(Map<String, dynamic>.from(payload));
    }

    final status =
        (payment?.status ??
                data['status'] ??
                (payload is Map ? payload['status'] : null) ??
                '')
            .toString()
            .toLowerCase();

    return PaymentCheck(
      paid: status == 'success' || status == 'paid',
      message: data['message']?.toString() ?? '',
      payment: payment,
    );
  }
}
