package com.example.looncher

import android.app.AlarmManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.pm.ApplicationInfo
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.BinaryMessenger

class AppChangeReceiver(messenger: BinaryMessenger): BroadcastReceiver() {

		private val methodChannel = MethodChannel(
				messenger,
				"com.hamedaadi.looncher/appReceivers",
		)
		
    override fun onReceive(context: Context, intent: Intent?) {
				val action = intent?.action
				val data = intent?.data
				val packageManager = context.packageManager
				
				when (action) {
						"android.intent.action.PACKAGE_ADDED" -> {
								if (data != null) {
										val packageName = data.encodedSchemeSpecificPart
										val appInfo = packageManager.getApplicationInfo(packageName, 0)
										val appMap = mapApp(appInfo, packageManager)
										methodChannel.invokeMethod("onAppAdded", appMap)
								} else {
										println("fuck [33]")
								}
						}
						"android.intent.action.PACKAGE_FULLY_REMOVED" -> {
								methodChannel.invokeMethod(
										"onAppRemoved", data?.encodedSchemeSpecificPart,
								)
						}
				}
		}
}

class GenChangeReceiver(messenger: BinaryMessenger): BroadcastReceiver() {
		private val methodChannel = MethodChannel(
				messenger,
				"com.hamedaadi.looncher/genReceivers",
		)
		
		override fun onReceive(context: Context, intent: Intent?) {
				// val action = intent?.action
				// when (action) {}
				methodChannel.invokeMethod("alarmChange", null)
		}
}
