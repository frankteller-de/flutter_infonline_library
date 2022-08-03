package com.hankfrinkle.flutter_infonline_library

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

import de.infonline.lib.IOLSession;
import de.infonline.lib.IOLSessionType;
import de.infonline.lib.IOLSessionPrivacySetting;
import de.infonline.lib.IOLEvent
import de.infonline.lib.IOLViewEvent

/** FlutterInfonlineLibraryPlugin */
class FlutterInfonlineLibraryPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context : Context
  private lateinit var activity : Activity

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {    
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_infonline_library")
    channel.setMethodCallHandler(this)
    this.context = flutterPluginBinding.applicationContext
  }
  
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "flutter_infonline_library")
      channel.setMethodCallHandler(FlutterInfonlineLibraryPlugin())
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
  override fun onDetachedFromActivity() {}
  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    onAttachedToActivity(binding)
  }
  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    this.activity = binding.activity
  }
  override fun onDetachedFromActivityForConfigChanges() {}

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "initIOLSession" -> {
        initIOLSession(
          call.argument<String>("sessionType").orEmpty(),
          call.argument<String>("type").orEmpty(),
          call.argument<Boolean>("debug") ?: false,
          call.argument<String>("offerIdentifier").orEmpty(),
          call.argument<String>("privacySetting").orEmpty()
        );
        result.success(true);
      }
      "logViewEvent" -> {
        logViewEvent(
          call.argument<String>("sessionType").orEmpty(),
          call.argument<String>("type").orEmpty(),
          call.argument<String>("category").orEmpty(),
          call.argument<String>("comment")
        );
        result.success(true);
      }
      "setCustomConsent" -> {
        setCustomConsent(
          call.argument<String>("sessionType").orEmpty(),
          call.argument<String>("consent").orEmpty()
        )
        result.success(true);
      }
      "setDebugModeEnabled" -> {
        setDebugModeEnabled(call.argument<Boolean>("enable") ?: false)
        result.success(true);
      }
      "sendLoggedEvents" -> {
        sendLoggedEvents(call.argument<String>("sessionType").orEmpty())
        result.success(true);
      }
      "terminateSession" -> {
        terminateSession(call.argument<String>("sessionType").orEmpty())
        result.success(true);
      }
      else -> {
        result.notImplemented();
      }
    }
  }

  // Flutter API methods

  private fun initIOLSession(sessionType: String, type: String, debug: Boolean, offerIdentifier: String, privacySetting: String) {
    defaultSession(sessionType)
      .initIOLSession(
        context, 
        offerIdentifier, 
        debug, 
        IOLSessionPrivacySetting.valueOf(privacySetting.uppercase())
      )
  }

  private fun logViewEvent(sessionType: String, type: String, category: String, comment: String?) {
    val enumType = IOLViewEvent.IOLViewEventType.valueOf(uppercase(type))
    val event = IOLViewEvent(enumType, category, comment)
    defaultSession(sessionType).logEvent(event)
  }

  private fun setCustomConsent(sessionType: String, consent: String) {
    defaultSession(sessionType).setCustomConsent(consent)
  }

  private fun sendLoggedEvents(sessionType: String) {
    defaultSession(sessionType).sendLoggedEvents();
  }

  private fun terminateSession(sessionType: String) {
    defaultSession(sessionType).terminateSession();
  }

  private fun setDebugModeEnabled(enable: Boolean) {
    IOLSession.setDebugModeEnabled(enable);
  }

  // Helper functions

  private fun sessionTypeToEnum(type: String) : IOLSessionType {
    return IOLSessionType.valueOf(type.uppercase())
  }

  private fun defaultSession(sessionType: String) : IOLSession {
    return IOLSession.getSessionForType(sessionTypeToEnum(sessionType))
  }

  private fun uppercase(value: String) : String {
    return value.replaceFirstChar { it.uppercase() }
  }
}