import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrimama/gen/assets.gen.dart';
import 'package:nutrimama/src/common_widgets/async_value/async_value_widget.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/food/domain/food.dart';
import 'package:nutrimama/src/features/food/presentation/food_controller.dart';
import 'package:nutrimama/src/routes/app_routes.dart';
import 'package:nutrimama/src/routes/extras.dart';

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
              controller: state.searchController,
              onChanged: (value) {
                controller.searchFoods();
              },
              decoration: InputDecoration(
                hintText: 'Cari makanan',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     controller.addFood();
          //   },
          //   child: const Text('Add Food'),
          // ),
          AsyncValueWidget(
            value: state.searchFoods,
            data: (foods) {
              return Column(
                children: foods!.map((food) {
                  return FoodItem(food);
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FoodItem extends ConsumerWidget {
  final Food food;

  const FoodItem(this.food, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        onTap: () {
          ref.read(goRouterProvider).pushNamed(
                Routes.detailFood.name,
                extra: Extras(
                  datas: {
                    ExtrasKey.food: food,
                  },
                ),
              );
        },
        child: ListTile(
          leading: food.imageUrl.isEmpty
              ? CachedNetworkImage(
                  imageUrl: food.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
              : Assets.images.nutrimamaLogo.svg(width: 50, height: 50),
          title: Text(food.name),
          subtitle: Text('${food.calories} kalori'),
        ),
      ),
    );
  }
}
