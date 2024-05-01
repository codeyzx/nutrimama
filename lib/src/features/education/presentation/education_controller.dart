import 'package:nutrimama/src/features/education/data/education_repository.dart';
import 'package:nutrimama/src/features/education/domain/article.dart';
import 'package:nutrimama/src/features/education/domain/category.dart';
import 'package:nutrimama/src/features/education/domain/video.dart';
import 'package:nutrimama/src/features/education/presentation/education_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'education_controller.g.dart';

@Riverpod(keepAlive: true)
class EducationController extends _$EducationController {
  @override
  EducationState build() {
    getArticles();
    return EducationState();
  }

  void onChipSelected(String index, {bool isVideo = false}) {
    if (isVideo) {
      List<Video>? filteredVideos = [];
      if (index == 'Semua') {
        filteredVideos = state.videos.asData?.value;
      } else {
        filteredVideos = state.videos.asData?.value
            ?.where((element) => element.category.value == index)
            .toList();
      }
      state = state.copyWith(
        selectedIndexVideos: index,
        filteredVideos: AsyncData(filteredVideos),
      );
    } else {
      List<Article>? filteredArticles = [];
      if (index == 'Semua') {
        filteredArticles = state.articles.asData?.value;
      } else {
        filteredArticles = state.articles.asData?.value
            ?.where((element) => element.category.value == index)
            .toList();
      }
      state = state.copyWith(
        selectedIndex: index,
        filteredArticles: AsyncData(filteredArticles),
      );
    }
  }

