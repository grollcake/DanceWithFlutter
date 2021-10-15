import 'package:flutter/material.dart';

class Verificator extends StatefulWidget {
  const Verificator(
      {Key? key,
      required this.length,
      this.size = 36.0,
      required this.onComplete,
      this.onChange,
      this.inputType = TextInputType.text})
      : super(key: key);

  final int length;
  final double size;
  final ValueChanged<String> onComplete;
  final ValueChanged<String>? onChange;
  final TextInputType inputType;

  @override
  _VerificatorState createState() => _VerificatorState();
}

class _VerificatorState extends State<Verificator> {
  var _verificateCode = '';
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _verificateCode = _verificateCode.padRight(widget.length, ' ');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.requestFocus();
        setState(() {

        });
      },
      child: Container(
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
            // color: Colors.yellow.shade200,
            ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 0,
              height: 0,
              child: TextField(
                focusNode: _focusNode,
                onChanged: (String codes) {
                  setState(() {
                    _verificateCode = codes.padRight(widget.length, ' ');
                  });

                  if (widget.onChange != null) widget.onChange!(codes);

                  if (codes.length == widget.length) {
                    _focusNode.unfocus();
                    widget.onComplete(codes);
                  }
                },
                maxLength: widget.length,
                keyboardType: widget.inputType,
                decoration: InputDecoration(counterText: ''),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                widget.length,
                (index) {
                  bool _filled = _verificateCode.trim().length > index;
                  return Container(
                    width: widget.size * 1.2,
                    height: widget.size * 1.5,
                    margin: EdgeInsets.only(left: index > 0 ? 10 : 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.size / 6),
                      color: _filled ? Colors.orange.shade50 : Colors.orange.shade50,
                      border: Border.all(
                        color: _filled ? Colors.orange.shade400 : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(_verificateCode[index], style: TextStyle(fontSize: widget.size, color: Colors.orange.shade400)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
