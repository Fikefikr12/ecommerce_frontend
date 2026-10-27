import 'package:ecommerce_frontend/core/util/common/widgets/circular_container.dart';
import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:ecommerce_frontend/data/model/address.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({super.key, required this.address});

  final AddressModel address;

  Future<void> _openLocation(BuildContext context) async {
    if (address.latitude == null || address.longitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location is not available for this address'),
        ),
      );
      return;
    }

    // create Google Maps Url
    final Uri googleMapsUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1'
      '&query=${address.latitude},${address.longitude}',
    );

    try {
      final bool launched = await launchUrl(
        googleMapsUrl,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not open location: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasLocation =
        address.latitude != null && address.longitude != null;

    return CircularContainer(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      showBorder: true,
      backgroundColor: address.isSelected
          ? AppColor.primary.withOpacity(0.5)
          : Colors.transparent,
      borderColor: address.isSelected
          ? Colors.transparent
          : Colors.grey.shade300,
      margin: EdgeInsets.only(bottom: 24),
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 0,
            child: Icon(
              address.isSelected ? Icons.check_circle : null,
              color: address.isSelected ? Colors.black54 : null,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                address.name,
                maxLines: 1,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4),
              Text(address.phoneNumber, maxLines: 1),
              SizedBox(height: 4),
              Text(
                "${address.street}, ${address.city}, ${address.subCity}, ${address.postalCode}, ${address.country}",
                softWrap: true,
              ),

              if (hasLocation) ...[
                const SizedBox(height: 12),

                OutlinedButton.icon(
                  onPressed: () => _openLocation(context),
                  icon: Icon(Icons.location_on),
                  label: Text('View Location'),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
