import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/app/util/util.dart';
import 'package:vpm/domain/entities/models/AdvertisementModel.dart';
import 'package:vpm/presentation/screens/webview_screen/webview_screen.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_cached_image.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';

class ServiceCard extends StatelessWidget {
  final AdvertisementModel service;

  const ServiceCard({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (service.link != null && service.title != null) {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: WebviewScreen(paymentUrl: service.link!, screenTitle: service.title!),
            withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        }
      },
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppCachedImage(
              imageUrl: service.image?.filePath,
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
                    service.title ?? '',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    maxLines: 2,
                  ),
                  5.ph,
                  AppText(
                    service.details ?? '',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    maxLines: 3,
                  ),
                  5.ph,
                  AppText(
                    service.amount == null ? '' : Utils().formatNumbers(service.amount!),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
