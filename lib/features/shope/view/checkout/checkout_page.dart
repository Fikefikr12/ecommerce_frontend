import 'package:ecommerce_frontend/core/service/payment_service.dart';
import 'package:ecommerce_frontend/core/util/common/success/success_page.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/circular_container.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/data/model/cart_Item.dart';
import 'package:ecommerce_frontend/data/model/payment_method.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_bloc.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_event.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_state.dart';
import 'package:ecommerce_frontend/features/shope/view/cart/widgets/reusable_cart_items.dart';
import 'package:ecommerce_frontend/features/shope/view/checkout/widgets/biling_address_section.dart';
import 'package:ecommerce_frontend/features/shope/view/checkout/widgets/biling_amount_section.dart';
import 'package:ecommerce_frontend/features/shope/view/checkout/widgets/biling_payment_section.dart';
import 'package:ecommerce_frontend/features/shope/view/checkout/widgets/coupon_code.dart';
import 'package:ecommerce_frontend/features/shope/widgets/bottom_navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

/// No orderId parameter: the order is created HERE, after the user has chosen
/// the address and the payment method.
class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage>
    with WidgetsBindingObserver {
  static const double _deliveryFee = 6.0; // TODO: move to the server

  PaymentMethod _method = PaymentMethod.chapa;
  late Map<String, String> _address;

  bool _busy = false; // placing order / opening / verifying
  String? _orderId; // set once the order exists
  String? _txRef; // reference used to verify the payment
  bool _awaitingPayment = false; // payment page was opened
  List<CartItemModel>? _placedItems; // snapshot (backend clears the cart)

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final name = context.read<ShopeBloc>().state.currentUser?.name ?? '';
    _address = {'fullName': name, 'phone': '', 'city': '', 'street': ''};
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // User came back from the payment page -> verify automatically.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed &&
        _awaitingPayment &&
        _txRef != null &&
        !_busy) {
      _verifyPayment();
    }
  }

  // ---------------- order ----------------

  void _placeOrder(List<CartItemModel> items) {
    setState(() {
      _busy = true;
      _placedItems = items;
    });
    context.read<ShopeBloc>().add(
      CreateOrderEvent(
        shippingAddress: Map<String, dynamic>.from(_address),
        paymentMethod: _method.apiValue,
        deliveryFee: _deliveryFee,
      ),
    );
  }

  // Called by the listener when the bloc emits a NEW order.
  Future<void> _onOrderCreated(Map<String, dynamic> order) async {
    final id = order['_id']?.toString() ?? '';
    _orderId = id;

    if (!_method.isOnline) {
      setState(() => _busy = false);
      _goToSuccess('Order placed!', 'Pay with cash when your order arrives.');
      return;
    }
    await _startOnlinePayment(id);
  }

  // ---------------- online payment ----------------

  Future<void> _startOnlinePayment(String orderId) async {
    setState(() => _busy = true);
    try {
      final service = await PaymentService.create();
      final init = await service.initializeChapaPayment(
        orderId,
        paymentMethod: _method.apiValue,
      );
      _txRef = init.txRef;

      final opened = await launchUrl(
        Uri.parse(init.checkoutUrl),
        mode: LaunchMode.externalApplication,
      );
      if (!opened) throw Exception('Could not open the payment page');

      _awaitingPayment = _txRef != null;
      if (_txRef == null) {
        _showError(
          'Payment started, but no reference was returned to verify it.',
        );
      }
    } catch (e) {
      _showError(e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _verifyPayment() async {
    if (_txRef == null) return;
    setState(() => _busy = true);
    try {
      final service = await PaymentService.create();
      final check = await service.verifyChapaPayment(_txRef!);
      if (!mounted) return;

      if (check.paid) {
        _awaitingPayment = false;
        _goToSuccess('Payment Success!', 'Your order will be shipped soon!');
        return;
      }
      _showError(
        'Payment not completed yet. Finish paying, or tap Pay now to retry.',
      );
    } catch (e) {
      _showError(e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  // ---------------- helpers ----------------

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _goToSuccess(String title, String subTitle) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (successContext) => SuccessPage(
          image: 'assets/images/onbording/en.jpg',
          title: title,
          subTitle: subTitle,
          onPressed: () => Navigator.pushAndRemoveUntil(
            successContext,
            MaterialPageRoute(builder: (_) => BottomNavigationMenu()),
            (_) => false,
          ),
        ),
      ),
      (route) => false,
    );
  }

  // ---------------- UI ----------------

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // new order -> pay or finish
        BlocListener<ShopeBloc, ShopeState>(
          listenWhen: (p, c) =>
              c.currentOrder != null &&
              p.currentOrder?['_id'] != c.currentOrder?['_id'],
          listener: (_, state) => _onOrderCreated(state.currentOrder!),
        ),
        // backend errors, e.g. "Cart is empty", "Shipping address is incomplete"
        BlocListener<ShopeBloc, ShopeState>(
          listenWhen: (p, c) =>
              c.errorMessage != null && p.errorMessage != c.errorMessage,
          listener: (_, state) {
            if (_orderId == null) setState(() => _busy = false);
            _showError(state.errorMessage!);
          },
        ),
      ],
      child: BlocBuilder<ShopeBloc, ShopeState>(
        builder: (context, state) {
          // after ordering the cart is empty, so show the snapshot
          final items = _placedItems ?? state.cart?.items ?? [];
          final subtotal = items.fold<double>(0, (s, i) => s + i.lineTotal);
          final total = subtotal + _deliveryFee;
          final locked = _orderId != null; // order exists: address/method fixed
          final canPay =
              items.isNotEmpty && isAddressComplete(_address) && !_busy;

          return Scaffold(
            appBar: CustomAppbar(
              showBackArrow: true,
              title: const Text(
                'Order Review',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            body: items.isEmpty
                ? const Center(child: Text('Your cart is empty'))
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          ReusableCartItems(
                            items: items,
                            showAddRemoveButtons: false,
                            scrollable: false,
                          ),
                          const SizedBox(height: 32),
                          const CouponCode(), // not wired to the order yet
                          const SizedBox(height: 32),
                          CircularContainer(
                            padding: const EdgeInsets.all(16),
                            showBorder: true,
                            backgroundColor: Colors.white,
                            child: Column(
                              children: [
                                BilingAmountSection(
                                  subtotal: subtotal,
                                  shippingFee: _deliveryFee,
                                ),
                                const SizedBox(height: 24),
                                const Divider(),
                                const SizedBox(height: 24),
                                BilingPaymentSection(
                                  selected: _method,
                                  enabled: !locked,
                                  onChanged: (m) => setState(() => _method = m),
                                ),
                                const SizedBox(height: 24),
                                BilingAddressSection(
                                  address: _address,
                                  enabled: !locked,
                                  onChanged: (a) =>
                                      setState(() => _address = a),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: !canPay
                          ? null
                          : () => locked
                                ? _startOnlinePayment(
                                    _orderId!,
                                  ) // retry same order
                                : _placeOrder(items),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: _busy
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              locked
                                  ? 'Pay now \$${total.toStringAsFixed(2)}'
                                  : _method.isOnline
                                  ? 'Pay \$${total.toStringAsFixed(2)}'
                                  : 'Place order \$${total.toStringAsFixed(2)}',
                            ),
                    ),
                  ),
                  // manual check in case the auto-check on return doesn't fire
                  if (_awaitingPayment)
                    TextButton(
                      onPressed: _busy ? null : _verifyPayment,
                      child: const Text("I've paid, check status"),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
