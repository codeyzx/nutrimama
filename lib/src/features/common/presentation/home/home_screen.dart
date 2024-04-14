import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/common/presentation/common_controller.dart';
import 'package:nutrimama/src/routes/routes.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commonState = ref.watch(commonControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
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
                  ref.read(goRouterProvider).pushNamed(Routes.searchFood.name);
                },
                child: const Text('Search Food'),
              ),
            ],
          );
        },
      )),
    );
  }
}
