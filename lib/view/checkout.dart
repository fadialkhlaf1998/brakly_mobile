import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:brakly_mobile/app_localization.dart';
import 'package:brakly_mobile/controller/checkout_controller.dart';
import 'package:brakly_mobile/helper/api.dart';
import 'package:brakly_mobile/helper/app.dart';

class Checkout extends StatelessWidget {
  CheckoutController checkoutController = Get.put(CheckoutController());
  double spaceBetween = 5;

  Checkout() {
    if (API.customer != null) {
      checkoutController.first_name.text = API.customer!.firstname;
      checkoutController.last_name.text = API.customer!.lastname;
      checkoutController.email.text = API.customer!.email;
    }
    if (API.address != null) {
      checkoutController.ISO_code = API.address!.ISO_code;
      checkoutController.phonePref = API.address!.phone_pref;
      checkoutController.country = API.address!.country;
      checkoutController.phone.text = API.address!.phone;
      checkoutController.state.text = API.address!.state;
      checkoutController.apartment.text = API.address!.apartment;
      checkoutController.email.text = API.address!.email;
      checkoutController.address1.text = API.address!.address1;
      checkoutController.address2.text = API.address!.address2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(App_Localization.of(context).translate("checkout")),
        centerTitle: true,
      ),
      body: Obx(() {
        return SafeArea(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.85,
          child: SingleChildScrollView(
            child: Column(
              children: [
                checkoutController.fake.value ? Center() : Center(),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      myTextFieldHalf(context, checkoutController.first_name,
                          "first_name", "fn_required"),
                      myTextFieldHalf(context, checkoutController.last_name,
                          "last_name", "ln_required"),
                    ],
                  ),
                ),
                SizedBox(height: spaceBetween),
                myTextField(context, checkoutController.email, "email",
                    "email_required"),
                SizedBox(height: spaceBetween),
                myTextField(context, checkoutController.address1, "address1",
                    "address1_required"),
                SizedBox(height: spaceBetween),
                myTextField(context, checkoutController.address2, "address2",
                    "address2_required"),
                SizedBox(height: spaceBetween),
                myTextField(context, checkoutController.apartment, "apartment",
                    "apartment_required"),
                SizedBox(height: spaceBetween),
                myTextField(context, checkoutController.state, "state",
                    "state_required"),
                SizedBox(height: spaceBetween),
                phone(context),
                SizedBox(height: spaceBetween),
                countryPickerBtn(context),
                SizedBox(height: spaceBetween),
                submit(context),
                SizedBox(height: spaceBetween),
              ],
            ),
          ),
        ));
      }),
    );
  }

  myTextFieldHalf(BuildContext context, TextEditingController controller,
      String hint, String err_txt) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      child: TextField(
        onChanged: (query) {
          checkoutController.fake.value = !checkoutController.fake.value;
        },
        controller: controller,
        decoration: InputDecoration(
            label: Text(
              App_Localization.of(context).translate(hint),
              style: TextStyle(fontSize: 13),
            ),
            errorText:
                checkoutController.validate.value && controller.text.isEmpty
                    ? App_Localization.of(context).translate(err_txt)
                    : null),
      ),
    );
  }

  myTextField(BuildContext context, TextEditingController controller,
      String hint, String err_txt) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextField(
        onChanged: (query) {
          checkoutController.fake.value = !checkoutController.fake.value;
        },
        controller: controller,
        decoration: InputDecoration(
            label: Text(
              App_Localization.of(context).translate(hint),
              style: TextStyle(fontSize: 13),
            ),
            errorText:
                checkoutController.validate.value && controller.text.isEmpty
                    ? App_Localization.of(context).translate(err_txt)
                    : null),
      ),
    );
  }

  phone(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: InternationalPhoneNumberInput(
        onInputChanged: (PhoneNumber number) {
          checkoutController.phonePref = number.dialCode.toString();
          checkoutController.ISO_code = number.isoCode.toString();
          checkoutController.fake.value = !checkoutController.fake.value;
          print(number.dialCode);
          print(number.isoCode);
        },
        onInputValidated: (bool value) {
          print(value);
        },
        selectorConfig: SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        ),
        ignoreBlank: true,
        maxLength: 9,
        autoValidateMode: AutovalidateMode.disabled,
        selectorTextStyle: TextStyle(color: Colors.black),
        initialValue: PhoneNumber(
            dialCode: checkoutController.phonePref,
            isoCode: checkoutController.ISO_code),
        textFieldController: checkoutController.phone,
        formatInput: false,
        inputDecoration: InputDecoration(
            label: Text(
              App_Localization.of(context).translate("phone"),
              style: TextStyle(fontSize: 13),
            ),
            errorText: checkoutController.validate.value &&
                    checkoutController.phone.text.isEmpty
                ? App_Localization.of(context).translate("phone_required")
                : null),
        keyboardType:
            TextInputType.numberWithOptions(signed: true, decimal: true),
        inputBorder: OutlineInputBorder(),
        onSaved: (PhoneNumber number) {
          print('On Saved: $number');
        },
      ),
    );
  }

  countryPickerBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCountryPicker(
          context: context,
          onSelect: (Country country) {
            print(checkoutController.country);
            print('Select country: ${country.displayName}');
            checkoutController.country = country.displayNameNoCountryCode;
            checkoutController.fake.value = !checkoutController.fake.value;
          },
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 40,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              checkoutController.country,
              style: TextStyle(color: Colors.grey[600]),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.grey[600])
          ],
        ),
      ),
    );
  }

  submit(BuildContext context) {
    return GestureDetector(
      onTap: () {
        checkoutController.submit();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 40,
        decoration: BoxDecoration(
            color: App.primery, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            App_Localization.of(context).translate("submit"),
            style: TextStyle(color: App.secondry),
          ),
        ),
      ),
    );
  }
}
