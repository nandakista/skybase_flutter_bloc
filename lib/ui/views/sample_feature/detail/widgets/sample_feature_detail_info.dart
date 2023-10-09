import 'package:flutter/material.dart';
import 'package:skybase/config/themes/app_style.dart';

class SampleFeatureDetailInfo extends StatelessWidget {
  const SampleFeatureDetailInfo({
    Key? key,
    required this.name,
    required this.bio,
    required this.company,
    required this.location,
  }) : super(key: key);

  final String name;
  final String bio;
  final String company;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Text(name, style: AppStyle.headline4),
          Text(bio),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_city),
              Text(' $company'),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.location_on),
              Text(' $location'),
            ],
          ),
        ],
      ),
    );
  }
}