  Future<void> getArticles() async {
    final result = await ref.read(educationRepositoryProvider).getArticles();
    result.when(
      success: (data) {
        state = state.copyWith(
          articles: AsyncData(data),
          filteredArticles: AsyncData(data),
        );
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          articles: AsyncError(error, stackTrace),
          filteredArticles: AsyncError(error, stackTrace),
        );
      },
    );
  }

  // getVideos
  Future<void> getVideos() async {
    final result = await ref.read(educationRepositoryProvider).getVideos();
    result.when(
      success: (data) {
        state = state.copyWith(
          videos: AsyncData(data),
          filteredVideos: AsyncData(data),
        );
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          videos: AsyncError(error, stackTrace),
          filteredVideos: AsyncError(error, stackTrace),
        );
      },
    );
  }

  // addArticle
  Future<void> addArticle() async {
    final listOfJson = [
      {
        "id": "1",
        "title": "Pengaruh Pola Makan pada Perkembangan Janin",
        "description":
            "Pelajari pengaruh pola makan ibu hamil terhadap perkembangan janin dalam kandungan.",
        "category": "Kehamilan",
        "imageUrl": "https://example.com/pola_makan_janin.jpg",
        "content":
            "Pola makan ibu hamil memiliki dampak yang signifikan pada perkembangan janin. Nutrisi yang tepat sangat penting untuk mendukung pertumbuhan dan perkembangan yang optimal. Artikel ini akan membahas berbagai jenis makanan yang sebaiknya dikonsumsi selama kehamilan, serta nutrisi-nutrisi penting seperti asam folat, zat besi, dan kalsium. Selain itu, kami juga akan memberikan tips untuk mengatasi masalah makanan yang sering dialami ibu hamil, seperti mual dan muntah. Dengan mengikuti pola makan yang sehat, ibu hamil dapat memastikan bahwa janin mendapatkan semua nutrisi yang dibutuhkan untuk tumbuh dengan baik."
      },
      {
        "id": "2",
        "title": "Senam Hamil: Manfaat dan Cara Melakukannya",
        "description":
            "Temukan manfaat senam hamil serta cara melakukannya dengan aman dan nyaman.",
        "category": "Kehamilan",
        "imageUrl": "https://example.com/senam_hamil.jpg",
        "content":
            "Senam hamil merupakan kegiatan fisik yang aman dan bermanfaat bagi ibu hamil. Artikel ini akan menjelaskan manfaat senam hamil, termasuk meningkatkan kekuatan dan fleksibilitas tubuh, meningkatkan sirkulasi darah, serta membantu mengurangi ketidaknyamanan selama kehamilan seperti nyeri punggung dan kram kaki. Kami juga akan memberikan panduan praktis tentang cara melakukannya dengan aman, termasuk jenis-jenis senam yang cocok untuk ibu hamil, durasi dan intensitas yang disarankan, serta teknik pernapasan yang benar. Dengan rutin melakukan senam hamil, ibu hamil dapat mempersiapkan tubuhnya untuk persalinan dan mempercepat pemulihan pasca persalinan."
      },
      {
        "id": "3",
        "title": "Mengatasi Insomnia saat Hamil",
        "description":
            "Cari tahu cara mengatasi insomnia yang sering terjadi pada ibu hamil.",
        "category": "Kehamilan",
        "imageUrl": "https://example.com/insomnia_hamil.jpg",
        "content":
            "Insomnia adalah masalah umum yang sering dialami oleh ibu hamil, terutama pada trimester kedua dan ketiga. Artikel ini akan memberikan tips-tips praktis untuk mengatasi insomnia saat hamil, mulai dari perubahan gaya hidup seperti menjaga rutin tidur yang teratur, menciptakan lingkungan tidur yang nyaman, hingga teknik-teknik relaksasi yang dapat membantu tidur lebih nyenyak. Kami juga akan membahas tentang keamanan penggunaan obat tidur selama kehamilan dan kapan sebaiknya berkonsultasi dengan dokter jika insomnia menjadi masalah yang serius. Dengan mengikuti tips-tips yang disarankan, ibu hamil dapat memperbaiki kualitas tidurnya dan menjaga kesehatan selama kehamilan."
      },
      {
        "id": "4",
        "title": "Resep Makanan Sehat untuk Diet Seimbang",
        "description":
            "Coba resep makanan sehat yang dapat membantu Anda menjaga berat badan dengan seimbang.",
        "category": "Makanan Sehat",
        "imageUrl": "https://example.com/diet_seimbang.jpg",
        "content":
            "Diet seimbang adalah kunci untuk menjaga berat badan yang sehat dan mendukung kesehatan secara keseluruhan. Artikel ini akan memberikan beberapa resep makanan sehat yang rendah kalori namun kaya nutrisi, yang cocok untuk Anda yang sedang menjalani program diet. Kami akan membagikan resep-resep yang mudah dan praktis untuk disiapkan di rumah, serta menjelaskan manfaat masing-masing bahan yang digunakan. Dengan mengikuti resep-resep yang diberikan, Anda dapat menikmati makanan lezat tanpa perlu khawatir akan berat badan Anda."
      },
      {
        "id": "5",
        "title": "Makanan Penambah Energi untuk Aktivitas Sehari-hari",
        "description":
            "Coba beberapa jenis makanan penambah energi untuk meningkatkan performa harian Anda.",
        "category": "Makanan Sehat",
        "imageUrl": "https://example.com/penambah_energi.jpg",
        "content":
            "Makanan merupakan sumber utama energi untuk tubuh. Artikel ini akan membahas beberapa jenis makanan penambah energi yang cocok dikonsumsi sebelum atau sesudah beraktivitas, serta manfaatnya bagi kesehatan dan performa harian Anda. Kami juga akan memberikan tips tentang bagaimana cara mengombinasikan makanan-makanan tersebut untuk mendapatkan energi yang maksimal, serta pilihan makanan sehat lainnya yang dapat Anda konsumsi sebagai sumber energi yang seimbang."
      },
      {
        "id": "6",
        "title": "Nutrisi Penting untuk Kesehatan Tulang",
        "description":
            "Pelajari nutrisi-nutrisi penting yang diperlukan untuk menjaga kesehatan tulang Anda.",
        "category": "Gizi",
        "imageUrl": "https://example.com/nutrisi_tulang.jpg",
        "content":
            "Kesehatan tulang membutuhkan asupan nutrisi yang cukup, terutama kalsium, vitamin D, dan protein. Artikel ini akan membahas peran masing-masing nutrisi dalam menjaga kesehatan tulang, serta sumber-sumber makanan yang kaya akan nutrisi-nutrisi tersebut. Kami juga akan memberikan tips tentang bagaimana cara memasukkan makanan-makanan tersebut ke dalam pola makan sehari-hari, serta gaya hidup yang mendukung kesehatan tulang."
      },
      {
        "id": "7",
        "title": "Pentingnya Imunisasi pada Bayi Baru Lahir",
        "description":
            "Kenali pentingnya imunisasi pada bayi baru lahir untuk perlindungan awal dari penyakit.",
        "category": "Imunisasi",
        "imageUrl": "https://example.com/imunisasi_bayi.jpg",
        "content":
            "Imunisasi pada bayi baru lahir sangat penting untuk melindungi mereka dari penyakit-penyakit yang berbahaya. Artikel ini akan membahas mengapa imunisasi diberikan sejak bayi baru lahir, jenis-jenis vaksin yang diperlukan, serta jadwal imunisasi yang disarankan oleh para ahli kesehatan. Kami juga akan memberikan informasi tentang keamanan dan efektivitas vaksin, serta jawaban atas beberapa pertanyaan umum yang sering diajukan orang tua tentang imunisasi."
      },
      {
        "id": "8",
        "title": "Mitos dan Fakta seputar Gaya Hidup Sehat",
        "description":
            "Temukan fakta-fakta dan jangan percaya pada mitos-mitos seputar gaya hidup sehat.",
        "category": "Gaya Hidup Sehat",
        "imageUrl": "https://example.com/mitos_gaya_hidup.jpg",
        "content":
            "Banyak mitos yang berkembang seputar gaya hidup sehat, namun tidak semuanya benar. Artikel ini akan membahas beberapa mitos yang umum terkait dengan gaya hidup sehat, serta memberikan penjelasan berdasarkan bukti ilmiah yang ada. Kami juga akan membedakan antara mitos dan fakta, sehingga pembaca dapat membuat keputusan yang lebih baik tentang gaya hidup mereka. Dengan mengetahui fakta yang sebenarnya, Anda dapat mengambil langkah-langkah yang lebih efektif untuk meningkatkan kesehatan dan kesejahteraan Anda."
      },
      {
        "id": "9",
        "title": "Teknik Relaksasi untuk Menjaga Kesehatan Mental",
        "description":
            "Pelajari berbagai teknik relaksasi yang dapat membantu menjaga kesehatan mental Anda.",
        "category": "Kesehatan Mental",
        "imageUrl": "https://example.com/relaksasi_mental.jpg",
        "content":
            "Teknik relaksasi adalah cara efektif untuk mengurangi stres dan meningkatkan kesejahteraan mental. Artikel ini akan membahas beberapa teknik relaksasi yang dapat Anda praktikkan, seperti meditasi, pernapasan dalam, dan yoga, serta manfaatnya bagi kesehatan mental Anda. Kami juga akan memberikan tips tentang bagaimana cara mengintegrasikan teknik-teknik relaksasi ke dalam rutinitas harian Anda, sehingga Anda dapat merasakan manfaatnya secara optimal."
      },
      {
        "id": "10",
        "title": "Olahraga Ringan yang Cocok untuk Ibu Hamil",
        "description":
            "Coba beberapa jenis olahraga ringan yang aman untuk ibu hamil.",
        "category": "Olahraga dan Kebugaran",
        "imageUrl": "https://example.com/olahraga_hamil.jpg",
        "content":
            "Olahraga ringan dapat membantu menjaga kesehatan dan kebugaran ibu hamil, serta mempersiapkan tubuh untuk proses persalinan. Artikel ini akan memberikan rekomendasi beberapa jenis olahraga ringan yang aman untuk ibu hamil, serta tips-tips untuk melakukannya dengan benar. Kami juga akan membahas tentang manfaat olahraga selama kehamilan, seperti mengurangi risiko komplikasi kehamilan, meningkatkan stamina dan kekuatan tubuh, serta membantu mengurangi stres dan kecemasan. Dengan mengikuti panduan yang diberikan, ibu hamil dapat tetap aktif dan sehat selama kehamilan mereka."
      },
      {
        "id": "1",
        "title": "Tips Mengatasi Stres saat Menjalani Kehidupan Sehari-hari",
        "description":
            "Temukan cara efektif untuk mengatasi stres dalam kehidupan sehari-hari.",
        "category": "pengelolaanStress",
        "imageUrl": "https://example.com/tips_mengatasi_stres.jpg",
        "content":
            "Stres adalah bagian alami dari kehidupan, namun terlalu banyak stres dapat berdampak negatif bagi kesehatan fisik dan mental. Artikel ini akan memberikan tips-tips praktis untuk mengelola stres dalam kehidupan sehari-hari, mulai dari teknik relaksasi seperti meditasi dan pernapasan dalam, hingga strategi untuk mengubah pola pikir yang negatif. Kami juga akan membahas tentang pentingnya menjaga keseimbangan antara pekerjaan dan waktu istirahat, serta pentingnya menetapkan batasan dan mengatakan 'tidak' jika diperlukan. Dengan mengikuti tips-tips yang disarankan, Anda dapat mengurangi stres dan meningkatkan kesejahteraan Anda secara keseluruhan."
      },
      {
        "id": "2",
        "title": "Ketahui Tanda-tanda Depresi dan Cara Mengatasinya",
        "description":
            "Pelajari tanda-tanda depresi dan temukan cara mengatasinya dengan efektif.",
        "category": "Kesehatan Mental",
        "imageUrl": "https://example.com/tanda_tanda_depresi.jpg",
        "content":
            "Depresi adalah gangguan mental yang serius yang dapat memengaruhi pikiran, perasaan, dan perilaku seseorang. Artikel ini akan membahas tentang tanda-tanda umum depresi, seperti perubahan suasana hati yang drastis, kehilangan minat pada aktivitas yang biasa dinikmati, dan perubahan pola tidur atau makan. Kami juga akan memberikan informasi tentang faktor-faktor risiko yang dapat meningkatkan kemungkinan seseorang mengalami depresi, serta cara mengatasi depresi melalui pengobatan dan dukungan sosial. Dengan mengenali tanda-tanda depresi dan mencari bantuan yang tepat, seseorang dapat mengelola depresi dengan lebih efektif dan meningkatkan kualitas hidupnya."
      },
      {
        "id": "3",
        "title": "Manfaat Tidur yang Cukup bagi Kesehatan Mental",
        "description":
            "Pelajari manfaat tidur yang cukup bagi kesehatan mental dan kesejahteraan Anda.",
        "category": "Kesehatan Mental",
        "imageUrl": "https://example.com/manfaat_tidur.jpg",
        "content":
            "Tidur yang cukup memiliki peran penting dalam menjaga kesehatan mental dan kesejahteraan secara keseluruhan. Artikel ini akan membahas tentang manfaat tidur yang cukup bagi kesehatan mental, seperti meningkatkan konsentrasi dan daya ingat, memperbaiki suasana hati, serta mengurangi risiko gangguan mood dan kecemasan. Kami juga akan memberikan tips-tips praktis untuk meningkatkan kualitas tidur, mulai dari menciptakan lingkungan tidur yang nyaman, menjaga rutinitas tidur yang teratur, hingga menghindari kebiasaan-kebiasaan yang mengganggu tidur seperti mengonsumsi kafein atau alkohol sebelum tidur. Dengan mengikuti tips-tips tersebut, Anda dapat meningkatkan kualitas tidur Anda dan merasakan manfaatnya bagi kesehatan mental Anda."
      },
      {
        "id": "4",
        "title": "Cara Memulai Program Latihan Fisik untuk Pemula",
        "description":
            "Temukan langkah-langkah praktis untuk memulai program latihan fisik bagi pemula.",
        "category": "Olahraga dan Kebugaran",
        "imageUrl": "https://example.com/program_latihan.jpg",
        "content":
            "Memulai program latihan fisik dapat menjadi langkah yang menantang bagi pemula. Artikel ini akan memberikan langkah-langkah praktis untuk memulai program latihan fisik, termasuk menetapkan tujuan yang realistis, memilih jenis latihan yang sesuai dengan minat dan kemampuan Anda, serta membuat jadwal latihan yang konsisten. Kami juga akan membahas tentang pentingnya pemanasan sebelum latihan, teknik-teknik dasar untuk mencegah cedera, dan bagaimana mengukur kemajuan Anda selama program latihan. Dengan mengikuti panduan yang disarankan, Anda dapat memulai program latihan fisik dengan percaya diri dan meraih hasil yang optimal."
      },
      {
        "id": "5",
        "title": "Pentingnya Sarapan Sehat dalam Memulai Hari",
        "description":
            "Cari tahu mengapa sarapan sehat adalah kunci untuk memulai hari dengan energi dan semangat.",
        "category": "Makanan Sehat",
        "imageUrl": "https://example.com/sarapan_sehat.jpg",
        "content":
            "Sarapan adalah waktu penting untuk memberikan energi yang diperlukan tubuh untuk memulai hari dengan baik. Artikel ini akan membahas tentang pentingnya sarapan sehat, termasuk manfaatnya bagi kesehatan, konsentrasi, dan kinerja mental. Kami juga akan memberikan contoh-contoh menu sarapan sehat yang mudah disiapkan di rumah, serta tips-tips untuk memilih makanan yang seimbang, menghindari makanan yang mengandung banyak gula atau lemak jenuh, dan mengatur waktu sarapan dengan tepat. Dengan mengikuti saran-saran yang diberikan, Anda dapat memastikan bahwa sarapan Anda memberikan nutrisi yang cukup untuk memulai hari dengan baik."
      },
      {
        "id": "6",
        "title": "Pentingnya Aktivitas Fisik untuk Kesehatan Jantung",
        "description":
            "Temukan pentingnya aktivitas fisik dalam menjaga kesehatan jantung Anda.",
        "category": "Gaya Hidup Sehat",
        "imageUrl": "https://example.com/aktivitas_fisik_jantung.jpg",
        "content":
            "Aktivitas fisik memiliki peran yang penting dalam menjaga kesehatan jantung. Artikel ini akan membahas tentang manfaat aktivitas fisik bagi kesehatan jantung, termasuk mengurangi risiko penyakit jantung koroner, menurunkan tekanan darah, meningkatkan kadar kolesterol baik, serta mengontrol berat badan. Kami juga akan memberikan rekomendasi tentang jenis-jenis aktivitas fisik yang cocok untuk kesehatan jantung, intensitas yang disarankan, serta tips-tips untuk menjaga motivasi dan konsistensi dalam berolahraga. Dengan mengintegrasikan aktivitas fisik ke dalam gaya hidup Anda, Anda dapat meningkatkan kesehatan jantung Anda dan mengurangi risiko terkena penyakit jantung."
      },
      {
        "id": "7",
        "title": "Mengenal Jenis-jenis Makanan Super dan Manfaatnya",
        "description":
            "Pelajari tentang jenis-jenis makanan super dan manfaat kesehatan yang dimilikinya.",
        "category": "Gizi",
        "imageUrl": "https://example.com/makanan_super.jpg",
        "content":
            "Makanan super adalah jenis makanan yang kaya akan nutrisi dan memiliki manfaat kesehatan yang luar biasa. Artikel ini akan mengenalkan Anda pada berbagai jenis makanan super, seperti bayam, blueberry, kacang-kacangan, dan biji-bijian, serta manfaat kesehatan yang dimilikinya. Kami juga akan memberikan ide-ide kreatif untuk memasukkan makanan super ke dalam pola makan sehari-hari, seperti membuat smoothie, salad, atau camilan sehat. Dengan menambahkan makanan super ke dalam diet Anda, Anda dapat meningkatkan asupan nutrisi dan mendukung kesehatan secara keseluruhan."
      },
      {
        "id": "8",
        "title":
            "Trik Mudah Mengatur Keuangan untuk Masa Depan yang Lebih Stabil",
        "description":
            "Cari tahu trik mudah untuk mengatur keuangan Anda agar lebih stabil di masa depan.",
        "category": "Keuangan",
        "imageUrl": "https://example.com/mengatur_keuangan.jpg",
        "content":
            "Mengatur keuangan adalah keterampilan penting yang dapat membantu Anda mencapai kestabilan finansial di masa depan. Artikel ini akan memberikan trik mudah untuk mengatur keuangan Anda, termasuk membuat anggaran bulanan, mengurangi pengeluaran yang tidak perlu, dan memprioritaskan tabungan dan investasi. Kami juga akan membahas tentang pentingnya merencanakan untuk masa depan, seperti merencanakan pensiun, mendanai pendidikan anak, dan menghadapi kejadian tak terduga seperti krisis kesehatan atau kehilangan pekerjaan. Dengan menerapkan trik-trik yang disarankan, Anda dapat meningkatkan kontrol atas keuangan Anda dan menciptakan masa depan yang lebih stabil dan aman."
      },
      {
        "id": "9",
        "title": "Teknik Mengelola Waktu agar Lebih Produktif",
        "description":
            "Pelajari teknik-teknik untuk mengelola waktu Anda dengan lebih efektif dan produktif.",
        "category": "Keuangan",
        "imageUrl": "https://example.com/mengelola_waktu.jpg",
        "content":
            "Mengelola waktu dengan baik adalah kunci untuk menjadi lebih produktif dan efisien dalam menjalani kehidupan sehari-hari. Artikel ini akan membahas tentang teknik-teknik mengelola waktu yang dapat Anda terapkan, seperti membuat jadwal harian, menggunakan teknik pomodoro, dan mengidentifikasi prioritas-prioritas yang perlu diselesaikan. Kami juga akan memberikan tips tentang bagaimana cara menghindari gangguan dan penundaan, serta mengoptimalkan penggunaan teknologi untuk meningkatkan produktivitas Anda. Dengan menerapkan teknik-teknik yang disarankan, Anda dapat mengelola waktu Anda dengan lebih efektif dan mencapai tujuan-tujuan Anda dengan lebih mudah."
      },
      {
        "id": "10",
        "title": "Cara Mengurangi Risiko Kecelakaan di Tempat Kerja",
        "description":
            "Temukan cara mengurangi risiko kecelakaan di tempat kerja untuk keselamatan Anda.",
        "category": "Keuangan",
        "imageUrl": "https://example.com/kecelakaan_kerja.jpg",
        "content":
            "Kecelakaan di tempat kerja dapat menyebabkan cedera serius dan memengaruhi produktivitas serta keselamatan pekerja. Artikel ini akan membahas tentang cara mengurangi risiko kecelakaan di tempat kerja, mulai dari mematuhi peraturan keselamatan dan kesehatan kerja, mengidentifikasi bahaya potensial, hingga memberikan pelatihan dan pemahaman yang cukup kepada pekerja tentang protokol keselamatan. Kami juga akan memberikan contoh-contoh tindakan pencegahan yang dapat dilakukan, seperti penggunaan peralatan pelindung diri, pemasangan tanda peringatan, dan mengatur lingkungan kerja agar lebih ergonomis. Dengan mengikuti pedoman keselamatan yang disarankan, Anda dapat mengurangi risiko kecelakaan di tempat kerja dan menjaga kesejahteraan Anda serta rekan kerja Anda."
      }
    ];

    final article = listOfJson.map((json) => Article.fromJson(json)).toList();
    final result =
        await ref.read(educationRepositoryProvider).addArticle(article);
    result.when(
      success: (data) {
        getArticles();
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          articles: AsyncError(error, stackTrace),
        );
      },
    );
  }

  //addVideo
  Future<void> addVideo() async {
    Video video = const Video(
      id: '',
      title: 'Title',
      description: 'Description',
      videoUrl: 'https://www.youtube.com/watch?v=6g3DcLrm9Kw',
      category: EducationCategory.gayaHidupSehat,
    );
    final result = await ref.read(educationRepositoryProvider).addVideo(video);
    result.when(
      success: (data) {
        getVideos();
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          videos: AsyncError(error, stackTrace),
        );
      },
    );
  }
}
