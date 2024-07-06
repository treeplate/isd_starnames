import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const List<String> codes = [
  'Ada',
  'BEE',
  'Cat',
  'Carter',
  'Dragonis',
  'Epsilon',
  'Eta',
  'Geneva',
  'Hague',
  'Iota',
  'Mc',
  'Omicron',
  'Picard',
  '4K',
  'Smrt',
  'Zeta'
];
const List<String> symbols1 = [
  'A',
  'B',
  'D',
  'E',
  'G',
  'H',
  'K',
  'L',
  'M',
  'N',
  'P',
  'Q',
  'R',
  'X',
  'Y',
  'Z',
  '*',
  'C',
  'F',
  'J',
  'S',
  'T',
  'V',
  'W',
  'u',
  'Î±',
  'Î²',
  'Îµ',
  'Ï€',
  'Ï‡',
  'â˜‰',
  ''
];
const List<String> symbols2 = [
  'Σ',
  'Ω',
  'α',
  'β',
  'γ',
  'δ',
  'ε',
  'θ',
  'λ',
  'μ',
  'ξ',
  'π',
  'σ',
  'φ',
  'ψ',
  'ω'
];
const List<String> symbols3 = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  '11',
  '12',
  '13',
  '14',
  '15',
  '16'
];
const List<String> symbols4 = ['*', '¹', '²', '³', 'ⁱ', '⁽⁴⁾', 'ᵨ', 'ₘ'];
const List<String> symbols5 = ['A', 'Aa', 'Majoris', '1', '2', 'b', 'c', 'έ­'];
const List<String> symbols6 = ['', 'Ð–'];
const List<String> words1 = [
  'Andromedae',
  'Aquarii',
  'Arietis',
  'Aurigae',
  'Capricorni',
  'Cassiopeiae',
  'Hedralis',
  'Herculis',
  'Lalande',
  'Leporis',
  'Pavonis',
  'Pillaris',
  'Treeplatis',
  'Ursae',
  'Wolf',
  'Zeta'
];
const List<String> words2 = [
  'Galaxy',
  'Galaxy Cluster',
  '',
  'Prime',
  'Xi',
  'Posterior',
  'Prior',
  'Polaris',
  'Carina',
  'Center',
  'Red Giant',
  'Nebula',
  'Toobe',
  'Mount',
  'Flick',
  'Cluster',
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P'
];

const List<int> starCatSizes = [
  0xc8,
  0xc8,
  0x1441d,
  0x14500,
  0x14578,
  0x1481b,
  0x145ce,
  0x14518,
  0x145a4,
  0x1441b,
  0xa
];

