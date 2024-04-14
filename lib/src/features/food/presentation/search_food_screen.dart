import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrimama/gen/assets.gen.dart';
import 'package:nutrimama/src/features/food/presentation/food_controller.dart';

class SearchFoodScreen extends ConsumerWidget {
  const SearchFoodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(foodControllerProvider.notifier);
    final state = ref.watch(foodControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pencarian', style: TextStyle(color: Colors.black)),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari makanan',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.addFood();
            },
            child: const Text('Add Food'),
          ),
          const FoodItem('Salad Buah', 270),
          const FoodItem('Semangkuk Salad', 270),
          const FoodItem('Salad Buah-Buahan Lengkap', 120),
          const FoodItem('Semangkuk Salad', 270),
          const FoodItem('Salad Campur', 220),
          const FoodItem('Salad Buah-Buahan Lengkap', 120),
        ],
      ),
    );
  }
}

class FoodItem extends StatelessWidget {
  final String saladName;
  final int calories;

  const FoodItem(this.saladName, this.calories, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {},
        child: ListTile(
          leading: Assets.images.nutrimamaLogo.svg(width: 50, height: 50),
          title: Text(saladName),
          subtitle: Text('$calories Kkal'),
        ),
      ),
    );
  }
}
