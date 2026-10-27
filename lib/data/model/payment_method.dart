import 'package:flutter/material.dart';

enum PaymentMethod {
  chapa(
    'chapa',
    'Chapa',
    true,
    Icons.payment,
    'assets/images/onbording/epa.png',
  ),
  telebirr('telebirr', 'Telebirr', true, Icons.phone_android, null),
  cbe('cbe', 'CBE Birr', true, Icons.account_balance, null),
  cashOnDelivery(
    'cash_on_delivery',
    'Cash on delivery',
    false,
    Icons.local_shipping,
    null,
  );

  final String apiValue; // must match the backend enums
  final String label;
  final bool
  isOnline; // online = opens a payment page, otherwise pay on arrival
  final IconData icon;
  final String? asset;

  const PaymentMethod(
    this.apiValue,
    this.label,
    this.isOnline,
    this.icon,
    this.asset,
  );
}
