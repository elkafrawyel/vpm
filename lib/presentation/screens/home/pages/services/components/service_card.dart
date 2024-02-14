import 'package:flutter/material.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_cached_image.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppCachedImage(
            imageUrl:
                'https://media.licdn.com/dms/image/D4D12AQGA6odm93XONA/article-cover_image-shrink_720_1280/0/1675839423933?e=2147483647&v=beta&t=k4l6SyDe2-U9qtTTYJeUHcWNpeeCBqzEnso-okTBjIU',
            width: 140,
            height: 120,
            radius: 8,
          ),
          10.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  'Car Wash Service Card is a service card for the',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  maxLines: 2,
                ),
                5.ph,
                const AppText(
                  'car cleaner service card is a service card for the car cleaner service card for the car cleaner service card for the',
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  maxLines: 3,
                ),
                5.ph,
                AppText(
                  '200.0 SAR',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
