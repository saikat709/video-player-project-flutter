import 'package:flutter/material.dart';

class GetInputDialog extends StatelessWidget {
  final onChanged;

  const GetInputDialog({super.key,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        margin: const EdgeInsets.all(25),
        height: MediaQuery.of(context).size.height/6.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Video Files Url ",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700
              ),
            ),
            const SizedBox(height: 12,),
            TextFormField(
              onChanged: (val){
                onChanged(val);
              },
              decoration: const InputDecoration(
                prefix: Text("https://"),
                label: Text("Enter url here.."),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueAccent,
                    width: 5.0,
                  )
                )
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: (){
                      onChanged(null);
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel")
                ),
                TextButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: const Text("Done")
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
