import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/common/presentation/common_controller.dart';
import 'package:nutrimama/src/features/education/presentation/education_controller.dart';
import 'package:nutrimama/src/features/journal/presentation/journal_controller.dart';
import 'package:nutrimama/src/routes/routes.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commonState = ref.watch(commonControllerProvider);

    return StatusBarWidget(
      child: Scaffold(
        body: Center(
            child: AsyncValueWidget(
          value: commonState.userValue,
          data: (data) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome ${data.name}',
                    style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    ref.read(goRouterProvider).pushNamed(
                          Routes.medicalRecord.name,
                          extra: Extras(
                            datas: {
                              ExtrasKey.user: data,
                            },
                          ),
                        );
                  },
                  child: const Text('Medical Record'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(goRouterProvider)
                        .pushNamed(Routes.searchFood.name);
                  },
                  child: const Text('Search Food'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await ref
                        .read(educationControllerProvider.notifier)
                        .getVideos();
                    ref.read(goRouterProvider).pushNamed(Routes.video.name);
                  },
                  child: const Text('Videos'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await ref
                        .read(journalControllerProvider.notifier)
                        .getJournals(data.id);
                    ref.read(goRouterProvider).pushNamed(Routes.journal.name,
                        extra: Extras(datas: {ExtrasKey.user: data}));
                  },
                  child: const Text('Journals'),
                ),
                // const SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: () {
                //     ref.read(educationControllerProvider.notifier).addVideo();
                //   },
                //   child: const Text('Add Videos'),
                // ),
              ],
            );
          },
        )),
      ),
    );
  }
}
