import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gyuukaku/service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

  final img = [
    "images/desk.png",
    "images/bird.png",
    "images/mofuo.png",    
    "images/desk.png",
    "images/bird.png",
    "images/mofuo.png",
  ];

  final imgProvider = FutureProvider<List<String>>((ref) async {
  final service = ref.read(serviceProvider);
  return service.storePostdImages(storeID); // storePostdImages 関数を呼び出す
});

var usersID = 'BVMyTOqbcwbhzmv2jQkB';
var storeID = 'qWA8WncdPsdir1zRyHlP';

final serviceProvider = Provider<FirestoreService>((_) => FirestoreService());

final imageProvider = FutureProvider<String>((ref) async {
  final service = ref.read(serviceProvider);
  final storeData = await service.read_store(storeID);
  return storeData != null ? storeData[0] : 'DBからのデータが取れませんでした。';
});

final nameProvider = FutureProvider<String>((ref) async {
  final service = ref.read(serviceProvider);
  final storeData = await service.read_store(storeID);
  return storeData != null ? storeData[1] : 'DBからのデータが取れませんでした。';
});

final detailProvider = FutureProvider<String>((ref) async {
  final service = ref.read(serviceProvider);
  final storeData = await service.read_store(storeID);
  return storeData != null ? storeData[2] : '';
});

final totalProvider = FutureProvider<int>((ref) async {
  final service = ref.read(serviceProvider);
  final storeData = await service.read_store(storeID);
  return storeData != null ? int.tryParse(storeData[3]) ?? 0 : 0;
});

final tasteProvider = FutureProvider<int>((ref) async {
  final service = ref.read(serviceProvider);
  final storeData = await service.read_store(storeID);
  return storeData != null ? int.tryParse(storeData[4]) ?? 0 : 0;
});

final hygieneProvider = FutureProvider<int>((ref) async {
  final service = ref.read(serviceProvider);
  final storeData = await service.read_store(storeID);
  return storeData != null ? int.tryParse(storeData[5]) ?? 0 : 0;
});

final atmosphereProvider = FutureProvider<int>((ref) async {
  final service = ref.read(serviceProvider);
  final storeData = await service.read_store(storeID);
  return storeData != null ? int.tryParse(storeData[6]) ?? 0 : 0;
});

final likedProvider = FutureProvider<int>((ref) async {
  final service = ref.read(serviceProvider);
  final storeData = await service.read_store(storeID);
  return storeData != null ? int.tryParse(storeData[7]) ?? 0 : 0;
});

final addressProvider = FutureProvider<String>((ref) async {
  final service = ref.read(serviceProvider);
  final storeData = await service.read_store(storeID);
  return storeData != null ? storeData[8] : '';
});

final averageTimeProvider = FutureProvider<int>((ref) async {
  final service = ref.read(serviceProvider);
  final storeData = await service.read_store(storeID);
  return storeData != null ? int.tryParse(storeData[9]) ?? 0 : 0;
});

final openProvider = FutureProvider<String>((ref) async {
  final service = ref.read(serviceProvider);
  final storeData = await service.read_store(storeID);
  return storeData != null ? storeData[10] : '';
});







class Sarch extends ConsumerWidget {
  Sarch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final imageURL =             
    ref.watch(imageProvider).when(
    data: (data) => data,
    loading: () => '', // データがロード中の場合のデフォルト値
    error: (_, __) => '', // エラーが発生した場合のデフォルト値
    );

