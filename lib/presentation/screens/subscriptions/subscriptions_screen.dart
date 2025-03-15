import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/app/res/res.dart';
import 'package:vpm/app/util/information_viewer.dart';
import 'package:vpm/app/util/operation_reply.dart';
import 'package:vpm/data/providers/network/api_provider.dart';
import 'package:vpm/presentation/screens/add_subscription/add_subscription_screen.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';

import '../../../app/util/util.dart';
import '../../../data/models/general_response.dart';
import '../../../data/models/subscriptions_response.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  List<SubscriptionModel> subscriptions = [];
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    setState(() {});
  }

  Future _loadSubscriptions({willLoad = true}) async {
    loading = loading;

    OperationReply operationReply = await APIProvider.instance.get(
      endPoint: Res.apiSubscriptions,
      fromJson: SubscriptionsResponse.fromJson,
    );

    if (operationReply.isSuccess()) {
      loading = false;

      SubscriptionsResponse subscriptionsResponse = operationReply.result;
      subscriptions = subscriptionsResponse.data ?? [];
    } else {
      loading = false;
      InformationViewer.showToastBasedOnReply(operationReply);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSubscriptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText('subscriptions'.tr),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: const AddSubscriptionScreen(),
            withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
          _loadSubscriptions(willLoad: false);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : RefreshIndicator(
              onRefresh: _loadSubscriptions,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  itemBuilder: (context, index) => Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0,
                        vertical: 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            subscriptions[index].garage?.name ?? '',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          10.ph,
                          AppText(
                            subscriptions[index].remainingDays ?? '',
                            color: Colors.grey.shade500,
                          ),
                          10.ph,
                          Row(
                            children: [
                              AppText('${'subscription_fee'.tr} :'),
                              10.pw,
                              AppText(
                                Utils().formatNumbers(
                                    subscriptions[index].amount.toString()),
                                fontSize: 16,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          10.ph,
                          Row(
                            children: [
                              Switch(
                                value: subscriptions[index].autoRenew ?? false,
                                onChanged: (bool value) {
                                  _switchRenew(value, subscriptions[index].id);
                                },
                              ),
                              AppText('auto_renew_subscription'.tr),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => 10.pw,
                  itemCount: subscriptions.length,
                ),
              ),
            ),
    );
  }

  Future _switchRenew(
    bool autoRenew,
    String? id,
  ) async {
    EasyLoading.show();
    OperationReply operationReply = await APIProvider.instance.patch(
      endPoint: "${Res.apiSwitchAutoSubscription}/$id",
      fromJson: GeneralResponse.fromJson,
      requestBody: {
        'auto_renew': autoRenew,
      },
    );

    if (operationReply.isSuccess()) {
      EasyLoading.dismiss();
      GeneralResponse generalResponse = operationReply.result;
      InformationViewer.showSuccessToast(msg: generalResponse.message);
      _loadSubscriptions(willLoad: false);
    } else {
      EasyLoading.dismiss();
      InformationViewer.showToastBasedOnReply(operationReply);
    }
  }
}
