import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MyToolbar extends HookWidget {
  MyToolbar({super.key, required this.editorFocus});

  final FocusNode editorFocus;

  @override
  Widget build(BuildContext context) {
    print('tool render');
    final offset = useState(const Offset(10, 50));
    return SizedBox.expand(
      child: Stack(
        children: [
          // Positioned(
          //   left: offset.value.dx,
          //   top: offset.value.dy,
          //   child: FractionalTranslation(
          //     translation: const Offset(-0.5, -1.4),
          //     child: SizedBox(),
          //   ),
          // ),
          Material(
            shape: const StadiumBorder(),
            elevation: 5,
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
              height: 40,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Only allow the user to select a new type of text node if
                  // the currently selected node can be converted.
                  // if (_isConvertibleNode()) ...[
                  //   Tooltip(
                  //     message: 'TextBlockType',
                  //     child: DropdownButton<_TextType>(
                  //       value: _getCurrentTextType(),
                  //       items: _TextType.values
                  //           .map((textType) => DropdownMenuItem<_TextType>(
                  //                 value: textType,
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.only(left: 16.0),
                  //                   child: Text(_getTextTypeName(textType)),
                  //                 ),
                  //               ))
                  //           .toList(),
                  //       icon: const Icon(Icons.arrow_drop_down),
                  //       style: const TextStyle(
                  //         color: Colors.black,
                  //         fontSize: 12,
                  //       ),
                  //       underline: const SizedBox(),
                  //       elevation: 0,
                  //       itemHeight: 48,
                  //       onChanged: _convertTextToNewType,
                  //     ),
                  //   ),
                  //   _buildVerticalDivider(),
                  // ],
                  Center(
                    child: IconButton(
                      onPressed: () {
                        editorFocus.requestFocus();
                      },
                      icon: const Icon(Icons.format_bold),
                      splashRadius: 16,
                      tooltip: 'Bold',
                    ),
                  ),
                  Center(
                    child: Text('editorFocus: ${editorFocus.hasFocus}'),
                  )
                  // Center(
                  //   child: IconButton(
                  //     onPressed: _toggleItalics,
                  //     icon: const Icon(Icons.format_italic),
                  //     splashRadius: 16,
                  //     tooltip: 'Italic',
                  //   ),
                  // ),
                  // Center(
                  //   child: IconButton(
                  //     onPressed: _toggleStrikethrough,
                  //     icon: const Icon(Icons.strikethrough_s),
                  //     splashRadius: 16,
                  //     tooltip: 'Strilethrough',
                  //   ),
                  // ),
                  // Center(
                  //   child: IconButton(
                  //     onPressed:
                  //         _areMultipleLinksSelected() ? null : _onLinkPressed,
                  //     icon: const Icon(Icons.link),
                  //     color: _isSingleLinkSelected()
                  //         ? const Color(0xFF007AFF)
                  //         : IconTheme.of(context).color,
                  //     splashRadius: 16,
                  //     tooltip: 'Link',
                  //   ),
                  // ),
                  // // Only display alignment controls if the currently selected text
                  // // node respects alignment. List items, for example, do not.
                  // if (_isTextAlignable()) ...[
                  //   _buildVerticalDivider(),
                  //   Tooltip(
                  //     message: 'Alignment',
                  //     child: DropdownButton<TextAlign>(
                  //       value: _getCurrentTextAlignment(),
                  //       items: [
                  //         TextAlign.left,
                  //         TextAlign.center,
                  //         TextAlign.right,
                  //         TextAlign.justify
                  //       ]
                  //           .map((textAlign) => DropdownMenuItem<TextAlign>(
                  //                 value: textAlign,
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.only(left: 8.0),
                  //                   child: Icon(_buildTextAlignIcon(textAlign)),
                  //                 ),
                  //               ))
                  //           .toList(),
                  //       icon: const Icon(Icons.arrow_drop_down),
                  //       style: const TextStyle(
                  //         color: Colors.black,
                  //         fontSize: 12,
                  //       ),
                  //       underline: const SizedBox(),
                  //       elevation: 0,
                  //       itemHeight: 48,
                  //       onChanged: _changeAlignment,
                  //     ),
                  //   ),
                  // ],
                  // _buildVerticalDivider(),
                  // Center(
                  //   child: IconButton(
                  //     onPressed: () {},
                  //     icon: const Icon(Icons.more_vert),
                  //     splashRadius: 16,
                  //     tooltip: 'More',
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
