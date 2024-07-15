import 'package:cnn_brasil_app/core/index.dart';
import 'package:cnn_brasil_app/core/models/wrapper_stories.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
      'Should be return object with one item, category.name eq Saúde and 2 stories item ...',
      () {
    const jsonString = [
      {
        "id": 294667,
        "title":
            "O que é “vampiro facial”, procedimento estético que causou infecção por HIV",
        "thumbnail":
            "https://stories.cnnbrasil.com.br/wp-content/uploads/sites/9/2024/05/vampiro-facial.png",
        "excerpt":
            "O procedimento estético é seguro quando realizado de forma adequada, mas há risco de infecções quando as agulhas são reutilizadas",
        "permalink":
            "https://stories.cnnbrasil.com.br/saude/se-nao-devemos-comer-alimentos-ultraprocessados-o-que-devemos-comer-copy/",
        "category": {
          "id": 1,
          "name": "Saúde",
          "slug": "saude",
          "hierarchy": ["saude"]
        }
      },
      {
        "id": 294667,
        "title":
            "O que é “vampiro facial”, procedimento estético que causou infecção por HIV",
        "thumbnail":
            "https://stories.cnnbrasil.com.br/wp-content/uploads/sites/9/2024/05/vampiro-facial.png",
        "excerpt":
            "O procedimento estético é seguro quando realizado de forma adequada, mas há risco de infecções quando as agulhas são reutilizadas",
        "permalink":
            "https://stories.cnnbrasil.com.br/saude/se-nao-devemos-comer-alimentos-ultraprocessados-o-que-devemos-comer-copy/",
        "category": {
          "id": 1,
          "name": "Saúde",
          "slug": "saude",
          "hierarchy": ["saude"]
        }
      }
    ];

    final stories = jsonString.map((e) => StorieModel.fromJson(e)).toList();

    final transformData = WrapperStories.toView(stories);

    expect(transformData.length, 1);
    expect(transformData[0].stories.length, 2);
    expect(transformData.first.category, 'Saúde');
  });

  test(
      'Should be return object with 2 item,s category.name eq Saúde and Pop, and 2 stories to Saúde and 1 storie to Pop ...',
      () {
    const jsonString = [
      {
        "id": 294667,
        "title":
            "O que é “vampiro facial”, procedimento estético que causou infecção por HIV",
        "thumbnail":
            "https://stories.cnnbrasil.com.br/wp-content/uploads/sites/9/2024/05/vampiro-facial.png",
        "excerpt":
            "O procedimento estético é seguro quando realizado de forma adequada, mas há risco de infecções quando as agulhas são reutilizadas",
        "permalink":
            "https://stories.cnnbrasil.com.br/saude/se-nao-devemos-comer-alimentos-ultraprocessados-o-que-devemos-comer-copy/",
        "category": {
          "id": 1,
          "name": "Saúde",
          "slug": "saude",
          "hierarchy": ["saude"]
        }
      },
      {
        "id": 294667,
        "title":
            "O que é “vampiro facial”, procedimento estético que causou infecção por HIV",
        "thumbnail":
            "https://stories.cnnbrasil.com.br/wp-content/uploads/sites/9/2024/05/vampiro-facial.png",
        "excerpt":
            "O procedimento estético é seguro quando realizado de forma adequada, mas há risco de infecções quando as agulhas são reutilizadas",
        "permalink":
            "https://stories.cnnbrasil.com.br/saude/se-nao-devemos-comer-alimentos-ultraprocessados-o-que-devemos-comer-copy/",
        "category": {
          "id": 1,
          "name": "Saúde",
          "slug": "saude",
          "hierarchy": ["saude"]
        }
      },
      {
        "id": 2946467,
        "title": "Pop",
        "thumbnail":
            "https://stories.cnnbrasil.com.br/wp-content/uploads/sites/9/2024/05/vampiro-facial.png",
        "excerpt":
            "O procedimento estético é seguro quando realizado de forma adequada, mas há risco de infecções quando as agulhas são reutilizadas",
        "permalink":
            "https://stories.cnnbrasil.com.br/saude/se-nao-devemos-comer-alimentos-ultraprocessados-o-que-devemos-comer-copy/",
        "category": {
          "id": 2,
          "name": "Pop",
          "slug": "pop",
          "hierarchy": ["saude"]
        }
      }
    ];

    final stories = jsonString.map((e) => StorieModel.fromJson(e)).toList();

    final transformData = WrapperStories.toView(stories);

    expect(transformData.length, 2);
    expect(transformData.first.category, 'Saúde');
    expect(transformData.last.category, 'Pop');
    expect(transformData.first.stories.length, 2);
    expect(transformData.last.stories.length, 1);
  });
}