final Iterable<int> allStars = List.generate(0xb00000, (i) => i).where((star) {
  int category = star >> 20;
  return starCatSizes[category] > star & 0xfffff;
});

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController controller = TabController(length: 4, vsync: this);
  final List<int> wordOptions1 = [];
  final List<int> wordOptions2 = [];
  final List<int> wordOptions3 = [];
  final List<int> wordOptions4 = [];
  TextEditingController number1 = TextEditingController(text: '');
  TextEditingController number2 = TextEditingController(text: '');
  bool boolean1 = false;
  bool boolean2 = false;
  List<int> starOptions = [];

  void find00Stars() {
    setState(() {
      starOptions = allStars.where((star) {
        if (star & 0x3 != 0) return false;
        if (int.tryParse(number1.text) != null &&
            ((star >> 6) & 0x3ffff) != (int.tryParse(number1.text) ?? 0)) {
          return false;
        }
        int code = (star >> 2) & 0xf;
        return wordOptions1.contains(code);
      }).toList();
    });
  }

  void find01Stars() {
    setState(() {
      starOptions = allStars.where((star) {
        if (star & 0x3 != 1) return false;
        if (int.tryParse(number1.text) != null) {
          int digits = ((star >> 6) & 0x3ff) | ((star >> 21) & 0xf);
          if (digits != int.tryParse(number1.text)) return false;
        }
        int code1 = (star >> 2) & 0xf;
        int code2 = (star >> 16) & 0x1f;
        return wordOptions1.contains(code1) && wordOptions2.contains(code2);
      }).toList();
    });
  }

  void find10Stars() {
    setState(() {
      starOptions = allStars.where((star) {
        if (star & 0x3 != 2) return false;
        if (int.tryParse(number1.text) != null) {
          int left = ((star >> 13) & 0x7ffe) ^ 0x555;
          if (left != int.tryParse(number1.text)) return false;
        }
        if (int.tryParse(number2.text) != null) {
          int right = ((star >> 1) & 0xfffe) ^ 0x555;
          if (right != int.tryParse(number2.text)) return false;
        }
        return true;
      }).toList();
    });
  }

  void find11Stars() {
    setState(() {
      starOptions = allStars.where((star) {
        if (star & 0x3 != 3) return false;
        int a = (star >> 2) & 0xf;
        int b = (star >> 6) & 0x7;
        int c = (star >> 9) & 0xf;
        int d = (star >> 15) & 0x1f;
        int e = (star >> 20) & 0x1f;
        bool f = ((star >> 14) & 1) == 1;
        bool g = ((star >> 13) & 1) == 1;
        if (f != boolean1 || g != boolean2) return false;
        if (int.tryParse(number1.text) != null &&
            d != int.tryParse(number1.text)) return false;
        if (!wordOptions1.contains(a)) return false;
        if (!wordOptions2.contains(b)) return false;
        if (!wordOptions3.contains(c)) return false;
        if (!wordOptions4.contains(e)) return false;
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          controller: controller,
          tabs: const [
            Text('Special Catalog Star'),
            Text('Catalog Star'),
            Text('Number+Number'),
            Text('Interesting Names')
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          Center(
            child: ListView(
              children: <Widget>[
                const Center(child: Text('Catalog Name')),
                for (int i = 0; i < codes.length; i++)
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(codes[i]),
                        Checkbox(
                          value: wordOptions1.contains(i),
                          onChanged: (value) {
                            value!
                                ? wordOptions1.add(i)
                                : wordOptions1.remove(i);
                            find00Stars();
                          },
                        )
                      ],
                    ),
                  ),
                const Center(child: Text('Index In Catalog')),
                Center(
                  child: SizedBox(
                    width: 500,
                    child: TextField(
                      decoration: const InputDecoration(
                          labelText: 'Leave blank for any number'),
                      controller: number1,
                      onChanged: (value) => find00Stars(),
                    ),
                  ),
                ),
                if (starOptions.length > 10)
                  Center(
                    child: SelectableText(
                        '${starOptions.length} stars (like S${starOptions.first.toRadixString(16).padLeft(6, '0')})'),
                  )
                else
                  ...starOptions.map(
                    (e) => Center(
                      child: SelectableText(
                          'S${e.toRadixString(16).padLeft(6, '0')}'),
                    ),
                  ),
              ],
            ),
          ),
          Center(
            child: ListView(
              children: <Widget>[
                const Center(child: Text('Catalog Letter 1')),
                for (int i = 0; i < symbols1.length / 2; i++)
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(symbols1[i]),
                        Checkbox(
                          value: wordOptions1.contains(i),
                          onChanged: (value) {
                            value!
                                ? wordOptions1.add(i)
                                : wordOptions1.remove(i);
                            find01Stars();
                          },
                        )
                      ],
                    ),
                  ),
                const Center(child: Text('Catalog Letter 2')),
                for (int i = 0; i < symbols1.length; i++)
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(symbols1[i]),
                        Checkbox(
                          value: wordOptions2.contains(i),
                          onChanged: (value) {
                            value!
                                ? wordOptions2.add(i)
                                : wordOptions2.remove(i);
                            find01Stars();
                          },
                        )
                      ],
                    ),
                  ),
                const Center(child: Text('Index In Catalog')),
                Center(
                  child: SizedBox(
                    width: 500,
                    child: TextField(
                      decoration: const InputDecoration(
                          labelText: 'Leave blank for any number'),
                      controller: number1,
                      onChanged: (value) => find01Stars(),
                    ),
                  ),
                ),
                if (starOptions.length > 10)
                  Center(
                    child: SelectableText(
                        '${starOptions.length} stars (like S${starOptions.first.toRadixString(16).padLeft(6, '0')})'),
                  )
                else
                  ...starOptions.map(
                    (e) => Center(
                      child: SelectableText(
                          'S${e.toRadixString(16).padLeft(6, '0')}'),
                    ),
                  ),
              ],
            ),
          ),
          Center(
            child: ListView(
              children: <Widget>[
                const Center(child: Text('Number 1')),
                Center(
                  child: SizedBox(
                    width: 500,
                    child: TextField(
                      decoration: const InputDecoration(
                          labelText: 'Leave blank for any number'),
                      controller: number1,
                      onChanged: (value) => find10Stars(),
                    ),
                  ),
                ),
                const Center(child: Text('Number 2')),
                Center(
                  child: SizedBox(
                    width: 500,
                    child: TextField(
                      decoration: const InputDecoration(
                          labelText: 'Leave blank for any number'),
                      controller: number2,
                      onChanged: (value) => find10Stars(),
                    ),
                  ),
                ),
                if (starOptions.length > 10)
                  Center(
                    child: SelectableText(
                        '${starOptions.length} stars (like S${starOptions.first.toRadixString(16).padLeft(6, '0')})'),
                  )
                else
                  ...starOptions.map(
                    (e) => Center(
                      child: SelectableText(
                          'S${e.toRadixString(16).padLeft(6, '0')}'),
                    ),
                  ),
              ],
            ),
          ),
          Center(
            child: ListView(
              children: <Widget>[
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                          'Use numbers instead of greek letters for prefix'),
                      Checkbox(
                        value: boolean2,
                        onChanged: (value) {
                          boolean2 = value!;
                          find11Stars();
                        },
                      )
                    ],
                  ),
                ),
                const Center(child: Text('Prefix', style: TextStyle(fontSize: 20),)),
                for (int i = 0; i < symbols2.length; i++)
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text((boolean2 ? symbols3 : symbols2)[i]),
                        Checkbox(
                          value: wordOptions1.contains(i),
                          onChanged: (value) {
                            value!
                                ? wordOptions1.add(i)
                                : wordOptions1.remove(i);
                            find11Stars();
                          },
                        )
                      ],
                    ),
                  ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Use suffix instead of superscript'),
                      Checkbox(
                        value: boolean1,
                        onChanged: (value) {
                          boolean1 = value!;
                          find11Stars();
                        },
                      )
                    ],
                  ),
                ),
                Center(child: Text(boolean1 ? 'Suffix' : 'Superscript', style: const TextStyle(fontSize: 20),)),
                for (int i = 0; i < symbols4.length; i++)
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(boolean1 ? symbols5[i] : symbols4[i]),
                        Checkbox(
                          value: wordOptions2.contains(i),
                          onChanged: (value) {
                            value!
                                ? wordOptions2.add(i)
                                : wordOptions2.remove(i);
                            find11Stars();
                          },
                        )
                      ],
                    ),
                  ),
                const Center(child: Text('Primary Name', style: TextStyle(fontSize: 20),)),
                for (int i = 0; i < words1.length; i++)
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(words1[i]),
                        Checkbox(
                          value: wordOptions3.contains(i),
                          onChanged: (value) {
                            value!
                                ? wordOptions3.add(i)
                                : wordOptions3.remove(i);
                            find11Stars();
                          },
                        )
                      ],
                    ),
                  ),
                const Center(child: Text('Star Type', style: TextStyle(fontSize: 20),)),
                for (int i = 0; i < words2.length; i++)
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(words2[i]),
                        Checkbox(
                          value: wordOptions4.contains(i),
                          onChanged: (value) {
                            value!
                                ? wordOptions4.add(i)
                                : wordOptions4.remove(i);
                            find11Stars();
                          },
                        )
                      ],
                    ),
                  ),
                const Center(child: Text('Number', style: TextStyle(fontSize: 20),)),
                Center(
                  child: SizedBox(
                    width: 500,
                    child: TextField(
                      decoration: const InputDecoration(
                          labelText: 'Leave blank for any number'),
                      controller: number1,
                      onChanged: (value) => find11Stars(),
                    ),
                  ),
                ),
                if (starOptions.length > 10)
                  Center(
                    child: SelectableText(
                        '${starOptions.length} stars (like S${starOptions.first.toRadixString(16).padLeft(6, '0')})'),
                  )
                else
                  ...starOptions.map(
                    (e) => Center(
                      child: SelectableText(
                          'S${e.toRadixString(16).padLeft(6, '0')}'),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
