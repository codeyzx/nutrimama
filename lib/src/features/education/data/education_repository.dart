import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrimama/src/features/education/domain/article.dart';
import 'package:nutrimama/src/features/education/domain/video.dart';
import 'package:nutrimama/src/services/remote/remote.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'education_repository.g.dart';

class EducationRepository {
  final articleDb =
      FirebaseFirestore.instance.collection('articles').withConverter(
            fromFirestore: (snapshot, _) => Article.fromJson(snapshot.data()!),
            toFirestore: (Article article, _) => article.toJson(),
          );

  final videoDb = FirebaseFirestore.instance.collection('videos').withConverter(
        fromFirestore: (snapshot, _) => Video.fromJson(snapshot.data()!),
        toFirestore: (Video video, _) => video.toJson(),
      );

  Future<Result<List<Article>>> getArticles() async {
    try {
      final resultArticles = await articleDb.get();
      final articles = resultArticles.docs.map((e) => e.data()).toList();
      return Result.success(articles);
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<String>> addArticle(List<Article> articles) async {
    try {
      for (final article in articles) {
        final ref = articleDb.doc();
        await ref.set(article.copyWith(id: ref.id, imageUrl: ''));
      }
      return const Result.success('Success');
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<List<Video>>> getVideos() async {
    try {
      final resultVideos = await videoDb.get();
      final videos = resultVideos.docs.map((e) => e.data()).toList();
      return Result.success(videos);
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<String>> addVideo(Video video) async {
    try {
      final listJson = [
        {
          "id": "1",
          "title": "5 Tips Menjaga Kesehatan Mental Menurut Psikolog",
          "description":
              "Menjaga kesehatan mental adalah hal yang penting, karena kesehatan mental mempengaruhi aktivitas sehari-hari. Ada beberapa acara untuk mengatasi kesehatan mental yaitu dengan cara tetap produktif, gaya hidup sehat, fokus, bersosialisasi, dan juga meminta bantuan kepada psikolog atau ahli.",
          "videoUrl": "https://youtu.be/DqQHIZSoJRI?si=pMxLEC5YRFJkcLmQ",
          "category": "Kesehatan Mental"
        },
        {
          "id": "2",
          "title":
              "Cara Efektif Menjaga Kesehatan Mental (Gangguan Pencernaan dan Stres)",
          "description":
              "Perseners, sadar nggak sih kalau alasan kita gampang stres itu dipengaruhi oleh banyak hal? Mulai dari keseharian yang banyak tekanan, mindset dan pikiran-pikiran negatif, bahkan apa yang kita konsumsi. Kesehatan fisik kita mempengaruhi kesehatan mental, begitupula sebaliknya. Salah satunya, dari kesehatan sistem pencernaan.",
          "videoUrl": "https://youtu.be/u_FDoF_AYMQ?si=TqJRpRvlniqGCPlS",
          "category": "Kesehatan Mental"
        },
        {
          "id": "3",
          "title": "Kesehatan Mental: Apa Aku Normal? (Stres dan Overthinking)",
          "description":
              "Di video ini, Satu Persen membahas tentang cara untuk menghindari overthinking tentang masalah kamu normal apa tidak",
          "videoUrl": "https://youtu.be/MKJppZ18FYU?si=aGYzoBXbRDM_UGnK",
          "category": "Kesehatan Mental"
        },
        {
          "id": "4",
          "title": "Makanan Wajib Ibu Hamil Agar Bayi Cerdas",
          "description":
              "Mums, punya anak cerdas pasti keinginan semua orang tua. Hal tersebut pastinya harus didukung ketika masa kehamilan. Salah satunya dari makanan yang Mums konsumsi. Apa saja sih makanan wajib agar bayi cerdas? Nonton video ini, ya!",
          "videoUrl": "https://youtu.be/1PAJh481PYc?si=UnHs21vZWYl_IRsM",
          "category": "Makanan Sehat"
        },
        {
          "id": "5",
          "title":
              "Inilah Makanan yang Dilarang untuk Ibu Hamil - dr. Ardiansjah Dara Sjahruddin, SpOG., M.Kes.",
          "description":
              "Jangan lupa share, like, comment dan pencet belnya untuk informasi kesehatan menarik lainnya! Kamu juga bisa selalu update tentang informasi kesehatan, percintaan, bahkan fakta menarik lainnya dengan",
          "videoUrl": "https://youtu.be/26ksfOX8YjM?si=c5lBC1byR2IMiEQ8",
          "category": "Makanan Sehat"
        },
        {
          "id": "6",
          "title": "7 Tips Agar Kehamilanmu Tetap Sehat",
          "description":
              "Bumil harus menjaga kesehatan agar terhindar dari bahaya dan komplikasi selama kehamilan berlangsung. Yuk, ikuti 7 tips dari dokter Alodokter untuk tetap sehat saat hamil. Simak di video ini!",
          "videoUrl": "https://youtu.be/4ZAHX-N-AhM?si=NjNB2puEiAn_wsAm",
          "category": "Kehamilan"
        },
        {
          "id": "7",
          "title": "Bagaimana Cara Cepat Hamil, Ya? Ini Tipsnya dari Dokter!",
          "description":
              "Jika Mums tidak kunjung hamil, pasti sekarang mulai resah dan selalu bertanya bagaimana cara cepat hamil. Tenang, dr. Ardiansjah Dara Sjahruddin, SpOG., M.Kes., punya tipsnya untuk, Mums!",
          "videoUrl": "https://youtu.be/ukT5OmlX10w?si=butskotAL62vUzKZ",
          "category": "Kehamilan"
        },
        {
          "id": "8",
          "title": "DR OZ - Tips Untuk Menguatkan Kandungan Untuk Ibu Hamil",
          "description":
              "Dalam video kali ini, Dr. Oz akan membagikan tips yang sangat penting bagi para ibu hamil untuk menjaga kandungan mereka tetap kuat dan sehat. Dari makanan yang baik untuk kesehatan janin hingga pola hidup sehat yang dapat mendukung perkembangan bayi, Dr. Oz akan memberikan wawasan yang berharga bagi para calon ibu. Temukan informasi terkini dan terpercaya tentang nutrisi, suplemen, dan latihan yang bermanfaat selama masa kehamilan. Jaga kesehatan Anda dan buah hati Anda dengan mengikuti tips yang diberikan oleh Dr. Oz dalam video ini. Jangan lewatkan kesempatan untuk mendapatkan pengetahuan yang dapat memberi dampak positif pada perjalanan kehamilan Anda. Segera tonton dan bagikan kepada teman dan keluarga yang membutuhkan!",
          "videoUrl": "https://youtu.be/SCY76GJGIj4?si=LpierEhbtYI8Tit0",
          "category": "Kehamilan"
        }
      ];
      List<Video> videos = listJson.map((e) => Video.fromJson(e)).toList();
      for (final video in videos) {
        final ref = videoDb.doc();
        await ref.set(video.copyWith(id: ref.id));
      }
      return const Result.success('Success');
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }
}

@Riverpod(keepAlive: true)
EducationRepository educationRepository(EducationRepositoryRef ref) {
  return EducationRepository();
}
