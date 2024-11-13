import 'package:flutter/material.dart';
import 'package:detect_fakes/common/faqs/faq_item.dart';
import 'package:detect_fakes/utils/constants/app_texts.dart';

class GeneralFaqs extends StatelessWidget {
  const GeneralFaqs({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FaqItem(
          question: AppTexts.gQuestion1,
          answer: AppTexts.gAnswer1,
        ),
        FaqItem(
          question: AppTexts.gQuestion2,
          answer: AppTexts.gAnswer2,
        ),
        FaqItem(
          question: AppTexts.gQuestion3,
          answer: AppTexts.gAnswer3,
        ),
        FaqItem(
          question: AppTexts.gQuestion4,
          answer: AppTexts.gAnswer4,
        ),
        FaqItem(
          question: AppTexts.gQuestion5,
          answer: AppTexts.gAnswer5,
        ),
        FaqItem(
          question: AppTexts.gQuestion6,
          answer: AppTexts.gAnswer6,
        ),
      ],
    );
  }
}
