import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nutrimama/gen/assets.gen.dart';
import 'package:nutrimama/src/common_widgets/async_value/async_value_widget.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/food/domain/food.dart';
import 'package:nutrimama/src/features/food/presentation/food_controller.dart';
import 'package:nutrimama/src/routes/app_routes.dart';
import 'package:nutrimama/src/routes/extras.dart';

class SearchFoodScreen extends ConsumerWidget {
  final String consumeAt;
  const SearchFoodScreen({super.key, required this.consumeAt});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(foodControllerProvider.notifier);
    final state = ref.watch(foodControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pencarian', style: TypographyApp.appBarFoodSearch),
        centerTitle: true,
        leadingWidth: 78.w,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          iconSize: 20,
          padding: EdgeInsets.all(8.0),
          color: Colors.black,
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
              side: BorderSide(color: HexColor('#CCD1D6'), width: 0.3.w),
            ),
            backgroundColor: Colors.white,
            padding: EdgeInsets.all(8),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 378.w,
                child: TextField(
                  controller: state.searchController,
                  onChanged: (value) {
                    controller.searchFoods();
                  },
                  style: TypographyApp.txtFoodSearch,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: HexColor('#F2F2F2'),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 18.w),
                    hintText: 'Cari makanan',
                    hintStyle: TypographyApp.hintFoodSearch,
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: HexColor('#8E9195'),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.r),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              SizedBox(
                height: 24.h,
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
                      return FoodItem(food, consumeAt);
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FoodItem extends ConsumerWidget {
  final Food food;
  final String consumeAt;

  const FoodItem(this.food, this.consumeAt, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            ref.read(goRouterProvider).pushNamed(
              Routes.detailFood.name,
              extra: Extras(
                datas: {
                  ExtrasKey.food: food,
                  ExtrasKey.consumeAt: consumeAt,
                },
              ),
            );
          },
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: food.imageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: food.imageUrl,
                          width: 64.w,
                          height: 56.h,
                          fit: BoxFit.cover,
                        )
                      : Assets.images.nutrimamaLogo.svg(width: 50, height: 50),
                ),
                SizedBox(
                  width: 14.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      style: TypographyApp.foodNameHome,
                    ),
                    Text(
                      '${food.calories} Kkal',
                      style: TypographyApp.foodCalHome,
                    )
                  ],
                ),
              ],
            ),
        ),
        SizedBox(height: 24.h,),
      ],
    );
    // return Container(
    //   width: 378.w,
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(10),
    //     boxShadow: const [
    //       BoxShadow(
    //         color: Colors.grey,
    //         blurRadius: 5,
    //         offset: Offset(0, 3),
    //       ),
    //     ],
    //   ),
    //   child: InkWell(
    //     onTap: () {
    //       ref.read(goRouterProvider).pushNamed(
    //             Routes.detailFood.name,
    //             extra: Extras(
    //               datas: {
    //                 ExtrasKey.food: food,
    //                 ExtrasKey.consumeAt: consumeAt,
    //               },
    //             ),
    //           );
    //     },
    //     child: ListTile(
    //       leading: food.imageUrl.isNotEmpty
    //           ? CachedNetworkImage(
    //               imageUrl: food.imageUrl,
    //               width: 50,
    //               height: 50,
    //               fit: BoxFit.cover,
    //             )
    //           : Assets.images.nutrimamaLogo.svg(width: 50, height: 50),
    //       title: Text(food.name),
    //       subtitle: Text('${food.calories} kalori'),
    //     ),
    //   ),
    // );
  }
}
