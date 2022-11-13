import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:super_editor/super_editor.dart';

enum NodeTextType {
  header1,
  header2,
  header3,
  paragraph,
  blockquote,
}

extension NodeTextTypeExt on NodeTextType {
  String get label {
    switch (this) {
      case NodeTextType.header1:
        return 'Header1';
      case NodeTextType.header2:
        return 'Header2';
      case NodeTextType.header3:
        return 'Header3';
      case NodeTextType.paragraph:
        return 'Text';
      case NodeTextType.blockquote:
        return 'Quote';
    }
  }

  NamedAttribution get attribution {
    switch (this) {
      case NodeTextType.header1:
        return header1Attribution;
      case NodeTextType.header2:
        return header2Attribution;
      case NodeTextType.header3:
        return header3Attribution;
      // case NodeTextType.paragraph:
      //   return paragraph;
      case NodeTextType.blockquote:
        return blockquoteAttribution;
      case NodeTextType.paragraph:
        return const NamedAttribution('paragraph');
    }
  }

  findByAttribution() {}
}

enum NodeListType {
  orderedListItem,
  unorderedListItem,
}

extension NodeListTypeExt on NodeListType {
  String get label {
    switch (this) {
      case NodeListType.orderedListItem:
        return 'Numbered List';
      case NodeListType.unorderedListItem:
        return 'Bulleted List';
    }
  }
}

enum NodeStyle {
  bold,
  italic,
  underline,
  strike,
}

extension NodeStyleExt on NodeStyle {
  String get label {
    switch (this) {
      case NodeStyle.bold:
        return 'Bold';
      case NodeStyle.italic:
        return 'Italic';
      case NodeStyle.underline:
        return 'Underline';
      case NodeStyle.strike:
        return 'Strike Through';
    }
  }

  IconData get icon {
    switch (this) {
      case NodeStyle.bold:
        return Icons.format_bold;
      case NodeStyle.italic:
        return Icons.format_italic;
      case NodeStyle.underline:
        return Icons.format_underline;
      case NodeStyle.strike:
        return Icons.format_strikethrough;
    }
  }

  NamedAttribution get attribution {
    switch (this) {
      case NodeStyle.bold:
        return boldAttribution;
      case NodeStyle.italic:
        return italicsAttribution;
      case NodeStyle.underline:
        return underlineAttribution;
      case NodeStyle.strike:
        return strikethroughAttribution;
    }
  }
}

const convertibleNodes = [
  ParagraphNode,
  ListItemNode,
];

class Toolbar extends HookWidget {
  const Toolbar({
    super.key,
    required this.editor,
    required this.editorFocus,
    required this.selection,
    required this.composer,
  });

  final DocumentEditor editor;
  final FocusNode editorFocus;
  final DocumentSelection selection;
  final DocumentComposer composer;

  DocumentNode? getSelectedNode(DocumentEditor editor) {
    final node = editor.document.getNodeById(selection.extent.nodeId);
    // print('selectedNode ${node?.getMetadataValue('blockType')}');
    return node;
  }

  NamedAttribution? getSelectedBlockType(DocumentEditor editor) {
    final node = editor.document.getNodeById(selection.extent.nodeId);
    // print('getSelectedNodeType ${node?.getMetadataValue('blockType')}');
    return node?.getMetadataValue('blockType');
  }

  dynamic getSelectedNodeType(DocumentNode? node) {
    if (node == null) {
      return null;
    }
    if (node is ParagraphNode) {
      // NamedAttribution
      final type = getSelectedBlockType(editor);

      return NodeTextType.values.firstWhere(
        (element) => element.attribution == type,
        orElse: () => NodeTextType.paragraph,
      );
    } else if (node is ListItemNode) {
      return node.type == ListItemType.ordered
          ? NodeListType.orderedListItem
          : NodeListType.unorderedListItem;
    } else {
      throw Exception('Invalid node type: $node');
    }
  }

