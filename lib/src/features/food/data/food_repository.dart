import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrimama/src/features/food/domain/food.dart';
import 'package:nutrimama/src/services/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'food_repository.g.dart';

class FoodRepository {
  final foodDb = FirebaseFirestore.instance.collection('foods').withConverter(
        fromFirestore: (snapshot, _) => Food.fromJson(snapshot.data()!),
        toFirestore: (Food food, _) => food.toJson(),
      );

  Future<Result<List<Food>>> getFoods() async {
    try {
      final resultFoods = await foodDb.get();
      final foods = resultFoods.docs.map((e) => e.data()).toList();
      return Result.success(foods);
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<Food>> getFood(String id) async {
    try {
      final resultFood = await foodDb.doc(id).get();
      final food = resultFood.data();
      return Result.success(food!);
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<String>> addFood() async {
    try {
      final listFood = [
        {
          "id": "1",
          "name": "Nasi Goreng",
          "type": "food",
          "calories": 300,
          "protein": 10,
          "carbs": 40,
          "sugars": 2,
          "fat": 12,
          "iron": 2,
          "calcium": 1,
          "ingredients": [
            {"name": "Nasi", "total": "1 piring"},
            {"name": "Bawang Merah", "total": "3 siung"},
            {"name": "Bawang Putih", "total": "2 siung"},
            {"name": "Cabai Merah", "total": "2 buah"},
            {"name": "Telur", "total": "2 butir"},
            {"name": "Kecap Manis", "total": "2 sendok makan"},
            {"name": "Minyak Goreng", "total": "3 sendok makan"}
          ],
          "instructions": [
            {
              "title": "Langkah 1",
              "description":
                  "Panaskan minyak goreng, tumis bawang merah, bawang putih, dan cabai merah hingga harum."
            },
            {
              "title": "Langkah 2",
              "description":
                  "Masukkan nasi, aduk rata, tambahkan kecap manis, aduk kembali hingga tercampur merata."
            },
            {
              "title": "Langkah 3",
              "description":
                  "Pindahkan nasi ke pinggiran wajan, pecahkan telur di tengah, biarkan setengah matang, lalu aduk bersama nasi hingga telur matang."
            },
            {
              "title": "Langkah 4",
              "description":
                  "Sajikan nasi goreng panas dengan irisan mentimun, tomat, dan kerupuk."
            }
          ],
          "imageUrl": "https://example.com/nasi_goreng.jpg"
        },
        {
          "id": "2",
          "name": "Sate Ayam",
          "type": "food",
          "calories": 250,
          "protein": 15,
          "carbs": 10,
          "sugars": 2,
          "fat": 10,
          "iron": 1,
          "calcium": 1,
          "ingredients": [
            {"name": "Daging Ayam", "total": "200 gram"},
            {"name": "Bawang Merah", "total": "5 siung"},
            {"name": "Kecap Manis", "total": "3 sendok makan"},
            {"name": "Bambu Bakar", "total": "10 tusuk"}
          ],
          "instructions": [
            {
              "title": "Langkah 1",
              "description":
                  "Potong daging ayam kecil-kecil, tusukkan ke tusuk sate secara merata."
            },
            {
              "title": "Langkah 2",
              "description":
                  "Campur daging ayam dengan bawang merah dan kecap manis, diamkan selama 1 jam."
            },
            {
              "title": "Langkah 3",
              "description":
                  "Panggang sate di atas bara api, bolak-balik hingga matang dan berwarna kecokelatan."
            },
            {
              "title": "Langkah 4",
              "description":
                  "Sajikan sate ayam panas dengan bumbu kacang, lontong, dan irisan bawang merah."
            }
          ],
          "imageUrl": "https://example.com/sate_ayam.jpg"
        },
        {
          "id": "3",
          "name": "Gado-Gado",
          "type": "food",
          "calories": 200,
          "protein": 8,
          "carbs": 20,
          "sugars": 5,
          "fat": 10,
          "iron": 2,
          "calcium": 2,
          "ingredients": [
            {"name": "Kentang", "total": "200 gram"},
            {"name": "Tauge", "total": "100 gram"},
            {"name": "Ketimun", "total": "1 buah"},
            {"name": "Tahu", "total": "1 kotak"},
            {"name": "Telur Rebus", "total": "2 butir"}
          ],
          "instructions": [
            {
              "title": "Langkah 1",
              "description":
                  "Rebus telur hingga matang, kupas, dan potong-potong."
            },
            {
              "title": "Langkah 2",
              "description": "Rebus kentang hingga lunak, potong-potong."
            },
            {
              "title": "Langkah 3",
              "description":
                  "Potong tahu menjadi dadu, goreng hingga kecokelatan."
            },
            {
              "title": "Langkah 4",
              "description":
                  "Susun semua bahan di atas piring, siram dengan bumbu kacang, sajikan."
            }
          ],
          "imageUrl": "https://example.com/gado_gado.jpg"
        },
        {
          "id": "4",
          "name": "Rendang",
          "type": "food",
          "calories": 400,
          "protein": 20,
          "carbs": 15,
          "sugars": 3,
          "fat": 25,
          "iron": 3,
          "calcium": 2,
          "ingredients": [
            {"name": "Daging Sapi", "total": "500 gram"},
            {"name": "Santan Kelapa", "total": "400 ml"},
            {"name": "Serai", "total": "2 batang"},
            {"name": "Daun Jeruk", "total": "5 lembar"},
            {"name": "Cabai Merah", "total": "5 buah"},
            {"name": "Bawang Merah", "total": "10 siung"}
          ],
          "instructions": [
            {
              "title": "Langkah 1",
              "description":
                  "Rebus daging sapi hingga setengah matang, tiriskan."
            },
            {
              "title": "Langkah 2",
              "description":
                  "Tumis bumbu halus, serai, daun jeruk hingga harum."
            },
            {
              "title": "Langkah 3",
              "description": "Masukkan daging sapi, aduk hingga bumbu meresap."
            },
            {
              "title": "Langkah 4",
              "description":
                  "Tambahkan santan, masak hingga daging empuk dan bumbu mengental."
            }
          ],
          "imageUrl": "https://example.com/rendang.jpg"
        },
        {
          "id": "5",
          "name": "Soto Ayam",
          "type": "food",
          "calories": 300,
          "protein": 12,
          "carbs": 25,
          "sugars": 4,
          "fat": 15,
          "iron": 2,
          "calcium": 2,
          "ingredients": [
            {"name": "Daging Ayam", "total": "300 gram"},
            {"name": "Bawang Merah", "total": "4 siung"},
            {"name": "Bawang Putih", "total": "3 siung"},
            {"name": "Jahe", "total": "1 ruas jari"},
            {"name": "Kecap Manis", "total": "2 sendok makan"}
          ],
          "instructions": [
            {
              "title": "Langkah 1",
              "description":
                  "Rebus daging ayam hingga empuk, angkat, potong-potong."
            },
            {
              "title": "Langkah 2",
              "description":
                  "Tumis bumbu halus hingga harum, tambahkan kecap manis."
            },
            {
              "title": "Langkah 3",
              "description":
                  "Didihkan air, tambahkan bumbu yang telah ditumis dan daging ayam."
            },
            {
              "title": "Langkah 4",
              "description":
                  "Sajikan soto ayam dengan nasi, taoge, daun seledri, dan bawang goreng."
            }
          ],
          "imageUrl": "https://example.com/soto_ayam.jpg"
        },
        {
          "id": "6",
          "name": "Ayam Bakar",
          "type": "food",
          "calories": 350,
          "protein": 25,
          "carbs": 5,
          "sugars": 1,
          "fat": 20,
          "iron": 2,
          "calcium": 1,
          "ingredients": [
            {"name": "Daging Ayam", "total": "500 gram"},
            {"name": "Lengkuas", "total": "2 ruas jari"},
            {"name": "Serai", "total": "2 batang"},
            {"name": "Lada", "total": "1 sendok teh"},
            {"name": "Garam", "total": "secukupnya"},
            {"name": "Minyak Goreng", "total": "3 sendok makan"}
          ],
          "instructions": [
            {
              "title": "Langkah 1",
              "description":
                  "Campur daging ayam dengan bumbu halus (lengkuas, serai, lada, dan garam)."
            },
            {
              "title": "Langkah 2",
              "description": "Diamkan selama beberapa jam agar bumbu meresap."
            },
            {
              "title": "Langkah 3",
              "description":
                  "Bakar ayam di atas bara api hingga matang dan berwarna kecokelatan."
            },
            {
              "title": "Langkah 4",
              "description":
                  "Sajikan ayam bakar panas dengan sambal dan nasi hangat."
            }
          ],
          "imageUrl": "https://example.com/ayam_bakar.jpg"
        },
        {
          "id": "7",
          "name": "Sop Buntut",
          "type": "food",
          "calories": 400,
          "protein": 18,
          "carbs": 30,
          "sugars": 5,
          "fat": 20,
          "iron": 3,
          "calcium": 2,
          "ingredients": [
            {"name": "Buntut Sapi", "total": "1 kg"},
            {"name": "Wortel", "total": "2 buah"},
            {"name": "Kentang", "total": "2 buah"},
            {"name": "Daun Bawang", "total": "1 batang"},
            {"name": "Bawang Bombay", "total": "1 buah"},
            {"name": "Serai", "total": "2 batang"}
          ],
          "instructions": [
            {
              "title": "Langkah 1",
              "description": "Rebus buntut sapi hingga empuk, tiriskan."
            },
            {
              "title": "Langkah 2",
              "description": "Tumis bawang bombay dan serai hingga harum."
            },
            {
              "title": "Langkah 3",
              "description": "Tambahkan buntut sapi dan air, didihkan."
            },
            {
              "title": "Langkah 4",
              "description":
                  "Masukkan wortel, kentang, dan daun bawang, masak hingga sayuran matang."
            }
          ],
          "imageUrl": "https://example.com/sop_buntut.jpg"
        },
        {
          "id": "8",
          "name": "Pisang Goreng",
          "type": "food",
          "calories": 200,
          "protein": 2,
          "carbs": 30,
          "sugars": 10,
          "fat": 10,
          "iron": 1,
          "calcium": 1,
          "ingredients": [
            {"name": "Pisang Raja", "total": "4 buah"},
            {"name": "Tepung Terigu", "total": "100 gram"},
            {"name": "Gula Pasir", "total": "50 gram"},
            {"name": "Air Es", "total": "100 ml"},
            {"name": "Minyak Goreng", "total": "secukupnya"}
          ],
          "instructions": [
            {
              "title": "Langkah 1",
              "description": "Kupas pisang, potong menjadi dua."
            },
            {
              "title": "Langkah 2",
              "description":
                  "Campur tepung terigu, gula pasir, dan air es hingga adonan berbentuk pasta."
            },
            {
              "title": "Langkah 3",
              "description":
                  "Celupkan pisang ke dalam adonan tepung, goreng hingga kecokelatan."
            },
            {
              "title": "Langkah 4",
              "description":
                  "Angkat, tiriskan, dan sajikan pisang goreng hangat."
            }
          ],
          "imageUrl": "https://example.com/pisang_goreng.jpg"
        },
        {
          "id": "9",
          "name": "Pecel Lele",
          "type": "food",
          "calories": 350,
          "protein": 20,
          "carbs": 25,
          "sugars": 3,
          "fat": 15,
          "iron": 2,
          "calcium": 1,
          "ingredients": [
            {"name": "Lele Segar", "total": "500 gram"},
            {"name": "Terasi", "total": "2 sendok teh"},
            {"name": "Kencur", "total": "1 ruas jari"},
            {"name": "Cabai Rawit", "total": "5 buah"},
            {"name": "Daun Kemangi", "total": "1 ikat"}
          ],
          "instructions": [
            {
              "title": "Langkah 1",
              "description":
                  "Bersihkan lele, lumuri dengan terasi dan garam, diamkan selama 30 menit."
            },
            {
              "title": "Langkah 2",
              "description":
                  "Goreng lele hingga matang dan berwarna kecokelatan."
            },
            {
              "title": "Langkah 3",
              "description": "Haluskan kencur, cabai rawit, dan garam."
            },
            {
              "title": "Langkah 4",
              "description":
                  "Sajikan lele goreng dengan sambal dan daun kemangi."
            }
          ],
          "imageUrl": "https://example.com/pecel_lele.jpg"
        },
        {
          "id": "10",
          "name": "Es Campur",
          "type": "drink",
          "calories": 150,
          "protein": 1,
          "carbs": 30,
          "sugars": 20,
          "fat": 1,
          "iron": 1,
          "calcium": 2,
          "ingredients": [
            {"name": "Es Serut", "total": "300 gram"},
            {"name": "Kolang-Kaling", "total": "50 gram"},
            {"name": "Cendol", "total": "100 gram"},
            {"name": "Biji Selasih", "total": "2 sendok makan"},
            {"name": "Santan Kelapa", "total": "200 ml"},
            {"name": "Gula Merah Cair", "total": "secukupnya"}
          ],
          "instructions": [
            {"title": "Langkah 1", "description": "Siapkan semua bahan."},
            {
              "title": "Langkah 2",
              "description": "Masukkan es serut ke dalam mangkuk besar."
            },
            {
              "title": "Langkah 3",
              "description":
                  "Tambahkan kolang-kaling, cendol, dan biji selasih."
            },
            {
              "title": "Langkah 4",
              "description":
                  "Tuangkan santan kelapa dan gula merah cair di atasnya, sajikan segera."
            }
          ],
          "imageUrl": "https://example.com/es_campur.jpg"
        },
        {
          "id": "11",
          "name": "Bakso Malang",
          "type": "food",
          "calories": 300,
          "protein": 18,
          "carbs": 25,
          "sugars": 2,
          "fat": 15,
          "iron": 2,
          "calcium": 1,
          "ingredients": [
            {"name": "Daging Sapi Giling", "total": "500 gram"},
            {"name": "Tepung Kanji", "total": "100 gram"},
            {"name": "Tahu", "total": "1 kotak"},
            {"name": "Telur Ayam", "total": "2 butir"},
            {"name": "Kecap Manis", "total": "2 sendok makan"}
          ],
          "instructions": [
            {
              "title": "Langkah 1",
              "description":
                  "Campur daging sapi giling dengan tepung kanji, telur, dan bumbu halus."
            },
            {
              "title": "Langkah 2",
              "description":
                  "Bentuk adonan menjadi bulatan kecil, rebus hingga matang."
            },
            {
              "title": "Langkah 3",
              "description":
                  "Siapkan mangkuk, tambahkan tahu, bakso, mie kuning, sayuran, dan kuah."
            },
            {
              "title": "Langkah 4",
              "description":
                  "Sajikan bakso Malang panas dengan bumbu kacang dan sambal."
            }
          ],
          "imageUrl": "https://example.com/bakso_malang.jpg"
        },
        {
          "id": "12",
          "name": "Martabak Manis",
          "type": "food",
          "calories": 400,
          "protein": 8,
          "carbs": 40,
          "sugars": 20,
          "fat": 20,
          "iron": 2,
          "calcium": 2,
          "ingredients": [
            {"name": "Tepung Terigu", "total": "250 gram"},
            {"name": "Gula Pasir", "total": "100 gram"},
            {"name": "Telur Ayam", "total": "3 butir"},
            {"name": "Susu Cair", "total": "250 ml"},
            {"name": "Keju Parut", "total": "100 gram"},
            {"name": "Mentega Cair", "total": "50 gram"}
          ],
          "instructions": [
            {
              "title": "Langkah 1",
              "description":
                  "Campur tepung terigu, gula pasir, telur, susu cair, dan mentega cair, aduk hingga rata."
            },
            {
              "title": "Langkah 2",
              "description": "Panaskan wajan datar, tuangkan adonan, ratakan."
            },
            {
              "title": "Langkah 3",
              "description":
                  "Taburkan keju parut di atas adonan, tutup wajan, biarkan hingga matang."
            },
            {
              "title": "Langkah 4",
              "description":
                  "Lipat martabak, potong-potong, sajikan dengan topping sesuai selera."
            }
          ],
          "imageUrl": "https://example.com/martabak_manis.jpg"
        },
        {
          "id": "13",
          "name": "Nasi Uduk",
          "type": "food",
          "calories": 350,
          "protein": 10,
          "carbs": 40,
          "sugars": 5,
          "fat": 15,
          "iron": 2,
          "calcium": 1,
          "ingredients": [
            {"name": "Beras", "total": "2 gelas"},
            {"name": "Santan Kelapa", "total": "400 ml"},
            {"name": "Serai", "total": "2 batang"},
            {"name": "Daun Salam", "total": "3 lembar"},
            {"name": "Telur Rebus", "total": "2 butir"},
            {"name": "Kacang Goreng", "total": "secukupnya"}
          ],
          "instructions": [
            {"title": "Langkah 1", "description": "Cuci beras, tiriskan."},
            {
              "title": "Langkah 2",
              "description": "Rebus santan, serai, daun salam, hingga mendidih."
            },
            {
              "title": "Langkah 3",
              "description":
                  "Masukkan beras, aduk rata, masak hingga air meresap."
            },
            {
              "title": "Langkah 4",
              "description":
                  "Sajikan nasi uduk dengan telur rebus, kacang goreng, dan lauk lainnya."
            }
          ],
          "imageUrl": "https://example.com/nasi_uduk.jpg"
        },
        {
          "id": "14",
          "name": "Tahu Tek",
          "type": "food",
          "calories": 250,
          "protein": 12,
          "carbs": 20,
          "sugars": 3,
          "fat": 10,
          "iron": 2,
          "calcium": 1,
          "ingredients": [
            {"name": "Tahu Putih", "total": "300 gram"},
            {"name": "Kentang", "total": "2 buah"},
            {"name": "Telur Rebus", "total": "3 butir"},
            {"name": "Taoge", "total": "100 gram"},
            {"name": "Bawang Goreng", "total": "secukupnya"},
            {"name": "Kecap Manis", "total": "2 sendok makan"}
          ],
          "instructions": [
            {
              "title": "Langkah 1",
              "description":
                  "Potong tahu dan kentang menjadi dadu, goreng hingga kecokelatan."
            },
            {
              "title": "Langkah 2",
              "description": "Potong telur rebus menjadi dua."
            },
            {
              "title": "Langkah 3",
              "description":
                  "Susun tahu, kentang, dan telur rebus di atas piring."
            },
            {
              "title": "Langkah 4",
              "description":
                  "Siram dengan bumbu kacang, taburkan taoge dan bawang goreng."
            }
          ],
          "imageUrl": "https://example.com/tahu_tek.jpg"
        },
        {
          "id": "15",
          "name": "Es Jeruk",
          "type": "drink",
          "calories": 100,
          "protein": 0,
          "carbs": 25,
          "sugars": 20,
          "fat": 0,
          "iron": 1,
          "calcium": 1,
          "ingredients": [
            {"name": "Jeruk", "total": "2 buah"},
            {"name": "Gula Pasir", "total": "2 sendok makan"},
            {"name": "Air Es", "total": "300 ml"},
            {"name": "Daun Mint", "total": "2 helai"},
            {"name": "Es Serut", "total": "secukupnya"}
          ],
          "instructions": [
            {
              "title": "Langkah 1",
              "description": "Peras jeruk, saring airnya."
            },
            {
              "title": "Langkah 2",
              "description":
                  "Campur air jeruk dengan gula pasir, aduk hingga gula larut."
            },
            {
              "title": "Langkah 3",
              "description":
                  "Tuangkan air es, tambahkan daun mint dan es serut."
            },
            {
              "title": "Langkah 4",
              "description": "Aduk rata, sajikan es jeruk segar."
            }
          ],
          "imageUrl": "https://example.com/es_jeruk.jpg"
        },
        {
          "id": "16",
          "name": "Mie Goreng",
          "type": "food",
          "calories": 350,
          "protein": 10,
          "carbs": 45,
          "sugars": 5,
          "fat": 15,
          "iron": 2,
          "calcium": 1,
          "ingredients": [
            {"name": "Mie Instan", "total": "1 bungkus"},
            {"name": "Telur Ayam", "total": "2 butir"},
            {"name": "Bawang Merah", "total": "3 siung"},
            {"name": "Bawang Putih", "total": "2 siung"},
            {"name": "Kecap Manis", "total": "2 sendok makan"},
            {"name": "Minyak Goreng", "total": "3 sendok makan"}
          ],
          "instructions": [
            {
              "title": "Langkah 1",
              "description": "Rebus mie instan hingga matang, tiriskan."
            },
            {
              "title": "Langkah 2",
              "description": "Tumis bawang merah dan bawang putih hingga harum."
            },
            {
              "title": "Langkah 3",
              "description": "Masukkan telur ayam, aduk hingga matang."
            },
            {
              "title": "Langkah 4",
              "description":
                  "Tambahkan mie instan, kecap manis, aduk rata, sajikan panas."
            }
          ],
          "imageUrl": "https://example.com/mie_goreng.jpg"
        },
        {
          "id": "17",
          "name": "Rendang Padang",
          "type": "food",
          "calories": 400,
          "protein": 20,
          "carbs": 15,
          "sugars": 3,
          "fat": 25,
          "iron": 3,
          "calcium": 2,
          "ingredients": [
            {"name": "Daging Sapi", "total": "500 gram"},
            {"name": "Santan Kelapa", "total": "400 ml"},
            {"name": "Serai", "total": "2 batang"},
            {"name": "Daun Jeruk", "total": "5 lembar"},
            {"name": "Cabai Merah", "total": "5 buah"},
            {"name": "Bawang Merah", "total": "10 siung"}
          ],
          "instructions": [
            {
              "title": "Langkah 1",
              "description":
                  "Rebus daging sapi hingga setengah matang, tiriskan."
            },
            {
              "title": "Langkah 2",
              "description":
                  "Tumis bumbu halus, serai, daun jeruk hingga harum."
            },
            {
              "title": "Langkah 3",
              "description": "Masukkan daging sapi, aduk hingga bumbu meresap."
            },
            {
              "title": "Langkah 4",
              "description":
                  "Tambahkan santan, masak hingga daging empuk dan bumbu mengental."
            }
          ],
          "imageUrl": "https://example.com/rendang_padang.jpg"
        },
        {
          "id": "18",
          "name": "Pempek Palembang",
          "type": "food",
          "calories": 300,
          "protein": 15,
          "carbs": 25,
          "sugars": 2,
          "fat": 10,
          "iron": 2,
          "calcium": 1,
          "ingredients": [
            {"name": "Ikan Tenggiri", "total": "500 gram"},
            {"name": "Tepung Sagu", "total": "200 gram"},
            {"name": "Telur Ayam", "total": "2 butir"},
            {"name": "Bawang Putih", "total": "3 siung"},
            {"name": "Air Es", "total": "300 ml"},
            {"name": "Garam", "total": "secukupnya"}
          ],
          "instructions": [
            {
              "title": "Langkah 1",
              "description": "Haluskan ikan tenggiri dan bawang putih."
            },
            {
              "title": "Langkah 2",
              "description":
                  "Campurkan ikan halus dengan tepung sagu, telur, dan garam."
            },
            {
              "title": "Langkah 3",
              "description":
                  "Bentuk adonan menjadi bulatan, rebus hingga matang."
            },
            {
              "title": "Langkah 4",
              "description": "Sajikan pempek dengan cuko khas Palembang."
            }
          ],
          "imageUrl": "https://example.com/pempek_palembang.jpg"
        },
        {
          "id": "19",
          "name": "Gado-Gado",
          "type": "food",
          "calories": 250,
          "protein": 8,
          "carbs": 30,
          "sugars": 5,
          "fat": 15,
          "iron": 2,
          "calcium": 1,
          "ingredients": [
            {"name": "Tahu", "total": "200 gram"},
            {"name": "Kentang", "total": "2 buah"},
            {"name": "Telur Rebus", "total": "2 butir"},
            {"name": "Kacang Panjang", "total": "100 gram"},
            {"name": "Ketimun", "total": "1 buah"},
            {"name": "Taoge", "total": "100 gram"}
          ],
          "instructions": [
            {
              "title": "Langkah 1",
              "description": "Rebus tahu, kentang, dan telur hingga matang."
            },
            {
              "title": "Langkah 2",
              "description": "Potong-potong tahu, kentang, telur, dan ketimun."
            },
            {
              "title": "Langkah 3",
              "description":
                  "Susun semua bahan di atas piring, tambahkan taoge dan kacang panjang."
            },
            {
              "title": "Langkah 4",
              "description": "Siram dengan bumbu kacang, sajikan gado-gado."
            }
          ],
          "imageUrl": "https://example.com/gado_gado.jpg"
        },
        {
          "id": "20",
          "name": "Es Teh Manis",
          "type": "drink",
          "calories": 150,
          "protein": 0,
          "carbs": 40,
          "sugars": 35,
          "fat": 0,
          "iron": 1,
          "calcium": 2,
          "ingredients": [
            {"name": "Teh Celup", "total": "2 kantong"},
            {"name": "Gula Pasir", "total": "4 sendok makan"},
            {"name": "Air Panas", "total": "500 ml"},
            {"name": "Es Batu", "total": "secukupnya"}
          ],
          "instructions": [
            {
              "title": "Langkah 1",
              "description":
                  "Tuangkan air panas ke dalam gelas, masukkan teh celup dan gula pasir."
            },
            {
              "title": "Langkah 2",
              "description": "Biarkan teh melarut dan air menjadi dingin."
            },
            {
              "title": "Langkah 3",
              "description": "Tambahkan es batu, aduk rata, siap disajikan."
            }
          ],
          "imageUrl": "https://example.com/es_teh_manis.jpg"
        },
      ];
      List<Food> foods = listFood.map((e) => Food.fromJson(e)).toList();
      for (var food in foods) {
        final ref = foodDb.doc();
        food = food.copyWith(id: ref.id, imageUrl: '');
        await ref.set(food);
      }
      return const Result.success('Success');
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }
}

@Riverpod(keepAlive: true)
FoodRepository foodRepository(FoodRepositoryRef ref) {
  return FoodRepository();
}
