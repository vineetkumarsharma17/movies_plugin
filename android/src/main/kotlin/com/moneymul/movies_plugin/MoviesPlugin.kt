package com.moneymul.movies_plugin

import android.os.AsyncTask
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.BufferedReader
import java.io.IOException
import java.io.InputStreamReader
import java.net.HttpURLConnection
import java.net.URL


/** MoviesPlugin */
class MoviesPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "movies_plugin")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else  if (call.method == "searchMovies") {
    //  String name=call.arguments();
     var title = call.arguments() as? String;
     val url = "http://www.omdbapi.com/?t=$title&apikey=bb307c48"
     MakeHttpRequestTask(result).execute(url)
    }
    else{
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}

private class MakeHttpRequestTask(private val result: MethodChannel.Result) :
AsyncTask<String, Void, String?>() {

override fun doInBackground(vararg params: String): String? {
    val url = params[0]
    return try {
        makeHttpRequest(url)
    } catch (e: IOException) {
        // Handle exceptions
        e.printStackTrace()
        null
    }
}

override fun onPostExecute(response: String?) {
    if (response != null) {

        result.success(response)
    } else {
        result.error("HTTP_REQUEST_ERROR", "Failed to make HTTP request", null)
    }
}

private fun makeHttpRequest(url: String): String {
    val connection: HttpURLConnection = URL(url).openConnection() as HttpURLConnection

    try {
        // Set request method
        connection.requestMethod = "GET"

        // Read the response
        val reader = BufferedReader(InputStreamReader(connection.inputStream))
        val response = StringBuilder()
        var line: String?

        while (reader.readLine().also { line = it } != null) {
            response.append(line)
        }

        reader.close()

        return response.toString()
    } finally {
        // Disconnect to free up resources
        connection.disconnect()
    }
}
}

