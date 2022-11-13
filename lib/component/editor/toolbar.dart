import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:memo_app/domain/enum/editor/editor_entity.dart';
import 'package:super_editor/super_editor.dart';

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

  // 選択範囲のテキストスタイルSpan取得
  Set<AttributionSpan> getSelectedAttributedSpans(
    DocumentNode selectedNode, {
    List<Type>? filterAttributions,
  }) {
    if (selection.base.nodePosition is! TextPosition ||
        selection.extent.nodePosition is! TextPosition) {
      return <AttributionSpan>{};
    }
    final baseOffset = (selection.base.nodePosition as TextPosition).offset;
    final extentOffset = (selection.extent.nodePosition as TextPosition).offset;
    final selectionStart = min(baseOffset, extentOffset);
    final selectionEnd = max(baseOffset, extentOffset);
    final selectionRange = SpanRange(
      start: selectionStart,
      end: selectionEnd - 1,
    );

    if (selectedNode is TextNode) {
      final text = selectedNode.text;

      final attributedSpans = text.getAttributionSpansInRange(
        // attributionFilter: (_) => true,
        attributionFilter: (Attribution attribution) {
          if (filterAttributions != null) {
            return filterAttributions.contains(attribution.runtimeType);
          }
          return true;
        },
        range: selectionRange,
      );
      // print(attributedSpans);
      return attributedSpans;
    }
    return <AttributionSpan>{};
  }

  // 選択範囲のスタイル確認
  bool isSelectedNamedAttrbution(DocumentNode? node, NodeStyle type) {
    if (node == null) {
      return false;
    }
    final spans = getSelectedAttributedSpans(node);
    return spans.any((span) => span.attribution == type.attribution);
  }

  Widget buildVerticalDivider() {
    return Container(
      width: 1,
      color: Colors.grey.shade300,
    );
  }

  Widget buildNodeStyleButton({
    required void Function()? onPressed,
    required BuildContext context,
    required NodeStyle nodeStyle,
    DocumentNode? selectedNode,
  }) {
    final setButtonColor = useCallback((bool active) {
      return active
          ? Theme.of(context).primaryColor
          : IconTheme.of(context).color;
    }, []);

    return Center(
      child: IconButton(
        onPressed: onPressed,
        color: setButtonColor(
          isSelectedNamedAttrbution(selectedNode, nodeStyle),
        ),
        icon: Icon(nodeStyle.icon),
        splashRadius: 16,
        tooltip: nodeStyle.label,
      ),
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
            buildNodeStyleButton(
              context: context,
              nodeStyle: NodeStyle.bold,
              onPressed: () => toggleStyle(NodeStyle.bold.attribution),
              selectedNode: selectedNode.value,
            ),
            buildNodeStyleButton(
              context: context,
              nodeStyle: NodeStyle.italic,
              onPressed: () => toggleStyle(NodeStyle.italic.attribution),
              selectedNode: selectedNode.value,
            ),
            buildNodeStyleButton(
              context: context,
              nodeStyle: NodeStyle.underline,
              onPressed: () => toggleStyle(NodeStyle.underline.attribution),
              selectedNode: selectedNode.value,
            ),
            buildNodeStyleButton(
              context: context,
              nodeStyle: NodeStyle.strike,
              onPressed: () => toggleStyle(NodeStyle.strike.attribution),
              selectedNode: selectedNode.value,
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
