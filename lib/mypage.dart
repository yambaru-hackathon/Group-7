import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gyuukaku/service.dart';

final imgProvider = Provider((_) => [
  "images/desk.png",
  "images/bird.png",
  "images/mofuo.png",
  "images/desk.png",
  "images/bird.png",
  "images/mofuo.png",
]);

var usersID = 'yzOTsb7lS5DwrvvYRPl1';

final nameProvider = FutureProvider<String>((ref) async {
  final service = ref.read(serviceProvider);
  final userData = await service.read(usersID);
  return userData != null ? userData[0] : '';
});

final likedProvider = FutureProvider<int>((ref) async {
  final service = ref.read(serviceProvider);
  final userData = await service.read(usersID);
  return userData != null ? int.tryParse(userData[1]) ?? 0 : 0;
});

final postsProvider = FutureProvider<int>((ref) async {
  final service = ref.read(serviceProvider);
  final userData = await service.read(usersID);
  return userData != null ? int.tryParse(userData[2]) ?? 0 : 0;
});

final overlayVisibleProvider = StateNotifierProvider<OverlayVisibleNotifier, bool>((ref) => OverlayVisibleNotifier());

final serviceProvider = Provider<FirestoreService>((_) => FirestoreService());

class OverlayVisibleNotifier extends StateNotifier<bool> {
  OverlayVisibleNotifier() : super(false);

  void toggleOverlay() {
    state = !state;
  }
}

class Mypage extends ConsumerWidget {
  Mypage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overlayVisible = ref.watch(overlayVisibleProvider);
    final nameAsyncValue = ref.watch(nameProvider);
    final likedAsyncValue = ref.watch(likedProvider);
    final postsAsyncValue = ref.watch(postsProvider);
    final imgList = ref.watch(imgProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('images/Kapsel.png'),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nameAsyncValue.when(
                            data: (data) => data,
                            loading: () => '', // データがロード中の場合のデフォルト値
                            error: (_, __) => '', // エラーが発生した場合のデフォルト値
                          ),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              '#肉好き',
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF4992FF),
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              '#ダイエットは明日から',
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF4992FF),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(flex: 2),
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
                              likedAsyncValue.when(
                                data: (data) => data.toString(),
                                loading: () => '', // データがロード中の場合のデフォルト値
                                error: (_, __) => '', // エラーが発生した場合のデフォルト値
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
                          'いいね',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Spacer(flex: 1),
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
                              postsAsyncValue.when(
                                data: (data) => data.toString(),
                                loading: () => 'now loading', // データがロード中の場合のデフォルト値
                                error: (_, __) => 'error', // エラーが発生した場合のデフォルト値
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
                          '件の投稿',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 15),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(260,33),
                        backgroundColor: const Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      onPressed: () {
                        ref.read(overlayVisibleProvider.notifier).toggleOverlay();
                      },
                      child: Text(
                        'ブックマークリスト',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4992FF),
                        ),
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(80,33),
                        backgroundColor: const Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      onPressed: () { /* ボタンがタップされた時の処理 */ },
                      child: Center(
                        child: Icon(
                          Icons.share,
                          color: const Color(0xFF4992FF),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 6,
                  color: const Color(0xFFD9D9D9),
                ),
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    children: imgList.map((img) {
                      return InstagramPostItem(img: img);
                    }).toList(),
                  )
                )
              ],
            ),
          ),
          if (overlayVisible)
            GestureDetector(
              onTap: () {
                ref.read(overlayVisibleProvider.notifier).toggleOverlay();
              },
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Container(
                    width: 300,
                    height: 630,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(44),
                      border: Border.all(
                        color: Colors.black,
                        width: 4,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Container(
                          width: 240,
                          height: 35,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4992FF),
                            borderRadius: BorderRadius.circular(36),
                          ),
                          child: Center(
                            child: Text(
                              'ブックマークリスト',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 3,
                            children: imgList.map((img) {
                              return InstagramPostItem(img: img);
                            }).toList(),
                          )
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class InstagramPostItem extends StatelessWidget {
  const InstagramPostItem({Key? key, required this.img}) : super(key: key);

  final String img;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // 画像がタップされた時の処理
      },
      child: Image.asset(
        img,
        fit: BoxFit.cover,
      ),
    );
  }
}
