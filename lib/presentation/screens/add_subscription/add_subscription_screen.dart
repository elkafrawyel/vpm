import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/app/res/res.dart';
import 'package:vpm/app/util/information_viewer.dart';
import 'package:vpm/app/util/operation_reply.dart';
import 'package:vpm/app/util/util.dart';
import 'package:vpm/data/models/countries_response.dart';
import 'package:vpm/data/models/garages_response.dart';
import 'package:vpm/data/models/general_response.dart';
import 'package:vpm/data/providers/network/api_provider.dart';
import 'package:vpm/domain/entities/models/garage_model.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_drop_menu.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_progress_button.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';

import '../../../data/models/cities_response.dart';

class AddSubscriptionScreen extends StatefulWidget {
  const AddSubscriptionScreen({super.key});

  @override
  State<AddSubscriptionScreen> createState() => _AddSubscriptionScreenState();
}

class _AddSubscriptionScreenState extends State<AddSubscriptionScreen> {
  /// ============================= Countries ====================================

  List<CountryModel> countries = [];
  CountryModel? selectedCountry;

  bool _loadingCountries = false;

  bool get loadingCountries => _loadingCountries;

  set loadingCountries(bool value) {
    setState(() {
      _loadingCountries = value;
    });
  }

  void _loadCountries() async {
    OperationReply operationReply = await APIProvider.instance.get(
      endPoint: Res.apiCountries,
      fromJson: CountriesResponse.fromJson,
    );

    if (operationReply.isSuccess()) {
      CountriesResponse countriesResponse = operationReply.result;
      countries = countriesResponse.data ?? [];
      // selectedCountry = countries.firstWhere(
      //   (element) => element.prefix == 'KSA',
      // );
      //
      // if (selectedCountry != null) {
      //   _loadCities(selectedCountry!);
      // }
      setState(() {});
    } else {
      InformationViewer.showToastBasedOnReply(operationReply);
    }
  }

  /// ============================= Cities ====================================

  List<CityModel> cities = [];
  CityModel? selectedCity;

  void _loadCities(CountryModel countryModel) async {
    OperationReply operationReply = await APIProvider.instance.get(
      endPoint: '${Res.apiCities}/${countryModel.id}',
      fromJson: CitiesResponse.fromJson,
    );

    if (operationReply.isSuccess()) {
      CitiesResponse citiesResponse = operationReply.result;
      cities = citiesResponse.data ?? [];
      setState(() {});
    } else {
      InformationViewer.showToastBasedOnReply(operationReply);
    }
  }

  ///===================== Subscriptions ===========================================

  List<GarageModel> garages = [];
  GarageModel? selectedGarage;

  void _loadSubscriptions(CityModel cityModel) async {
    OperationReply operationReply = await APIProvider.instance.get(
      endPoint: '${Res.apiGaragesByCity}?governorate_id=${cityModel.id}',
      fromJson: GaragesResponse.fromJson,
    );

    if (operationReply.isSuccess()) {
      GaragesResponse garagesResponse = operationReply.result;
      garages = garagesResponse.garages ?? [];
      setState(() {});
    } else {
      InformationViewer.showToastBasedOnReply(operationReply);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText('add_subscriptions'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            AppDropMenu(
              hint: 'choose_country'.tr,
              items: countries,
              initialValue: selectedCountry,
              onChanged: (CountryModel? country) {
                setState(() {
                  selectedCountry = country;
                });

                if (selectedCountry != null) {
                  _loadCities(selectedCountry!);
                }
              },
              expanded: true,
              bordered: true,
            ),
            10.ph,
            AppDropMenu(
              hint: 'choose_city'.tr,
              items: cities,
              initialValue: selectedCity,
              onChanged: (CityModel? city) {
                setState(() {
                  selectedCity = city;
                });
                if (selectedCity != null) {
                  _loadSubscriptions(selectedCity!);
                }
              },
              expanded: true,
              bordered: true,
            ),
            20.ph,
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    if (selectedGarage == garages[index]) {
                      selectedGarage = null;
                    } else {
                      selectedGarage = garages[index];
                    }
                    setState(() {});
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: garages[index] == selectedGarage
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          AppText(
                            garages[index].name ?? '',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          10.ph,
                          AppText(
                            Utils().formatNumbers(
                                garages[index].subscriptionPrice.toString()),
                            fontSize: 16,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => 10.ph,
                itemCount: garages.length,
              ),
            ),
            AppProgressButton(
              text: 'add_subscriptions'.tr,
              backgroundColor: selectedGarage == null
                  ? Colors.grey
                  : Theme.of(context).primaryColor,
              onPressed: _addNewSubscription,
            )
          ],
        ),
      ),
    );
  }

  Future _addNewSubscription(AnimationController animationController) async {
    if (selectedGarage == null) {
      return;
    } else {
      animationController.forward();
      OperationReply operationReply = await APIProvider.instance.post(
        endPoint: Res.apiAddSubscription,
        fromJson: GeneralResponse.fromJson,
        requestBody: {
          'garage_id': selectedGarage!.id!,
        },
      );

      if (operationReply.isSuccess()) {
        animationController.reverse();
        GeneralResponse generalResponse = operationReply.result;
        InformationViewer.showSuccessToast(msg: generalResponse.message);
        if (mounted) {
          Navigator.of(context).pop();
        }
      } else {
        animationController.reverse();
        InformationViewer.showToastBasedOnReply(operationReply);
      }
    }
  }
}
