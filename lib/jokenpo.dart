import 'dart:math';

import 'package:flutter/material.dart';

class Jokenpo extends StatefulWidget {
  const Jokenpo({super.key});

  @override
  State<Jokenpo> createState() => _JokenpoState();
}

class _JokenpoState extends State<Jokenpo> {
  String imgUserPlayer = "imagens/indefinido.png";
  String imgAppPlayer = "imagens/indefinido.png";

  int _userPoints = 0;
  int _appPoints = 0;
  int _tiePoints = 0;

  Color _borderUserColor = Colors.transparent;
  Color _borderAppColor = Colors.transparent;

  String _obtemEscolhaApp() {
    var opcoes = ['pedra', 'papel', 'tesoura'];

    String vlrEscolhido = opcoes[Random().nextInt(3)];

    return vlrEscolhido;
  }

  void _terminaJogada(String escolhaUser, escolhaApp) {
    var resultado = "indefinido";

    switch (escolhaUser) {
      case "pedra":
        if (escolhaApp == "papel") {
          resultado = "app";
        } else if (escolhaApp == "tesoura") {
          resultado = "user";
        } else {
          resultado = "empate";
        }
        break;

      case "papel":
        if (escolhaApp == "pedra") {
          resultado = "user";
        } else if (escolhaApp == "tesoura") {
          resultado = "app";
        } else {
          resultado = "empate";
        }
        break;

      case "tesoura":
        if (escolhaApp == "papel") {
          resultado = "user";
        } else if (escolhaApp == "pedra") {
          resultado = "app";
        } else {
          resultado = "empate";
        }
        break;
    }
    setState(() {
      imgAppPlayer = 'imagens/$escolhaApp.png';

      if (resultado == "user") {
        _userPoints++;

        _borderUserColor = Colors.green;
        _borderAppColor = Colors.transparent;
      } else if (resultado == "app") {
        _appPoints++;

        _borderUserColor = Colors.transparent;
        _borderAppColor = Colors.green;
      } else {
        _tiePoints++;
        _borderUserColor = Colors.orange;
        _borderAppColor = Colors.orange;
      }
    });
  }

  void _iniciaJogada(String opcao) {
    setState(() {
      imgUserPlayer = 'imagens/$opcao.png';
    });

    String escolhaApp = _obtemEscolhaApp();

    setState(() {
      imgAppPlayer = 'imagens/$escolhaApp.png';
    });

    _terminaJogada(opcao, escolhaApp);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Pedra Papel Tesoura',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Jokenpo'),
          ),
          body: Column(
            children: [
              const Text('Disputa'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: _borderUserColor, width: 4),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100))),
                    child: Image.asset(imgUserPlayer, height: 120),
                  ),
                  const Text('vs'),
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: _borderAppColor, width: 4),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100))),
                      child: Image.asset(
                        imgAppPlayer,
                        height: 120,
                      )),
                ],
              ),
              const Text('Placar'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(children: [
                    const Text('Você'),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7))),
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(35),
                      child: Text('$_userPoints'),
                    )
                  ]),
                  Column(children: [
                    const Text('Empate'),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7))),
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(35),
                      child: Text('$_tiePoints'),
                    )
                  ]),
                  Column(children: [
                    const Text('Maquina'),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7))),
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(35),
                      child: Text('$_appPoints'),
                    )
                  ]),
                ],
              ),
              const Text('Opções'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => _iniciaJogada("pedra"),
                    child: Image.asset('imagens/pedra.png', height: 120),
                  ),
                  GestureDetector(
                    onTap: () => _iniciaJogada("papel"),
                    child: Image.asset('imagens/papel.png', height: 120),
                  ),
                  GestureDetector(
                    onTap: () => _iniciaJogada("tesoura"),
                    child: Image.asset('imagens/tesoura.png', height: 120),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
