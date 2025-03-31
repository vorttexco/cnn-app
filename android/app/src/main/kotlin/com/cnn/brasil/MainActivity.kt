package com.cnn.brasil

import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import br.com.hands.mdm.libs.android.bundle.MDMBundle
import br.com.hands.mdm.libs.android.core.MDMCore
import br.com.hands.mdm.libs.android.core.OnStartListener

class MainActivity: FlutterActivity() {
   override fun onCreate(savedInstanceState: Bundle?) {
      super.onCreate(savedInstanceState)

      MDMCore.setDebugMode(true);
      
      val appId = "jmDLWQt0JAVA1iqY6J8MXRAoDY6wWQW1Wph1G3xV/AgrmkEaAiix3FLEk80xUI89BOh9FxFLqvyzR2ITK5zpN8kBhl5eHOTTFbGr+FaZwFEt0TFYMXbfXQnUwWQubpdwFAyQUA4Xjwz0J/4IP2R7si9cm+IporvUVRSyK2brIsBCBCsiOrJPw/FBcv69wmDBe2OxD9sN/VdjUL8eEk8EpIxg8obeF5Hqy5/0qEKCIhlN/TF9HTT1ugAvUUIYTn4YzcmcsrKQML0SaEv90OjH0CxSD6KI46LUM87ijd5ZLYadlzwzeeZ6lB4N4HPHbsQSa2exZ6Jrp0tZsWuWFS6J4Q=="

      MDMCore.start(applicationContext, appId, object : OnStartListener {
          override fun onStart() {
              MDMBundle.start(applicationContext, object : OnStartListener {
                  override fun onStart() {
                      // MDM inicializado
                  }
              })
          }
      })
  }

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
      super.configureFlutterEngine(flutterEngine)
  }
}