    final isLoading = ref.watch(imageProvider).maybeWhen(
    loading: () => true, // ローディング中の場合 true を返す
    orElse: () => false, // それ以外の場合は false を返す
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Container(
          height: 150,
          color: Colors.white,
          child: ClipRect(
            child: Visibility(
              visible: !isLoading && imageURL.isNotEmpty, // 画像が読み込まれていて表示する場合のみ表示
              child: Image.network(
                imageURL,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              replacement: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
              SizedBox(height: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                  SizedBox(width: 15,),
                  Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF03FB93),
                  ),
                ),
                SizedBox(width: 3,),
                Text(
                  '営業中',
                    style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    ),
                )
              ],
            ),
                Center(
                  child: Text(
                  ref.watch(nameProvider).when(
                  data: (data) => data,
                  loading: () => 'ロードエラー', // データがロード中の場合のデフォルト値
                  error: (_, __) => 'エラーが出た', // エラーが発生した場合のデフォルト値
                ),
                  style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                  ),
                  ),
                ),
                SizedBox(height: 3,),
                Center(
                  child: Text(
                  ref.watch(detailProvider).when(
                  data: (data) => data,
                  loading: () => 'ロードエラー', // データがロード中の場合のデフォルト値
                  error: (_, __) => 'エラーが出た', // エラーが発生した場合のデフォルト値
                ),
                        style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        ),
                    ),
                ),
                SizedBox(height: 30,),
            Row(
              children: [
                Spacer(flex: 1,),
                Text(
                  ref.watch(totalProvider).when(
                  data: (data) => '★ $data',
                  loading: () => 'ロードエラー', // データがロード中の場合のデフォルト値
                  error: (_, __) => 'エラーが出た', // エラーが発生した場合のデフォルト値
                ),
                    style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    ),
                ),
                Spacer(flex: 2,),
                Column(
                  children: [


// RatingBar.builder(
//   itemBuilder: (context, index) {
//     final totalAsyncValue = ref.watch(totalProvider);
//     return totalAsyncValue.when(
//       data: (total) {
//         return Container(
//           padding: EdgeInsets.all(0), // アイコンとアイコンの間の距離を調整
//           child: Icon(
//             index < total ? Icons.star : Icons.star_border,
//             color: const Color(0xFF4992FF),
//             size: 10, // アイコンのサイズを調整
//           ),
//         );
//       },
//       loading: () => CircularProgressIndicator(), // ロード中はローディングインジケータを表示
//       error: (_, __) => Icon(Icons.star_border), // エラーが発生した場合はデフォルトのアイコンを表示
//     );
//   },
//   onRatingUpdate: (rating) {
//     // 評価が更新されたときの処理を書く
//   },
//   itemCount: 5,
//   unratedColor: Colors.blue[100],
// ),




                    Row(
                      children: [
                        Text(
                          '味',
                            style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            ),
                        ),
                        Text(
                          '★★★★',
                            style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF4992FF),
                            ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14,),
                    Row(
                      children: [
                        Text(
                          '衛星',
                            style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            ),
                        ),
                        Text(
                          '★★★★',
                            style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF4992FF),
                            ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14,),
                    Row(
                      children: [
                        Text(
                          '雰囲気',
                            style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            ),
                        ),
                        Text(
                          '★★★★',
                            style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF4992FF),
                            ),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(flex: 2,),
                  Column(
                    children: [
                        Container(
                        width: 90,
                        height: 33,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(36),
                        ),
                        child: Center(
                          child: Text(
                            ref.watch(likedProvider).when(
                            data: (data) => data.toString(),
                            loading: () => 'ロードエラー', // データがロード中の場合のデフォルト値
                            error: (_, __) => 'エラーが出た', // エラーが発生した場合のデフォルト値
                          ),
                            style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF4992FF),
                            ),
                          ),
                        ),
                      ),
                    Text(
                      'いいね！',
                      style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 17,),
                      Container(
                        width: 90,
                        height: 33,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(36),
                        ),
                        child: Center(
                          child: Text(
                            '9',
                            style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF4992FF),
                            ),
                          ),
                        ),
                      ),
                    Text(
                      '件の投稿',
                      style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Spacer(flex: 1,),
              ],
            ),
          SizedBox(height: 40,),
          Row(
            children: [
              Spacer(flex: 2,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(85,35),
                    backgroundColor: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                onPressed: () { /* ボタンがタップされた時の処理 */ },
                child: Row(
                  children: [
                    Icon(
                      Icons.directions_car,
                      size: 14,
                    ),
                    Text(
                      'GO',
                        style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF4992FF),
                        ),
                      ),
                  ],
                ),
                ),
              Spacer(flex: 3,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(105,35),
                    backgroundColor: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                onPressed: () {
                    showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 450,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Spacer(),
                            Text(
                            '住所',
                              style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              ),
                            ),
                            Container(
                              width: 340,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD9D9D9),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: Center(
                                child: Text(
                                    ref.watch(addressProvider).when(
                                    data: (data) => data,
                                    loading: () => '読み込み中', // データがロード中の場合のデフォルト値
                                    error: (_, __) => 'エラーが出た', // エラーが発生した場合のデフォルト値
                                  ),
                                  style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF4992FF),
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Row(
                              children: [
                            Spacer(),
                            Column(
                              children: [
                                Text(
                                '退店までの時間',
                                  style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  ),
                                ),
                            Container(
                              width: 340,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD9D9D9),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: Center(
                                child: Text(
                                    ref.watch(averageTimeProvider).when(
                                    data: (data) => '$data分',
                                    loading: () => '読み込み中', // データがロード中の場合のデフォルト値
                                    error: (_, __) => 'エラーが出た', // エラーが発生した場合のデフォルト値
                                  ),
                                  style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF4992FF),
                                  ),
                                ),
                              ),
                            ),
                            ],
                            ),
                            Spacer()
                              ],
                            ),
                            Spacer(),
                            Text(
                            '開店時間',
                              style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              ),
                            ),
                            Container(
                              width: 340,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD9D9D9),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: Center(
                                child: Text(
                                    ref.watch(openProvider).when(
                                    data: (data) => data,
                                    loading: () => '読み込み中', // データがロード中の場合のデフォルト値
                                    error: (_, __) => 'エラーが出た', // エラーが発生した場合のデフォルト値
                                  ),
                                  style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF4992FF),
                                  ),
                                ),
                              ),
                            ),
                              Spacer(),
                              Center(
                                child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(85,35),
                                  backgroundColor: const Color(0xFFD9D9D9),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(99),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  '戻る',
                                    style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF4992FF),
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                          ],
                        )
                      );
                    },
                  );
                },
                child: Text(
                  '詳細情報',
                    style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4992FF),
                    ),
                  ),
                ),
              Spacer(flex: 3,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(85,35),
                    backgroundColor: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                onPressed: () {
                  openPhoneCall();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.call,
                      size: 14,
                      color: const Color(0xFF4992FF),
                    ),
                    Text(
                      '電話',
                        style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF4992FF),
                        ),
                      ),
                  ],
                ),
                ),
                Spacer(flex: 2,),
            ],
          ),

          SizedBox(height: 20,),

          // 画像まとめているところ
          Container(
            width: double.infinity,
            height: 6,
            color: const Color(0xFFD9D9D9),
          ),
                      MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: Consumer(builder: (context, watch, child) {
                          final imgListAsyncValue = ref.watch(imgProvider); // imgProvider の値を取得

                          return imgListAsyncValue.when(
                            data: (imgList) {
                              return GridView.count(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisCount: 3,
                                children: imgList.map((img) {
                                  return InstagramPostItem(img: img);
                                }).toList(),
                              );
                            },
                            loading: () {
                              return Center(child: CircularProgressIndicator());
                            },
                            error: (error, stackTrace) {
                              return Text('Error: $error');
                            },
                          );
                        }),
                      )
          ]),
      ),
    );
  }
}


class InstagramPostItem extends StatelessWidget {
  const InstagramPostItem({Key? key,required this.img}) : super(key: key);

  final String img;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // 画像が押された時の処理
      },
      child: Image.network(
        img,
        fit: BoxFit.cover,
      ),
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void openPhoneCall() async {
    final Uri callLaunchUri = Uri(
      scheme: 'tel',
      path: '117',
    );

    canLaunchUrl(callLaunchUri).then((value) {
      if (value) {
            launchUrl(callLaunchUri).then((value) {
              print('launchUrl result: $value');
            });
      } else {
            print('cannot call');
      }
    });
}


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      home: ProviderScope(
        child: Sarch(),
      ),
    ),
  );
}