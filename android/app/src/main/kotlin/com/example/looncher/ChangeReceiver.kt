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

class ChangeReceiver(messenger: BinaryMessenger): BroadcastReceiver() {

		val methodChannel = MethodChannel(
				messenger,
				"com.hamedaadi.looncher/appchange",
		)
		
    override fun onReceive(context: Context, intent: Intent?) {
				val action = intent?.action
				val data = intent?.data
				val packageManager = context.packageManager
				when (action) {
						Intent.ACTION_PACKAGE_ADDED -> {
								methodChannel.invokeMethod(
										"onAppInstalled",
										mapApp(
												packageManager.getApplicationInfo(
														data!!.encodedSchemeSpecificPart,
														0
												),
												packageManager
										)
								)
						}
						Intent.ACTION_PACKAGE_REMOVED -> {
								methodChannel.invokeMethod(
										"onAppRemoved",
										data?.encodedSchemeSpecificPart,
								)
						}
						Intent.ACTION_AIRPLANE_MODE_CHANGED -> {
								methodChannel.invokeMethod(
										"airplane",
										null
								)
						}
						"android.intent.action.NEXT_ALARM_CLOCK_CHANGED" -> {
								methodChannel.invokeMethod(
										"alarmChange",
										null
								)
						}
						
				}
		}
}
