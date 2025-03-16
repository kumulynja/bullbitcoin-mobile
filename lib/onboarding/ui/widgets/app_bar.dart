import 'package:bb_mobile/_ui/components/navbar/top_bar.dart';
import 'package:bb_mobile/_ui/themes/app_theme.dart';
import 'package:bb_mobile/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OnboardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OnboardingAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colour.primary,
      flexibleSpace: TopBar(
        title: 'Recover Wallet',
        onBack: () {
          context.read<OnboardingBloc>().add(const OnboardingGoBack());
          context.pop();
        },
      ).animate(delay: 400.ms).fadeIn(),
      automaticallyImplyLeading: false,
      forceMaterialTransparency: true,
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, kToolbarHeight);
}
