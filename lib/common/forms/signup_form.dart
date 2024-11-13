import 'package:detect_fakes/controllers/account/signup_controller.dart';
import 'package:detect_fakes/utils/others/validation_utils.dart';
import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:detect_fakes/utils/constants/app_texts.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({
    super.key,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final controller = Get.put(SignUpController());

  String? selectedGender;
  IconData genderIcon = Icons.people;
  final List<String> genderOptions = ['Male', 'Female', 'Rather Not Say'];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.signUpFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: controller.firstNameController,
            decoration: const InputDecoration(
              labelText: AppTexts.firstName,
              prefixIcon: Icon(Iconsax.user),
            ),
            validator: (value) => ValidationUtils.validateEmptyString(
              AppTexts.firstName,
              value,
            ),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwInputFields,
          ),
          TextFormField(
            controller: controller.lastNameController,
            decoration: const InputDecoration(
              labelText: AppTexts.lastName,
              prefixIcon: Icon(Iconsax.user),
            ),
            validator: (value) => ValidationUtils.validateEmptyString(
              AppTexts.lastName,
              value,
            ),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwInputFields,
          ),
          TextFormField(
            controller: controller.dateOfBirthController,
            decoration: const InputDecoration(
              labelText: AppTexts.dateOfBirth,
              prefixIcon: Icon(Iconsax.calendar),
            ),
            readOnly: true,
            keyboardType: TextInputType.datetime,
            onTap: showCalender,
            validator: (value) => ValidationUtils.validateEmptyString(
              AppTexts.dateOfBirth,
              value,
            ),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwInputFields,
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              prefixIcon: Icon(genderIcon),
              labelText: AppTexts.gender,
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSizes.md,
              ),
            ),
            dropdownColor: Get.isDarkMode ? AppColors.dark : AppColors.light,
            value: selectedGender,
            onChanged: (newValue) {
              setState(() {
                selectedGender = newValue;
                if (newValue != null) {
                  controller.genderController.text = newValue;
                }
              });
            },
            items: genderOptions.map((gender) {
              return DropdownMenuItem<String>(
                value: gender,
                child: Row(
                  children: [
                    const SizedBox(width: AppSizes.sm),
                    Text(
                      gender,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(width: AppSizes.md),
                    Icon(
                      getGenderIcon(gender),
                      color: AppColors.primary,
                    ),
                  ],
                ),
              );
            }).toList(),
            validator: (value) => ValidationUtils.validateEmptyString(
              AppTexts.gender,
              value,
            ),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwInputFields,
          ),
          TextFormField(
            controller: controller.countryController,
            decoration: const InputDecoration(
              labelText: AppTexts.country,
              prefixIcon: Icon(Iconsax.global),
            ),
            readOnly: true,
            onTap: countryPicker,
            validator: (value) => ValidationUtils.validateEmptyString(
              AppTexts.country,
              value,
            ),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwInputFields,
          ),
          TextFormField(
            controller: controller.emailController,
            decoration: const InputDecoration(
              labelText: AppTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
            validator: (value) => ValidationUtils.validateEmail(
              value,
            ),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwInputFields,
          ),
          Obx(
            () => TextFormField(
              obscureText: controller.hideNewPassword.value,
              controller: controller.newPasswordController,
              decoration: InputDecoration(
                labelText: AppTexts.newPassword,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.hideNewPassword.value =
                        !controller.hideNewPassword.value;
                  },
                  icon: Icon(
                    controller.hideNewPassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
              validator: (value) => ValidationUtils.validatePassword(
                AppTexts.newPassword,
                value,
              ),
            ),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwInputFields,
          ),
          Obx(
            () => TextFormField(
              obscureText: controller.hideConfPassword.value,
              controller: controller.confPasswordController,
              decoration: InputDecoration(
                labelText: AppTexts.confPassword,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.hideConfPassword.value =
                        !controller.hideConfPassword.value;
                  },
                  icon: Icon(
                    controller.hideConfPassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
              validator: (value) {
                String? error = ValidationUtils.validatePassword(
                  AppTexts.confPassword,
                  value,
                );
                error ??= ValidationUtils.validateMatchingPasswords(
                  controller.newPasswordController.text,
                  value,
                );
                return error;
              },
            ),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwInputFields,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                controller.signUp();
              },
              child: const Text(
                AppTexts.createAccount,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void countryPicker() {
    showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
        flagSize: 20,
        bottomSheetHeight: Get.height * 0.8,
        backgroundColor: Get.isDarkMode ? AppColors.black : AppColors.light,
        borderRadius: BorderRadius.circular(20),
      ),
      onSelect: (country) {
        setState(
          () {
            controller.countryController.text =
                '  ${country.displayNameNoCountryCode}    ${country.flagEmoji}';
          },
        );
      },
    );
  }

  Future<void> showCalender() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1947),
      lastDate: DateTime(2020),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Theme.of(context).primaryColor,
                  onPrimary: Theme.of(context).colorScheme.onPrimary,
                  surface: Theme.of(context).colorScheme.surface,
                  onSurface: Theme.of(context).colorScheme.onSurface,
                ),
            dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      controller.dateOfBirthController.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      setState(() {});
    }
  }

  IconData getGenderIcon(String gender) {
    if (gender == "Male") {
      return Icons.male;
    } else if (gender == "Female") {
      return Icons.female;
    } else if (gender == "Rather Not Say") {
      return Icons.block;
    } else {
      return Icons.people;
    }
  }
}
