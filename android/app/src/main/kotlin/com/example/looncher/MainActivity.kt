package com.example.looncher

import android.app.AlarmManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter

import android.os.Bundle
import androidx.annotation.NonNull

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivityLaunchConfigs.BackgroundMode.transparent

import java.util.*

class MainActivity: FlutterActivity() {
		
		override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
				super.configureFlutterEngine(flutterEngine)
				AppsChannel(this, flutterEngine.dartExecutor.binaryMessenger)
				
        val appIntentFilter = IntentFilter().apply {
            addAction("android.intent.action.PACKAGE_ADDED")
            addAction("android.intent.action.PACKAGE_FULLY_REMOVED")
						addDataScheme("package")
        }

				val genIntentFilter = IntentFilter().apply {
						addAction("android.app.action.NEXT_ALARM_CLOCK_CHANGED")
				}
				
				registerReceiver(
						AppChangeReceiver(flutterEngine.dartExecutor.binaryMessenger),
						appIntentFilter,
				)

				registerReceiver(
						GenChangeReceiver(flutterEngine.dartExecutor.binaryMessenger),
						genIntentFilter,
				)
				
				AlarmsChannel(this, flutterEngine.dartExecutor.binaryMessenger)

		}

		override fun onCreate(savedInstanceState: Bundle?) {
				intent.putExtra("background_mode", transparent.toString())
        super.onCreate(savedInstanceState)
    }

}
