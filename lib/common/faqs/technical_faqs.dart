import 'package:flutter/material.dart';
import 'package:detect_fakes/common/faqs/faq_item.dart';
import 'package:detect_fakes/utils/constants/app_texts.dart';

class TechnicalFaqs extends StatelessWidget {
  const TechnicalFaqs({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FaqItem(
          question: AppTexts.tQuestion1,
          answer: AppTexts.tAnswer1,
        ),
        FaqItem(
          question: AppTexts.tQuestion2,
          answer: AppTexts.tAnswer2,
        ),
        FaqItem(
          question: AppTexts.tQuestion3,
          answer: AppTexts.tAnswer3,
        ),
        FaqItem(
          question: AppTexts.tQuestion4,
          answer: AppTexts.tAnswer4,
        ),
        FaqItem(
          question: AppTexts.tQuestion5,
          answer: AppTexts.tAnswer5,
        ),
      ],
    );
  }
}
