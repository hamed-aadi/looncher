package com.example.looncher

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.app.AlarmManager

import android.os.Bundle
import androidx.annotation.NonNull

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import java.util.*

class MainActivity: FlutterActivity() {
		
		override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
				super.configureFlutterEngine(flutterEngine)
				/* apps */
				AppsChannel(this, flutterEngine.dartExecutor.binaryMessenger)

				/*
				 ACTION_POWER_CONNECTED
				 ACTION_POWER_DISCONNECTED
				 */
				
        val intentFilter = IntentFilter().apply {
            addAction(Intent.ACTION_PACKAGE_ADDED)
            addAction(Intent.ACTION_PACKAGE_REMOVED)
						addAction(Intent.ACTION_AIRPLANE_MODE_CHANGED)
						addAction("android.intent.action.NEXT_ALARM_CLOCK_CHANGED")
            addDataScheme("package")
        }
				
				registerReceiver(
						ChangeReceiver(flutterEngine.dartExecutor.binaryMessenger),
						intentFilter,
				)

				/* alarms */
				AlarmsChannel(this, flutterEngine.dartExecutor.binaryMessenger)

		}

		override fun onCreate(savedInstanceState: Bundle?) {
				super.onCreate(savedInstanceState)
		}

}
