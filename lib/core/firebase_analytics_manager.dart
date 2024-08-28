class FirebaseAnalyticsManager {
  static logScreen({required String screenName}) {
    // FirebaseAnalytics.instance.logEvent(
    //   name: 'screen_view',
    //   parameters: {'sceen_class': screenName},
    // );
  }

  static logScreenWithTag(
      {required String screenName, required String tagName}) {
    // FirebaseAnalytics.instance.logEvent(
    //   name: 'screen_view',
    //   parameters: {
    //     'sceen_class': screenName,
    //     'tag_filter': tagName,
    //   },
    // );
  }
}
