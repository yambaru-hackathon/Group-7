import 'package:flutter/material.dart';

void main(){
  runApp(Feedpage());
}

class Feedpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(), // 最初に表示する画面を指定
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('レビュー'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text('Mr. Donut',
               style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // ボタンを中央揃えにする
              children: [
                CustomButton(
                  onPressed: () {
                    // 1つ目のボタンが押されたときの処理
                  },
                  text: 'レビュー',
                  buttonColor: Color.fromARGB(255, 220, 161, 13),
                  topLeftRadius: 20,
                  bottomLeftRadius: 20,
                ),
                CustomButton(
                  onPressed: () {
                    // 2つ目のボタンが押されたときの処理
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondScreen()),
                    );
                  },
                  text: '写真',
                  buttonColor: Colors.white,
                  topRightRadius: 20,
                  bottomRightRadius: 20,
                ),
              ],
            ),

            SizedBox(width: 50),
              Align(alignment: Alignment.center,
                child: Container(
                  width: 350,
                  height: 225,
                  color: Colors.white,
                  child: Text('SNSで知った、東急池上線荏原中延駅前の、行列人気ラーメン店です。\n肉感たっぷりのロースチャーシューを使った、あっさりスープの醤油ラーメンが人気らしい。\n平日の13時過ぎ、１人でカウンター席を利用しました。',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize:18,
                  ),
                ),
              )
              ),
              SliderWidget(),
              Row(
                children: [
                  Text('味'),
                  Icon(Icons.star_outlined),
                  Icon(Icons.star_outlined),
                  Icon(Icons.star_outlined),
                  Icon(Icons.star_outlined),
                  Icon(Icons.star_outlined),
                ]
                ),
                SizedBox(height: 30,),
                Row(children:[
                  Text(
              '#YoursToMake',
              //フォントを変更、サイズも変更する
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16
              ),
            ),
                ])
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('写真'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text('Mr. Donut',
               style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // ボタンを中央揃えにする
              children: [
                CustomButton(
                  onPressed: () {
                    // 2つ目のボタンが押されたときの処理
                    Navigator.pop(context);
                  },
                  text: 'レビュー',
                  buttonColor: Colors.white,
                  topLeftRadius: 20,
                  bottomLeftRadius: 20,
                ),
                CustomButton(
                  onPressed: () {
                    // 1つ目のボタンが押されたときの処理
                  },
                  text: '写真',
                  buttonColor: Color.fromARGB(255, 220, 161, 13),
                  topRightRadius: 20,
                  bottomRightRadius: 20,
                ),
              ],
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              crossAxisCount: 3,
              children: [
                Image.asset('images/a.jpg'),
                Image.asset('images/a.jpg'),
                Image.asset('images/a.jpg'),
                Image.asset('images/a.jpg'),
                Image.asset('images/a.jpg'),
                Image.asset('images/a.jpg'),
                Image.asset('images/a.jpg'),
                Image.asset('images/a.jpg'),
                Image.asset('images/a.jpg'),
                Image.asset('images/a.jpg'),
                Image.asset('images/a.jpg'),
                Image.asset('images/a.jpg'),

              ]
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double? topLeftRadius;
  final double? topRightRadius;
  final double? bottomLeftRadius;
  final double? bottomRightRadius;
  final Color buttonColor;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.buttonColor,
    this.topLeftRadius,
    this.topRightRadius,
    this.bottomLeftRadius,
    this.bottomRightRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 150, // ボタンの幅を指定
        height: 50, // ボタンの高さを指定
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeftRadius ?? 0),
            topRight: Radius.circular(topRightRadius ?? 0),
            bottomLeft: Radius.circular(bottomLeftRadius ?? 0),
            bottomRight: Radius.circular(bottomRightRadius ?? 0),
          ),
          border: Border.all(color: Colors.black, width:2),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class SliderWidget extends StatefulWidget {
  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double _value = 0.0; // スライダーの現在の値

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            Text(
              'Min', // 最小値のラベル
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Max', // 最大値のラベル
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        SizedBox(height: 10), // スペースを追加
        Slider(
          value: _value,
          min: 0.0,
          max: 100.0,
          divisions: 10,
          onChanged: (double newValue) {
            setState(() {
              _value = newValue;
            });
          },
        ),
        SizedBox(height: 10), // スペースを追加
      ],
    );
  }
}
