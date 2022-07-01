import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      home: TicTacToe(),
    );
  }
}

class TicTacToe extends StatefulWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  bool oTurn = true;// First player is O
  int filledBox = 0;
  int winner =0;
  List<String> displayXO = ["", "", "", "", "", "", "", "", ""];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:AppBar(
          title: Center(
            child: Text("Tic Tac Toe",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: Colors.blue[800],
              ),
            ),
          ),
          elevation: 15,
          backgroundColor: Colors.greenAccent,
        ),
        backgroundColor: Colors.grey[350],
        body: Column(
          children: [
            GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 80),
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration:
                      BoxDecoration(
                        border: Border.all(color: Colors.black,
                          width: 2.8,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          displayXO[index],
                          style: TextStyle(
                            fontSize: 45, fontWeight: FontWeight.bold,
                            color: displayXO[index]=="O"?Colors.blueAccent[700]:Colors.redAccent[700],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            const SizedBox(height: 25,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent),
                onPressed: _clearBoard,
                child: const Text("RESET"))
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (oTurn && displayXO[index]=="") {
        displayXO[index] = "O";
        filledBox+=1;
      } else if(!oTurn && displayXO[index]==""){
        displayXO[index] = "X";
        filledBox+=1;
      }
      oTurn = !oTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    //1st Row
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != "") {
      winner=1;
      _showWinDialog(displayXO[0]);
    }
    //2nd Row
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != "") {
      winner=1;
      _showWinDialog(displayXO[3]);
    }
    //3rd Row
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != "") {
      winner=1;
      _showWinDialog(displayXO[6]);
    }
    //1st Column
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != "") {
      winner=1;
      _showWinDialog(displayXO[0]);
    }
    //2nd Column
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != "") {
      winner=1;
      _showWinDialog(displayXO[1]);
    }
    //3rd Column
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != "") {
      winner=1;
      _showWinDialog(displayXO[2]);
    }
    //1st diagonal
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != "") {
      winner=1;
      _showWinDialog(displayXO[0]);
    }
    //2nd diagonal
    if (displayXO[2] == displayXO[4] &&
        displayXO[2] == displayXO[6] &&
        displayXO[2] != "") {
      winner=1;
      _showWinDialog(displayXO[2]);
    }
    if(filledBox==9 && winner==0){
      _showDrawDialog();
    }
  }

  void _clearBoard(){
    setState(() {
      for(int i=0; i<9; i++){
        displayXO[i] = "";
      }
    });
    filledBox=0;
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))
            ),
            title: const Text("It's a DRAW",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            actions: <Widget> [
              TextButton(
                onPressed: (){
                  _clearBoard();
                  Navigator.of(context).pop();
                },
                child: Text("Play Again",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.lightBlue[800],
                  ),
                ),
              )
            ],
          );
        }
    );
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            title: Text(winner+" IS THE WINNER",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            actions: <Widget> [
              TextButton(
                onPressed: (){
                  _clearBoard();
                  Navigator.of(context).pop();
                },
                child: Text("Play Again",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.lightBlue[800]
                  ),
                ),
              )
            ],
          );
        }
    );
  }
}

