package com.example.looncher

import android.content.Context
import android.content.BroadcastReceiver

import android.app.AlarmManager

import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

class AlarmsChannel(context: Context, messenger: BinaryMessenger) {
		private val channel = MethodChannel(messenger, "com.hamedaadi.looncher/alarms")

		init {
				channel.setMethodCallHandler { call, result ->
						when (call.method) {
								"getAlarm" -> {
										val nextAlarm = getNextAlarmTime(context)
										result.success(nextAlarm)
								}
						}
				}
		}

		fun getNextAlarmTime(context: Context): Long? {
				val alarmManager =
						context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
				val nextAlarm = alarmManager.getNextAlarmClock()
				val triggerTime = nextAlarm.getTriggerTime()
				return triggerTime
		}
		
}
