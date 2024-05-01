import 'package:flutter/material.dart';
import 'package:nutrimama/src/features/auth/domain/user.dart';
import 'package:nutrimama/src/features/medical_record/data/medical_record_repository.dart';
import 'package:nutrimama/src/features/medical_record/domain/fetal.dart';
import 'package:nutrimama/src/features/medical_record/domain/mother.dart';
import 'package:nutrimama/src/features/medical_record/presentation/medical_record_state.dart';
import 'package:nutrimama/src/services/remote/remote.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';

part 'medical_record_controller.g.dart';

@Riverpod(keepAlive: true)
class MedicalRecordController extends _$MedicalRecordController {
  @override
  MedicalRecordState build() {
    return MedicalRecordState(
      weightController: TextEditingController(),
      bloodPressureController: TextEditingController(),
      lengthController: TextEditingController(),
      heartRateController: TextEditingController(),
    );
  }

  Future<void> getFetal(User user) async {
    final result =
        await ref.read(medicalRecordRepositoryProvider).getFetal(user);
    result.when(
      success: (data) {
        Logger().i(data);
        data.sort((a, b) {
          if (a.date == null) {
            return 1;
          } else if (b.date == null) {
            return -1;
          } else {
            return b.date!.compareTo(a.date!);
          }
        });
        state = state.copyWith(
          allFetals: AsyncData(data),
          fetals: AsyncData(getFetalsById(user.fetalId, data)),
          fetal: AsyncData(getLatestFetal(user.fetalId, data)),
        );
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          allFetals: AsyncError(error, stackTrace),
        );
      },
    );
  }

  Future<void> addFetal(User user, bool isNewFetal) async {
    state = state.copyWith(
      fetals: const AsyncLoading(),
    );

    Fetal fetal;
    Result<String> result;
    if (isNewFetal) {
      fetal = Fetal(
        id: '',
        fetalId: '',
        weight: double.tryParse(state.weightController.text) ?? 0.0,
        fetalDate: state.date == null
            ? DateTime.now()
            : DateTime.parse(state.date.toString()),
        length: double.tryParse(state.lengthController.text) ?? 0.0,
        heartRate: int.tryParse(state.heartRateController.text) ?? 0,
        date: null,
      );
      result = await ref
          .read(medicalRecordRepositoryProvider)
          .addNewFetal(fetal, user);
    } else {
      fetal = Fetal(
        id: '',
        fetalId: user.fetalId,
        fetalDate: user.fetalDate ?? DateTime.now(),
        weight: double.tryParse(state.weightController.text) ?? 0.0,
        date: state.date == null
            ? DateTime.now()
            : DateTime.parse(state.date.toString()),
        length: double.tryParse(state.lengthController.text) ?? 0.0,
        heartRate: int.tryParse(state.heartRateController.text) ?? 0,
      );
      result =
          await ref.read(medicalRecordRepositoryProvider).addFetal(fetal, user);
    }

    result.when(
      success: (data) {
        getFetal(user);
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          fetals: AsyncError(error, stackTrace),
        );
      },
    );
  }

  List<Fetal> getFetalsById(String fetalId, List<Fetal> fetals) {
    return fetals.where((element) => element.fetalId == fetalId).toList();
  }

  Fetal? getLatestFetal(String fetalId, List<Fetal> fetals) {
    final fetalsById = getFetalsById(fetalId, fetals);
    if (fetalsById.isEmpty) return null;
    fetalsById.sort((a, b) => a.date == null
        ? 1
        : b.date == null
            ? -1
            : b.date!.compareTo(a.date!));
    return fetalsById.last;
  }

  Future<void> getMother(User user) async {
    final result =
        await ref.read(medicalRecordRepositoryProvider).getMother(user);
    result.when(
      success: (data) {
        Logger().i(data);
        data.sort((a, b) => b.date.compareTo(a.date));
        state = state.copyWith(
          mothers: AsyncData(data),
          mother: AsyncData(data.isEmpty ? null : data.first),
        );
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          mothers: AsyncError(error, stackTrace),
        );
      },
    );
  }

  Future<void> addMother(User user) async {
    state = state.copyWith(
      mothers: const AsyncLoading(),
    );

    final mother = Mother(
      id: '',
      date: state.date == null
          ? DateTime.now()
          : DateTime.parse(state.date.toString()),
      weight: double.tryParse(state.weightController.text) ?? 0.0,
      bloodPressure: state.bloodPressureController.text,
    );

    final result =
        await ref.read(medicalRecordRepositoryProvider).addMother(mother, user);
    result.when(
      success: (data) {
        getMother(user);
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          mothers: AsyncError(error, stackTrace),
        );
      },
    );
  }

  Mother? getLatestMother(List<Mother> data) {
    if (data.isEmpty) return null;
    data.sort((a, b) => a.date.compareTo(b.date));
    return data.last;
  }

  void setDate(String date) {
    state = state.copyWith(date: date);
  }

  void getTrimester(DateTime conceptionDate) {
    DateTime currentDate = DateTime.now();
    Duration difference = currentDate.difference(conceptionDate);
    int week = (difference.inDays / 7).floor();
    int trimester = (week / 12).ceil();
    String trimesterDesc = '';
    String trimesterTips = '';
    switch (week) {
      case 1:
        trimesterDesc =
            'Pada minggu ini, embrio baru mulai terbentuk setelah pembuahan. Ini adalah awal perjalanan menakjubkan menuju kelahiran.';
        trimesterTips =
            'Mulailah mengonsumsi asam folat dan makan makanan sehat untuk membantu perkembangan embrio.';
        break;
      case 2:
        trimesterDesc =
            'Pada minggu kedua, embrio mulai melekat pada dinding rahim dan mulai berkembang.';
        trimesterTips =
            'Hindari alkohol dan rokok untuk mendukung kesehatan janin yang sedang berkembang.';
        break;
      case 3:
        trimesterDesc =
            'Pada minggu ini, jantung janin mulai berkembang dan sistem organ awal mulai terbentuk.';
        trimesterTips =
            'Jaga pola makan yang seimbang dan hindari makanan berisiko seperti mentah atau setengah matang.';
        break;
      case 4:
        trimesterDesc =
            'Pada minggu keempat, embrio telah memiliki dasar dari sistem saraf, otak, dan tulang belakang.';
        trimesterTips =
            'Mulailah mengambil suplemen vitamin prenatal dan rutin kontrol ke dokter kandungan.';
        break;
      case 5:
        trimesterDesc =
            'Pada minggu ini, perkembangan wajah dan anggota tubuh janin mulai terlihat.';
        trimesterTips =
            'Perbanyak konsumsi air dan hindari stres yang berlebihan.';
        break;
      case 6:
        trimesterDesc =
            'Pada minggu keenam, janin mulai bergerak aktif meskipun masih terlalu kecil untuk dirasakan.';
        trimesterTips =
            'Lakukan latihan ringan seperti jalan kaki untuk menjaga kebugaran.';
        break;
      case 7:
        trimesterDesc =
            'Pada minggu ini, organ-organ utama seperti hati dan ginjal mulai berkembang.';
        trimesterTips =
            'Istirahat yang cukup dan hindari aktivitas yang terlalu melelahkan.';
        break;
      case 8:
        trimesterDesc =
            'Pada minggu kedelapan, janin mulai memiliki bentuk yang lebih manusiawi dan tangan serta kaki sudah mulai terbentuk.';
        trimesterTips =
            'Perbanyak konsumsi makanan kaya akan zat besi untuk mencegah anemia.';
        break;
      case 9:
        trimesterDesc =
            'Pada minggu ini, organ-organ dalam janin terus berkembang dan sistem pencernaan mulai terbentuk.';
        trimesterTips =
            'Hindari minuman berkafein dan perbanyak konsumsi makanan berserat.';
        break;
      case 10:
        trimesterDesc =
            'Pada minggu kesepuluh, janin sudah memiliki hampir semua struktur organ yang penting.';
        trimesterTips =
            'Jaga postur tubuh saat duduk dan berbaring untuk mengurangi risiko nyeri punggung.';
        break;
      case 11:
        trimesterDesc =
            'Pada minggu kesebelas, janin mulai mengembangkan refleks seperti menghisap jari.';
        trimesterTips =
            'Lakukan peregangan ringan setiap hari untuk mengurangi ketegangan otot.';
        break;
      case 12:
        trimesterDesc =
            'Pada minggu kedua belas, janin memiliki cengkeraman yang kuat dan dapat menggerakkan jari-jari.';
        trimesterTips =
            'Mulailah mempersiapkan pakaian bayi dan perlengkapan kebutuhan bayi.';
        break;
      case 13:
        trimesterDesc =
            'Pada minggu ketiga belas, janin mulai mendengar suara-suara dari luar.';
        trimesterTips =
            'Berbicaralah dengan bayi Anda dan dengarkan musik yang menenangkan.';
        break;
      case 14:
        trimesterDesc =
            'Pada minggu keempat belas, janin mulai memiliki gerakan yang lebih terkoordinasi dan dapat menendang dengan kuat.';
        trimesterTips = 'Perhatikan gerakan janin dan catat pola aktifitasnya.';
        break;
      case 15:
        trimesterDesc =
            'Pada minggu kelima belas, janin dapat mulai bereaksi terhadap sentuhan pada perut.';
        trimesterTips =
            'Berikan perhatian ekstra pada perut dan hubungan dengan janin.';
        break;
      case 16:
        trimesterDesc =
            'Pada minggu keenam belas, janin mulai membuka dan menutup mata.';
        trimesterTips =
            'Perbanyak konsumsi makanan kaya akan kalsium untuk perkembangan tulang janin.';
        break;
      case 17:
        trimesterDesc =
            'Pada minggu ini, sistem pernafasan janin semakin berkembang.';
        trimesterTips = 'Hindari asap rokok dan lingkungan berpolusi.';
        break;
      case 18:
        trimesterDesc =
            'Pada minggu kedelapan belas, janin mulai menendang lebih sering dan bisa dirasakan oleh ibu hamil.';
        trimesterTips =
            'Nikmati momen merasakan gerakan janin dan bagikan dengan pasangan.';
        break;
      case 19:
        trimesterDesc =
            'Pada minggu kesembilan belas, janin mulai memiliki lebih banyak lemak di bawah kulit.';
        trimesterTips =
            'Jaga pola makan yang seimbang dengan mengonsumsi protein, lemak sehat, dan karbohidrat kompleks.';
        break;
      case 20:
        trimesterDesc =
            'Pada minggu kedua puluh, pertumbuhan janin semakin cepat dan ukuran tubuhnya semakin meningkat.';
        trimesterTips =
            'Lakukan pemeriksaan ultrasonografi untuk memantau perkembangan janin.';
        break;
      case 21:
        trimesterDesc =
            'Pada minggu kedua puluh satu, janin mulai mengembangkan indera penciuman dan dapat merasakan bau-bauan dari lingkungan sekitar.';
        trimesterTips =
            'Hindari paparan bau-bauan yang kuat atau tidak nyaman bagi Anda.';
        break;
      case 22:
        trimesterDesc =
            'Pada minggu kedua puluh dua, sistem pencernaan janin semakin matang dan mulai memproduksi mekonium.';
        trimesterTips =
            'Perbanyak konsumsi serat untuk mencegah sembelit pada trimester ketiga.';
        break;
      case 23:
        trimesterDesc =
            'Pada minggu kedua puluh tiga, janin dapat merasakan sentuhan halus pada kulitnya dan meresponsnya.';
        trimesterTips =
            'Lakukan sentuhan lembut pada perut Anda dan nikmati momen berinteraksi dengan janin.';
        break;
      case 24:
        trimesterDesc =
            'Pada minggu kedua puluh empat, janin memiliki pola tidur yang berkembang dan bisa membedakan antara siang dan malam.';
        trimesterTips =
            'Cobalah untuk tidur dengan posisi yang nyaman dan istirahat yang cukup.';
        break;
      case 25:
        trimesterDesc =
            'Pada minggu kedua puluh lima, janin mulai mengembangkan rambut di kulit kepalanya.';
        trimesterTips =
            'Perhatikan perubahan pada kulit Anda dan gunakan pelembap bila diperlukan.';
        break;
      case 26:
        trimesterDesc =
            'Pada minggu kedua puluh enam, janin mulai bereaksi terhadap suara-suara dari luar dan musik.';
        trimesterTips =
            'Cobalah untuk memperkenalkan musik yang menenangkan kepada janin.';
        break;
      case 27:
        trimesterDesc =
            'Pada minggu kedua puluh tujuh, janin semakin aktif bergerak dan bereaksi terhadap aktivitas ibu.';
        trimesterTips =
            'Perhatikan pola gerakan janin dan hubungkan dengan perkembangan janin.';
        break;
      case 28:
        trimesterDesc =
            'Pada minggu kedua puluh delapan, janin semakin mendapatkan berat badan dan bertambah besar.';
        trimesterTips =
            'Pastikan Anda mendapatkan cukup protein dan nutrisi untuk mendukung pertumbuhan janin.';
        break;
      case 29:
        trimesterDesc =
            'Pada minggu kedua puluh sembilan, janin mulai memiliki refleks menelan dan mencerna.';
        trimesterTips =
            'Perbanyak konsumsi makanan kaya akan kalsium dan magnesium.';
        break;
      case 30:
        trimesterDesc =
            'Pada minggu ketiga puluh, janin semakin terlatih untuk bernapas meskipun paru-parunya belum sepenuhnya matang.';
        trimesterTips =
            'Lakukan latihan pernapasan ringan untuk mempersiapkan diri untuk persalinan.';
        break;
      case 31:
        trimesterDesc =
            'Pada minggu ketiga puluh satu, janin mulai memiliki pola tidur yang lebih teratur dengan periode tidur yang lebih panjang.';
        trimesterTips =
            'Pastikan Anda juga mendapatkan istirahat yang cukup untuk mempersiapkan diri untuk persalinan.';
        break;
      case 32:
        trimesterDesc =
            'Pada minggu ketiga puluh dua, janin semakin berkembang dengan memperoleh lebih banyak lemak di bawah kulitnya.';
        trimesterTips =
            'Perhatikan pola gerakan janin dan perhatikan perubahan aktivitasnya.';
        break;
      case 33:
        trimesterDesc =
            'Pada minggu ketiga puluh tiga, pertumbuhan janin terus berlanjut dengan semakin membesarnya ukuran perut ibu hamil.';
        trimesterTips =
            'Pergunakan bantal atau alas yang nyaman untuk mendukung perut Anda saat tidur atau duduk.';
        break;
      case 34:
        trimesterDesc =
            'Pada minggu ketiga puluh empat, janin semakin aktif bergerak dan bereaksi terhadap suara-suara di sekitarnya.';
        trimesterTips =
            'Perhatikan pola tidur janin dan catat gerakannya untuk memonitor perkembangannya.';
        break;
      case 35:
        trimesterDesc =
            'Pada minggu ketiga puluh lima, janin telah memulai posisi yang lebih teratur dalam rahim, mempersiapkan diri untuk persalinan.';
        trimesterTips =
            'Konsultasikan dengan dokter kandungan tentang persiapan persalinan dan posisi janin.';
        break;
      case 36:
        trimesterDesc =
            'Pada minggu ketiga puluh enam, janin semakin menekan kandung kemih ibu, meningkatkan kebutuhan untuk buang air kecil.';
        trimesterTips =
            'Perbanyak minum air putih dan hindari minuman berkafein yang dapat membuat Anda lebih sering buang air kecil.';
        break;
      case 37:
        trimesterDesc =
            'Pada minggu ketiga puluh tujuh, janin telah mencapai posisi kepala ke bawah dalam rahim untuk persiapan persalinan.';
        trimesterTips =
            'Perbanyak istirahat dan hindari aktivitas yang terlalu melelahkan.';
        break;
      case 38:
        trimesterDesc =
            'Pada minggu ketiga puluh delapan, janin semakin menumpuk lemak di tubuhnya, meningkatkan berat badannya.';
        trimesterTips =
            'Perbanyak asupan makanan bergizi untuk memenuhi kebutuhan energi dan nutrisi Anda.';
        break;
      case 39:
        trimesterDesc =
            'Pada minggu ketiga puluh sembilan, janin siap untuk kelahiran dan organ-organ tubuhnya telah matang.';
        trimesterTips =
            'Pastikan Anda telah menyiapkan segala sesuatu yang diperlukan untuk persalinan dan masa nifas.';
        break;
      case 40:
        trimesterDesc =
            'Pada minggu keempat puluh, janin siap untuk dilahirkan dan mungkin akan dilahirkan kapan saja.';
        trimesterTips =
            'Pastikan Anda sudah siap dengan tas persalinan dan hubungi dokter kandungan saat tanda-tanda persalinan muncul.';
        break;
      case 41:
        trimesterDesc =
            'Pada minggu keempat puluh satu, janin masih dapat terus tumbuh dan berkembang di dalam rahim.';
        trimesterTips =
            'Tetap tenang dan siapkan diri Anda untuk persalinan yang akan datang.';
        break;
      case 42:
        trimesterDesc =
            'Selamat! Anda telah mencapai akhir perjalanan kehamilan. Janin sudah siap untuk dilahirkan.';
        trimesterTips =
            'Pastikan tas persalinan sudah siap dan bersiaplah untuk kelahiran yang menyenangkan.';
        break;
    }

    state = state.copyWith(
      trimester: AsyncData(
        Trimester(
          week: week,
          type: trimester,
          desc: trimesterDesc,
          tips: trimesterTips,
        ),
      ),
    );
  }

  void clear() {
    state = state.copyWith(
      weightController: TextEditingController(),
      bloodPressureController: TextEditingController(),
      lengthController: TextEditingController(),
      heartRateController: TextEditingController(),
    );
  }
}
