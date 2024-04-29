import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/common/presentation/common_controller.dart';
import 'package:nutrimama/src/features/consume_log/domain/consume_food.dart';
import 'package:nutrimama/src/features/consume_log/presentation/consume_log_controller.dart';
import 'package:nutrimama/src/features/food/domain/food.dart';
import 'package:nutrimama/src/shared/extensions/date_time.dart';

class DetailFoodScreen extends ConsumerWidget {
  final Food food;
  final String consumeAt;
  const DetailFoodScreen(
      {super.key, required this.food, required this.consumeAt});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Detail Makanan",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: food.imageUrl.isEmpty
                  ? Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                            image:
                                AssetImage('assets/images/question_img_2.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                    )
                  : Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(food.imageUrl),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                    ),
            ),
            const SizedBox(height: 10),
            Text(
              food.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // btn tambahkan sarapan
            InkWell(
              onTap: () {
                final uid =
                    ref.read(commonControllerProvider.notifier).getUid();
                ConsumeFood consumeFood = ConsumeFood.fromFood(food, consumeAt);
                ref.read(consumeLogControllerProvider.notifier).addConsumeFood(
                    uid, DateTime.now().toYyyyMMDd, consumeFood);
                // final consumeLogs = ref
                //         .read(consumeLogControllerProvider)
                //         .consumeLogs
                //         .asData
                //         ?.value ??
                //     [];
                // final todayConsumeLog = ref
                //     .read(consumeLogControllerProvider)
                //     .todayConsumeLog
                //     .asData
                //     ?.value;
                // final todayConsumeFoods = ref
                //         .read(consumeLogControllerProvider)
                //         .consumeFoods
                //         .asData
                //         ?.value ??
                //     [];
                // Logger().i(consumeLogs);
                // Logger().i(todayConsumeLog);
                // Logger().i(todayConsumeFoods);
              },
              child: Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Tambahkan Sarapan",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // switching container, it can switch to Nutrisi or Panduan, switch can by swipe the container
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        "Nutrisi",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Panduan",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Nutrisi",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Kalori"),
                      Text(
                        "${food.calories}/2000kcal",
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Protein"),
                      Text(
                        "${food.protein}/50g",
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Karbohidrat"),
                      Text(
                        "${food.carbs}/300g",
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Lemak"),
                      Text(
                        "${food.fat}/70g",
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Gula"),
                      Text(
                        "${food.sugars}/50g",
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Zat Besi"),
                      Text(
                        "${food.iron}/18mg",
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Kalsium"),
                      Text(
                        "${food.calcium}/1000mg",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap.h20,
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Bahan-bahan",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  food.ingredients.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: food.ingredients
                              .map((ingredient) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // ingredient has name and amount
                                      Text(
                                        ingredient.name,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        ingredient.total,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ))
                              .toList(),
                        )
                      : const Text(
                          "Tidak ada bahan",
                          style: TextStyle(fontSize: 16),
                        ),
                  const SizedBox(height: 10),
                  const Text(
                    "Panduan",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  food.instructions.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: food.instructions
                              .map((instruction) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // instruction has title and description
                                        Text(
                                          instruction.title,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          instruction.description,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        )
                      : const Text(
                          "Tidak ada panduan",
                          style: TextStyle(fontSize: 16),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
