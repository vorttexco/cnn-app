import 'package:cnn_brasil_app/core/extensions/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;

Map<String, String> cssBuilder(
    dom.Element element, Color primary, Color focus) {
  // Create an empty map to store the styles
  final Map<String, String> styles = {};

  if (element.localName == 'a') {
    styles.addAll({
      'color': focus.toHex(),
      'font-weight': '500',
      'text-decoration': 'underline',
      'text-decoration-color': focus.toHex(),
      'background-color': 'transparent',
    });
  }

  if (element.classes.contains('read-too__list')) {
    styles.addAll({
      'list-style': 'none',
      'list-style-type': 'none',
      'padding': '0',
      'margin': '0',
    });
  }
  if (element.classes.contains('read-too__link')) {
    styles.addAll({
      'display': 'flex',
      'text-decoration': 'none',
      'align-items': 'center',
      'gap': '16px'
          ''
    });
  }
  if (element.classes.contains('read-too__img')) {
    styles.addAll({
      'width': '90px',
      'height': '80px',
      'min-width': '90px',
      'min-height': '80px',
      'max-width': '90px',
      'max-height': '80px',
      'margin': '0 10px 0 0',
      'object-fit': 'cover',
      'display': 'inline-block',
    });
  }
  // if (element.classes.contains('read-too__picture')) {
  //   styles.addAll({

  //   });
  // }
  if (element.classes.contains('read-too__list-item')) {
    styles.addAll({
      'margin': '0 0 15px 0',
    });
  }
  if (element.classes.contains('read-too__post-title')) {
    styles.addAll({
      'font-size': '14px',
      'color': primary.toHex(),
      'font-style': 'normal',
      'margin': '0',
    });
  }
  if (element.classes.contains('read-too__title')) {
    styles.addAll({
      'color': focus.toHex(),
      'line-height': '18px',
      'font-size': '18px',
      'margin': '0 0 16px 0',
      'font-weight': '700'
    });
  }
  if (element.classes.contains('read-too')) {
    styles.addAll({
      'margin': '24px 0',
      'padding': '24px 0',
      'border-top': '1px solid ${primary.toHex()}',
      'border-bottom': '1px solid ${primary.toHex()}',
    });
  }

  return styles;
}
