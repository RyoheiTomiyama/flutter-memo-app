// OverlayEntry内でDropdownがうまく動作しないバグがあるらしい
import 'package:flutter/material.dart';

class OverlayDropdown extends StatelessWidget {
  const OverlayDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return FocusApp();
  }
}

class FocusApp extends StatefulWidget {
  const FocusApp({super.key});

  @override
  State<FocusApp> createState() => _FocusAppState();
}

class _FocusAppState extends State<FocusApp> {
  final FocusScopeNode _mainFocusNode = FocusScopeNode();
  OverlayEntry? _toolbarOverlayEntry;
  String? _dropDownValue = "1";

  @override
  void initState() {
    super.initState();
    _mainFocusNode.requestFocus();
    _mainFocusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _mainFocusNode.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    setState(() {});
  }

  void _onTap() {
    _showToolbar();
  }

  void _showToolbar() {
    if (_toolbarOverlayEntry != null) {
      return;
    }

    _toolbarOverlayEntry = OverlayEntry(
      builder: (context) {
        // FocusScope with the new property.
        return FocusScope(
          node: _mainFocusNode,
          child: _buildToolbar(),
        );
      },
    );

    // final overlay = Overlay.of(context);

    // overlay?.insert(_toolbarOverlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Focus(
        focusNode: _mainFocusNode,
        child: Stack(
          children: [
            GestureDetector(
              onTap: _onTap,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Click here to show the overlay'),
                      SizedBox(height: 30),
                      Text('Is mainFocus focused: ${_mainFocusNode.hasFocus}'),
                    ],
                  ),
                ),
              ),
            ),
            _buildToolbar(),
          ],
        ),
      ),
    );
  }

  Widget _buildToolbar() {
    return Material(
      color: Colors.transparent,
      elevation: 5,
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: SizedBox(
              child: DropdownButton<String>(
                value: _dropDownValue,
                icon: const Icon(Icons.arrow_drop_down),
                onChanged: (value) {
                  setState(() {
                    _dropDownValue = value;
                  });
                },
                items: [
                  DropdownMenuItem<String>(
                    value: "1",
                    child: Text('Option 1'),
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Option 2'),
                    value: "2",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
