import 'package:ecommerce_frontend/core/util/common/widgets/circular_container.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/section_header.dart';
import 'package:flutter/material.dart';

/// The backend Order requires these four fields.
bool isAddressComplete(Map<String, String> a) =>
    (a['fullName'] ?? '').trim().isNotEmpty &&
    (a['phone'] ?? '').trim().isNotEmpty &&
    (a['city'] ?? '').trim().isNotEmpty &&
    (a['street'] ?? '').trim().isNotEmpty;

class BilingAddressSection extends StatelessWidget {
  final Map<String, String> address;
  final ValueChanged<Map<String, String>> onChanged;
  final bool enabled; // false once the order exists
  const BilingAddressSection({
    super.key,
    required this.address,
    required this.onChanged,
    this.enabled = true,
  });

  Future<void> _edit(BuildContext context) async {
    final result = await showModalBottomSheet<Map<String, String>>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _AddressForm(initial: address),
    );

    if (result != null) onChanged(result);
  }

  @override
  Widget build(BuildContext context) {
    final complete = isAddressComplete(address);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: "Shipping Address",
          buttonTitle: !enabled ? '' : (complete ? 'change' : 'add'),
          onPressed: enabled ? () => _edit(context) : () {},
        ),
        if (!complete)
          const Text(
            'Add your shipping address to continue',
            style: TextStyle(color: Colors.red),
          )
        else ...[
          Text(
            address['fullName']!,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.phone, color: Colors.grey, size: 16),
              SizedBox(width: 8),
              Text(
                address['phone']!,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.grey, size: 16),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${address['street']}, ${address['city']}',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _AddressForm extends StatefulWidget {
  final Map<String, String> initial;
  const _AddressForm({required this.initial});

  @override
  State<_AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<_AddressForm> {
  late final Map<String, TextEditingController> _c = {
    for (final k in ['fullName', 'phone', 'city', 'street'])
      k: TextEditingController(text: widget.initial[k] ?? ''),
  };

  @override
  void dispose() {
    for (final c in _c.values) {
      c.dispose();
    }
    super.dispose();
  }

  Widget _field(String key, String label, {TextInputType? type}) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextField(
      controller: _c[key],
      keyboardType: type,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      // keeps the form above the keyboard
      padding: EdgeInsets.fromLTRB(
        24,
        24,
        24,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _field('fullName', 'Full name'),
            _field('phone', 'Phone', type: TextInputType.phone),
            _field('city', 'City'),
            _field('street', 'Street / area'),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, {
                  for (final e in _c.entries) e.key: e.value.text.trim(),
                }),
                child: const Text('Save address'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
