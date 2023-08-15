import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

class AddWs extends StatelessWidget {
  const AddWs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Stateless Page of the Additon",
      home: Scaffold(
          appBar: AppBar(
            leading: const Icon(Icons.add, color: Colors.white),
            title: const Text(
              "Addition of two matrices",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.black,
          ),
          backgroundColor: Colors.black,
          body: const Sub(),
    ));
  }
}

class Sub extends StatefulWidget {
  const Sub({Key? key}) : super(key: key);

  @override
  State<Sub> createState() => SubState();
}

class SubState extends State<Sub> {
  TextEditingController rc = TextEditingController();
  TextEditingController cc = TextEditingController();
  int rows = 0;
  int columns = 0;
  List<List<num>> m1 = [];
  List<List<num>> m2 = [];
  List<List<num>> ans = [];
  bool setmatrix = false;

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: TextField(
                controller: rc,
                decoration: const InputDecoration(
                  labelText: "Rows",
                  filled: true,
                  fillColor: Colors.grey,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: cc,
                decoration: const InputDecoration(
                  labelText: "Columns",
                  filled: true,
                  fillColor: Colors.grey,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(150, 15, 150, 15),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                setmatrix = true;
                rows = int.tryParse(rc.text) ?? 0;
                columns = int.tryParse(cc.text) ?? 0;
                m1 = List.generate(
                    rows, (i) => List.generate(columns, (j) => 0));
                m2 = List.generate(
                    rows, (i) => List.generate(columns, (j) => 0));
                ans = List.generate(
                    rows, (i) => List.generate(columns, (j) => 0));
              });
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: const Text(
              "Set Matrix",
              style:
                  TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
            ),
          ),
        ),
        if (rows > 0 && columns > 0)
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,0,15),
            child: build2DArray(rows, columns, m1),
          ),
        if (rows > 0 && columns > 0)
          Expanded(
            flex: 1,
            child: build2DArray(rows, columns, m2),
          ),
        if(setmatrix==true)
        Padding(
          padding: const EdgeInsets.fromLTRB(150, 0, 150, 5),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                ans = add(m1, m2);
              });
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: const Text(
              "Add",
              style:
                  TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
            ),
          ),
        ),
        if (ans.isNotEmpty)
          Expanded(
            child: showMatrix(ans),
          ),
      ],
    );
  }
}

List<List<num>> add(List<List<num>> m1, List<List<num>> m2) {
  int rows = m1.length;
  int columns = m1[0].length;
  List<List<num>> ans =
      List.generate(rows, (i) => List.generate(columns, (j) => 0));
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < columns; j++) {
      ans[i][j] = m1[i][j] + m2[i][j];
    }
  }
  return ans;
}