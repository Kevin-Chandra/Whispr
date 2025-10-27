import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_button.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_button_sizes.dart';
import 'package:whispr/util/constants.dart';
import 'package:whispr/util/extensions.dart';

class FavouriteEmptyBody extends StatelessWidget {
  const FavouriteEmptyBody({
    super.key,
    required this.onAddFavouriteClick,
  });

  final VoidCallback onAddFavouriteClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(ImageConstants.emptyFavouriteImage, height: 150),
          Text(
            context.strings.noFavouritesYet,
            style: WhisprTextStyles.heading4
                .copyWith(color: WhisprColors.spanishViolet),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            context.strings.noFavouritesMessage,
            textAlign: TextAlign.center,
            style: WhisprTextStyles.bodyS
                .copyWith(color: WhisprColors.spanishViolet),
          ),
          SizedBox(
            height: 8,
          ),
          WhisprButton(
            text: context.strings.addFavourites,
            buttonStyle: WhisprButtonStyle.filled,
            buttonSize: WhisprButtonSizes.small,
            onPressed: onAddFavouriteClick,
          )
        ],
      ),
    );
  }
}
