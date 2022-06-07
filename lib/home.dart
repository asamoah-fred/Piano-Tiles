// ignore_for_file: prefer_const_constructors

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'line.dart';
import 'line_divider.dart';
import 'note.dart';
import 'song_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AudioCache player = AudioCache();

  List<Note> notes = initNotes();
  late AnimationController animationController;
  int currentNoteIndex = 0;
  int points = 0;
  bool hasStarted = false;
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed && isPlaying) {
        if (notes[currentNoteIndex].state != NoteState.tapped) {
          //game over
          setState(() {
            isPlaying = false;
            notes[currentNoteIndex].state = NoteState.missed;
          });
          animationController.reverse().then((_) => _showFinishDialog());
        } else if (currentNoteIndex == notes.length - 5) {
          //song finished
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Score: $points"),
                actions: <Widget>[
                  // ignore: deprecated_member_use
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("RESTART"),
                  ),
                ],
              );
            },
          ).then((_) => _restart());
        } else {
          setState(() => ++currentNoteIndex);
          animationController.forward(from: 0);
        }
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Image.asset(
            'assets/jk.jpeg',
            fit: BoxFit.cover,
          ),
          Row(
            children: <Widget>[
              _drawLine(0),
              LineDivider(),
              _drawLine(1),
              LineDivider(),
              _drawLine(2),
              LineDivider(),
              _drawLine(3),
            ],
          ),
          _drawPoints(),
        ],
      ),
    );
  }

  void _restart() {
    setState(() {
      hasStarted = false;
      isPlaying = true;
      notes = initNotes();
      points = 0;
      currentNoteIndex = 0;
    });
    animationController.reset();
  }

  void _showFinishDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Score: $points"),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("RESTART"),
            ),
          ],
        );
      },
    ).then((_) => _restart());
  }

  void _onTap(Note note) {
    bool areAllPreviousTapped = notes
        .sublist(0, note.orderNumber)
        .every((n) => n.state == NoteState.tapped);
    print(areAllPreviousTapped);
    if (areAllPreviousTapped) {
      if (!hasStarted) {
        setState(() => hasStarted = true);
        animationController.forward();
      }
      _playNote(note);
      setState(() {
        note.state = NoteState.tapped;
        ++points;
      });
    }
  }

  _drawLine(int lineNumber) {
    return Expanded(
      child: Line(
        lineNumber: lineNumber,
        currentNotes: notes.sublist(currentNoteIndex, currentNoteIndex + 5),
        onTileTap: _onTap,
        animation: animationController,
      ),
    );
  }

  _drawPoints() {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Text(
          "$points",
          style: TextStyle(color: Colors.red, fontSize: 60),
        ),
      ),
    );
  }

  _playNote(Note note) {
    switch (note.line) {
      case 0:
        player.play('a.mp3');
        return;
      case 1:
        player.play('b.mp3');
        return;
      case 2:
        player.play('c.mp3');
        return;
      case 3:
        player.play('d.mp3');
        return;
      case 4:
        player.play('e.mp3');
        return;
      case 5:
        player.play('f.mp3');
        return;
      case 6:
        player.play('g.mp3');
        return;
      case 7:
        player.play('h.mp3');
        return;
      case 8:
        player.play('i.mp3');
        return;
      case 9:
        player.play('j.mp3');
        return;
      case 10:
        player.play('k.mp3');
        return;
      case 11:
        player.play('l.mp3');
        return;
      case 12:
        player.play('m.mp3');
        return;
      case 13:
        player.play('n.mp3');
        return;
      case 14:
        player.play('o.mp3');
        return;
      case 15:
        player.play('p.mp3');
        return;
      case 16:
        player.play('q.mp3');
        return;
      case 17:
        player.play('r.mp3');
        return;
      case 18:
        player.play('s.mp3');
        return;
      case 19:
        player.play('t.mp3');
        return;
      case 20:
        player.play('u.mp3');
        return;
      case 21:
        player.play('v.mp3');
        return;
      case 22:
        player.play('w.mp3');
        return;
      case 23:
        player.play('a.mp3');
        return;
    }
  }
}
