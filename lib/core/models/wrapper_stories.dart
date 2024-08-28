import 'package:flutter/material.dart';

import '../index.dart';

class StorieViewModel {
  final String category;
  final Color color;
  final List<StorieModel> stories;

  StorieViewModel(
      {required this.category, required this.stories, required this.color});
}

class WrapperStories {
  static List<StorieViewModel> toView(List<StorieModel> list) {
    List<Category> tempCategories = [];

    for (var storie in list) {
      if (tempCategories.isEmpty) {
        tempCategories.add(storie.category ?? Category());
      } else {
        final exists = tempCategories
            .where((element) => element.id == storie.category?.id)
            .isNotEmpty;
        if (!exists) {
          tempCategories.add(storie.category ?? Category());
        }
      }
    }

    List<StorieViewModel> storieViewModelList = [];
    for (var category in tempCategories) {
      List<StorieModel> tempStories = [];
      for (var storie in list) {
        if (storie.category?.id == category.id) {
          tempStories.add(storie);
        }
      }
      storieViewModelList.add(
        StorieViewModel(
            category: category.name ?? '',
            stories: tempStories,
            color: HexColor.fromHex(category.color ?? 'CC0000')),
      );
    }
    return storieViewModelList;
  }
}