  Widget buildVerticalDivider() {
    return Container(
      width: 1,
      color: Colors.grey.shade300,
    );
  }

  @override
  Widget build(BuildContext context) {
    // print('render toolbar');
    final selectedNode = useState(getSelectedNode(editor));
    final selectedNodeBlockType =
        useState<NamedAttribution?>(getSelectedBlockType(editor));
    final isConvertibleNode = useMemoized(() {
      if (selection.base.nodeId != selection.extent.nodeId) {
        return false;
      }
      return convertibleNodes.contains(selectedNode.value.runtimeType);
    }, [selectedNode.value]);

    // Bold, Italic, etc スタイル適用
    final toggleStyle = useCallback((NamedAttribution attribution) {
      editor.executeCommand(ToggleTextAttributionsCommand(
          attributions: {attribution}, documentSelection: selection));
    }, [editor, selection]);

    // Heading, paragraph, quote ブロック適用
    final setTextType = useCallback((NamedAttribution attribution) {
      if (selectedNode.value is ParagraphNode) {
        selectedNode.value!.putMetadataValue('blockType', attribution);
        // composer.selection = selection;
        editorFocus.requestFocus();
      }
    }, [editor, selection]);

    // Mutableな値のせいでHooksがうまく作用しないため
    final updateData = useCallback(() {
      selectedNode.value = getSelectedNode(editor);
      selectedNodeBlockType.value = getSelectedBlockType(editor);
    }, [editor]);
    useEffect(() {
      editor.document.addListener(updateData);
      return () {
        editor.document.removeListener(updateData);
      };
    }, [editor.document]);

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
            if (isConvertibleNode) ...[
              Tooltip(
                message: 'Turn Into',
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: DropdownButton<NodeTextType>(
                    value:
                        getSelectedNodeType(selectedNode.value) is NodeTextType
                            ? getSelectedNodeType(selectedNode.value)
                            : NodeTextType.paragraph,
                    items: NodeTextType.values
                        .map((textType) => DropdownMenuItem<NodeTextType>(
                              value: textType,
                              child: Text(textType.label),
                            ))
                        .toList(),
                    icon: const Icon(Icons.arrow_drop_down),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),

                    underline: const SizedBox(),
                    // elevation: 8,
                    // itemHeight: 48,
                    onChanged: (textType) {
                      if (textType != null) {
                        setTextType(textType.attribution);
                      }
                    },
                  ),
                ),
              ),
              buildVerticalDivider(),
            ],
            Center(
              child: IconButton(
                onPressed: () {
                  toggleStyle(NodeStyle.bold.attribution);
                  // editorFocus.requestFocus();
                },
                icon: Icon(NodeStyle.bold.icon),
                splashRadius: 16,
                tooltip: NodeStyle.bold.label,
              ),
            ),
            Center(
              child: IconButton(
                onPressed: () {
                  toggleStyle(NodeStyle.italic.attribution);
                  // editorFocus.requestFocus();
                },
                icon: Icon(NodeStyle.italic.icon),
                splashRadius: 16,
                tooltip: NodeStyle.italic.label,
              ),
            ),
            Center(
              child: IconButton(
                onPressed: () {
                  toggleStyle(NodeStyle.underline.attribution);
                  // editorFocus.requestFocus();
                },
                icon: Icon(NodeStyle.underline.icon),
                splashRadius: 16,
                tooltip: NodeStyle.underline.label,
              ),
            ),
            Center(
              child: IconButton(
                onPressed: () {
                  toggleStyle(NodeStyle.strike.attribution);
                  // editorFocus.requestFocus();
                },
                icon: Icon(NodeStyle.strike.icon),
                splashRadius: 16,
                tooltip: NodeStyle.strike.label,
              ),
            ),
            // Center(
            //   child: IconButton(
            //     onPressed: _areMultipleLinksSelected() ? null : _onLinkPressed,
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
            //       style: const NodeStyle(
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
