import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MyToolbar extends HookWidget {
  MyToolbar({super.key, required this.anchor, required this.editorFocus});

  final Offset? anchor;
  final FocusNode editorFocus;

  @override
  Widget build(BuildContext context) {
    final GlobalKey stackKey = useMemoized(() => GlobalKey());
    final GlobalKey toolbarKey = useMemoized(() => GlobalKey());
    final offsetPosition = useState(anchor ?? Offset.zero);
    // 画面からはみ出すときの補正
    final offsetToolbar = useState(Offset.zero);

    print('tool render');

    // Editorの選択位置=グローバル絶対位置 → Stackからの相対位置
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final renderBox =
            stackKey.currentContext?.findRenderObject() as RenderBox?;
        if (anchor != null && renderBox != null) {
          print(renderBox.globalToLocal(anchor!));
          offsetPosition.value = renderBox.globalToLocal(anchor!);
        } else {
          print('not found renderbox ${renderBox}');
        }
      });
    });

    // ToolbarのStackからの相対位置
    useEffect(() {
      final box = toolbarKey.currentContext?.findRenderObject() as RenderBox?;
      final stackBox =
          stackKey.currentContext?.findRenderObject() as RenderBox?;
      if (box == null || stackBox == null) {
        return;
      }
      final globalOffset = box.localToGlobal(Offset.zero, ancestor: stackBox);
      // print('globalOffset $globalOffset');
      final offset = stackBox.globalToLocal(globalOffset);
      final rect = offset & box.size;
      final stackRect = Offset.zero & stackBox.size;
      var offsetX = 0.0;
      var offsetY = 0.0;
      print('box $offset');
      if (rect.top >= 0 &&
          rect.left >= 0 &&
          rect.right <= stackRect.right &&
          rect.bottom <= stackRect.bottom) {
        offsetToolbar.value = Offset.zero;
        return;
      }
      if (rect.left < 0) {
        offsetX = -rect.left;
      }
      if (rect.right > stackRect.right) {
        offsetX = stackRect.right - rect.right;
      }
      if (rect.top < 0) {
        offsetY = -rect.top;
      }
      if (rect.bottom > stackRect.bottom) {
        offsetY = stackRect.bottom - rect.bottom;
      }
      print('box $offsetX $offsetY ${offsetToolbar.value}');

      offsetToolbar.value = Offset(offsetX, offsetY);
    }, [offsetPosition.value]);

    // useEffectより上に書くとうまく動作しない。。
    final offset = useMemoized(() {
      print('offset computed ${offsetPosition.value} ${offsetToolbar.value}');
      return offsetPosition.value.translate(
        offsetToolbar.value.dx,
        offsetToolbar.value.dy,
      );
    }, [offsetPosition.value, offsetToolbar.value]);

    return SizedBox.expand(
      child: Stack(
        key: stackKey,
        children: [
          Positioned(
            left: offset.dx,
            top: offset.dy,
            child: FractionalTranslation(
              translation: const Offset(-0.5, -1.5),
              child: Container(
                key: toolbarKey,
                child: Toolbar(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Toolbar extends HookWidget {
  const Toolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      // key: toolbarKey,
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
                  // editorFocus.requestFocus();
                },
                icon: const Icon(Icons.format_bold),
                splashRadius: 16,
                tooltip: 'Bold',
              ),
            ),
            const Center(
              child: Text('editorFocus hjogehogehog'),
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
    );
  }
}
