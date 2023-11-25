import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/ui/views/intro/bloc/intro_bloc.dart';
import 'package:skybase/ui/views/intro/intro_data.dart';
import 'package:skybase/ui/views/intro/widgets/intro_indicator.dart';

import 'widgets/intro_content.dart';

class IntroView extends StatelessWidget {
  static const String route = '/intro';

  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<IntroBloc, IntroState>(
              builder: (context, state) {
                final bloc = context.read<IntroBloc>();
                return Container(
                  height: kToolbarHeight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (state is IntroFirstPage)
                          ? const SizedBox.shrink()
                          : InkWell(
                              onTap: () => bloc.add(PreviousPage()),
                              child: const Icon(Icons.arrow_back),
                            ),
                      (state is IntroLastPage)
                          ? const SizedBox.shrink()
                          : GestureDetector(
                              onTap: () => bloc.add(SkipPage()),
                              child: const Text(
                                'Lewati',
                                style: TextStyle(color: AppColors.primary),
                              ),
                            ),
                    ],
                  ),
                );
              },
            ),
            Expanded(
              child: PageView.builder(
                itemCount: introItem.length,
                controller: context.read<IntroBloc>().pageController,
                itemBuilder: (context, index) {
                  final item = introItem[index];
                  return IntroContent(
                    image: item.image,
                    title: item.tittle,
                    description: item.description,
                  );
                },
                onPageChanged: (index) {
                  context.read<IntroBloc>().add(ChangePage(index));
                },
              ),
            ),
            const SizedBox(height: 46),
            BlocBuilder<IntroBloc, IntroState>(
              builder: (context, state) {
                final bloc = context.read<IntroBloc>();
                return SizedBox(
                  height: kBottomNavigationBarHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 40,
                        child: Visibility(
                          visible: !bloc.isFirstPage,
                          child: InkWell(
                            onTap: () => bloc.add(PreviousPage()),
                            child: const Icon(
                              Icons.arrow_back,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                      IntroIndicator(
                        itemCount: introItem.length,
                        currentIndex: bloc.currentIndex,
                      ),
                      const SizedBox(width: 48),
                      SizedBox(
                        width: 40,
                        child: Visibility(
                          visible: bloc.isLastPage,
                          child: GestureDetector(
                            onTap: () => bloc.add(DonePage(context)),
                            child: const Text(
                              'Done',
                              style: TextStyle(color: AppColors.primary),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 46),
          ],
        ),
      ),
    );
  }
}
