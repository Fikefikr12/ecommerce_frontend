import 'package:ecommerce_frontend/core/util/common/widgets/circular_container.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/section_header.dart';
import 'package:ecommerce_frontend/data/model/payment_method.dart';
import 'package:flutter/material.dart';

class BilingPaymentSection extends StatelessWidget {
  final PaymentMethod selected;
  final ValueChanged<PaymentMethod> onChanged;
  final bool enabled;
  const BilingPaymentSection({
    required this.selected,
    required this.onChanged,
    this.enabled = true,
    super.key,
  });

  Widget _leading(PaymentMethod m) => CircularContainer(
    width: 60,
    height: 60,
    backgroundColor: Colors.white,
    padding: EdgeInsets.all(8),
    child: m.asset != null
        ? Image.asset(m.asset!, fit: BoxFit.contain)
        : Icon(m.icon, color: Colors.black87),
  );

  void _pick(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'Select payment method',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          for (final m in PaymentMethod.values)
            ListTile(
              leading: _leading(m),
              title: Text(m.label),
              subtitle: Text(m.isOnline ? 'Pay now' : 'Pay when it arrives'),
              trailing: m == selected
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : null,
              onTap: () {
                onChanged(m);
                Navigator.pop(sheetContext);
              },
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(
          title: "Payment method",
          buttonTitle: enabled ? "change" : '',
          onPressed: enabled ? () => _pick(context) : () {},
        ),
        SizedBox(height: 8),
        Row(
          children: [
            _leading(selected),
            SizedBox(width: 8),
            Text(selected.label, style: TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }
}
