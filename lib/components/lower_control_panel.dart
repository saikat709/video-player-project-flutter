import 'package:flutter/material.dart';

class LowerControlPanel extends StatefulWidget {
  final VoidCallback onProgressChange;
  final int totalTime;
  const LowerControlPanel({super.key,
          required this.onProgressChange,
          required this.totalTime,
  });

  @override
  State<LowerControlPanel> createState() => _LowerControlPanelState();
}

class _LowerControlPanelState extends State<LowerControlPanel> {
  var _progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent.withOpacity(0.5555),
      padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 8,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("0:28"),
              Flexible(
                flex: 1,
                child: Slider(
                    max: 100,
                    value: _progress,
                    onChanged: (val){
                        setState(() {
                          _progress = val;
                        });
                    }
                  ),
              ),
              Text(widget.totalTime.toString()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton.filled(
                  onPressed: (){
                    setState(() {
                      _progress = _progress-10<widget.totalTime ? _progress : _progress-10;
                    });
                  },
                  icon: const Icon(Icons.fast_rewind)
              ),
              IconButton.filled(
                  onPressed: (){

                  },
                  icon: const Icon(Icons.pause, size: 30,)
              ),
              IconButton.filled(
                  onPressed: (){
                    setState(() {
                      _progress = _progress+10<0 ? _progress : _progress+10;
                    });
                  },
                  icon: const Icon(Icons.fast_forward)
              ),

            ],
          )
        ],
      ),
    );
  }
}
