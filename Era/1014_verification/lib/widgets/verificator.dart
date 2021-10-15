import 'package:flutter/material.dart';

class Verificator extends StatefulWidget {
  const Verificator(
      {Key? key, required this.length, this.size = 28, required this.onCompleted, this.onEditing, this.spacing = 8.0})
      : super(key: key);

  final int length;
  final double size;
  final double spacing;
  final ValueChanged<String> onCompleted;
  final ValueChanged<String>? onEditing;

  @override
  _VerificatorState createState() => _VerificatorState();
}

class _VerificatorState extends State<Verificator> {
  final FocusNode _focusNode = FocusNode();
  String _codes = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.requestFocus();
      },
      child: Container(
        // color: Colors.amber[200],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                widget.length,
                (index) {
                  String code = _codes.length > index ? _codes[index] : '';
                  return Container(
                    width: widget.size * 1.3,
                    height: widget.size * 1.5,
                    margin: EdgeInsets.only(left: index > 0 ? widget.spacing : 0),
                    decoration: BoxDecoration(
                      // color: Colors.blue[400],
                      border: Border(
                        bottom: BorderSide(
                          color: _codes.length == index ? Colors.blue : Colors.grey,
                          width: _codes.length == index ? 2.0 : 1.0,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        code,
                        style: TextStyle(fontSize: widget.size, color: Colors.black87),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              // width: widget.size * widget.length + widget.spacing * (widget.length - 1),
              width: 0,
              height: 0,
              child: TextField(
                focusNode: _focusNode,
                maxLength: widget.length,
                onChanged: (String value) {
                  setState(() {
                    _codes = value;
                  });
                  if (_codes.length == widget.length) {
                    _focusNode.unfocus();
                    widget.onCompleted(_codes);
                  } else {
                    if (widget.onEditing != null) widget.onEditing!(_codes);
                  }
                },
                decoration: InputDecoration(
                  counterText: '',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
