import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gyuukaku/service.dart';


final imgProvider = FutureProvider<List<String>>((ref) async {
  final service = ref.read(serviceProvider);
  return service.readUserPostImages(usersID); // readUserPostImages 関数を呼び出す
});

var usersID = 'BVMyTOqbcwbhzmv2jQkB';

final nameProvider = FutureProvider<String>((ref) async {
  final service = ref.read(serviceProvider);
  final userData = await service.read_user(usersID);
  return userData != null ? userData[0] : '';
});

final likedProvider = FutureProvider<int>((ref) async {
  final service = ref.read(serviceProvider);
  final userData = await service.read_user(usersID);
  return userData != null ? int.tryParse(userData[1]) ?? 0 : 0;
});

final profileURLProvider = FutureProvider<String>((ref) async {
  final service = ref.read(serviceProvider);
  final userData = await service.read_user(usersID);
  return userData != null ? userData[2] : '';
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
    final profileURLValue = ref.watch(profileURLProvider);
    final imgList = ref.watch(imgProvider);

    final profileURL =             
    profileURLValue.when(
    data: (data) => data,
    loading: () => '', // データがロード中の場合のデフォルト値
    error: (_, __) => '', // エラーが発生した場合のデフォルト値
    );

    final isLoading = profileURLValue.maybeWhen(
    loading: () => true, // ローディング中の場合 true を返す
    orElse: () => false, // それ以外の場合は false を返す
    );


    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: isLoading, // ローディング中の場合には true を返し、ローディングインジケーターを表示
                  child: Center(child: CircularProgressIndicator()),
                ),
                Visibility(
                  visible: !isLoading, // ローディング中ではない場合には true を返し、画像を表示
                  child: Image.network(
                    profileURL,
                    fit: BoxFit.cover, //ここ注意
                  ),
                ),
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
                                imgList.when(
                                  data: (imgList) => imgList.length.toString(), // データが利用可能になったらリストの要素数を取得する
                                  loading: () => '', // ローディング中は要素数を 0 とする
                                  error: (_, __) => '', // エラーが発生した場合も要素数を 0 とする
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
                        fixedSize: const Size(220,33),
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
                      onPressed: () {
                      },
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
      child: Image.network(
        img,
        fit: BoxFit.cover,
      ),
    );
  }
}
