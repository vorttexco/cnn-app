class ApiAuth {
  static const auth = '/members/v1/auth';
}

class ApiHome {
  static const home = 'https://preprod.cnnbrasil.com.br';

//menus
  static const menuCopyright = '/menu/v1/items/menu-footer-copyright';
  static const menuHome = '/menu/v1/items/menu-header-cnn';
  static const menuProfile = '/menu/v1/items/menu-header-cnn';
}

class ApiStories {
  static const home = '/content/v1/web-stories';
}

class ApiBlogs {
  static const blogs = 'https://preprod.cnnbrasil.com.br/blogs/?hidemenu=true';
}

class ApiSections {
  static menu(String section) => '/menu/v1/internal/$section';
  static const menuSections = '/menu/v1/items/menu-header-cnn';
}

class ApiLiveStream {
  static playlist(String playlist) => '/youtube/v1/playlist/$playlist';
  static const onlive = '/tv/v1/schedule';
}
