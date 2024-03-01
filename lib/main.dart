import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'map.dart';
import 'sarch.dart';
import 'mypage.dart';



main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //アプリ
  const app = MaterialApp(home: Root());

  //プロバイダースコープで囲む
  const scope = ProviderScope(child: app);
  runApp(scope);
}

//プロバイダー
final indexProvider = StateProvider(
  (ref) {
    //変化するデータ　　0, 1, 2 ...
    return 0;
  },
);

//画面全体
class Root extends ConsumerWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //インデックス
    final index = ref.watch(indexProvider);

    //アイテムたち
    const items = [
      BottomNavigationBarItem(
        icon: Icon(Icons.search_rounded),
        label: '見つける',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.map),
        label: 'マップ',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'マイページ',
      ),
    ];

    //下のバー
    final bar = BottomNavigationBar(
      items: items,
      backgroundColor: const Color.fromARGB(255, 255, 189, 128),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      currentIndex: index,
      onTap: (index) {
        ref.read(indexProvider.notifier).state = index;
      },
    );

    // ignore: non_constant_identifier_names
    final Pages = [
      PostWidgets(),
      Map(),
      Mypage(),
    ];

    return Scaffold(
      body: Pages[index],
      bottomNavigationBar: bar,
    );
  }
}
