import 'package:flutter/material.dart';
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
        return 'Heading1';
      case NodeTextType.header2:
        return 'Heading2';
      case NodeTextType.header3:
        return 'Heading3';
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
