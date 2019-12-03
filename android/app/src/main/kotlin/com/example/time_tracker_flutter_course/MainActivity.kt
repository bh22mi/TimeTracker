package com.example.time_tracker_flutter_course

import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.os.Bundle
import android.util.Base64
import android.util.Log

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import java.security.MessageDigest
import java.security.NoSuchAlgorithmException

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    try {
      val info = getPackageManager().getPackageInfo(
              "com.example.time_tracker_flutter_course",
              PackageManager.GET_SIGNATURES)
      for (signature in info.signatures) {
        val md: MessageDigest = MessageDigest.getInstance("SHA")
        md.update(signature.toByteArray())
        Log.d("KeyHash:", Base64.encodeToString(md.digest(), Base64.DEFAULT))
      }
    } catch (e: PackageManager.NameNotFoundException) {
    } catch (e: NoSuchAlgorithmException) {
    }
  }
}
