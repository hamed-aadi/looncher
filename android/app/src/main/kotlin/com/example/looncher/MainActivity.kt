package com.example.looncher

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
		
		override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
				super.configureFlutterEngine(flutterEngine)
				
				AppsChannel(this, flutterEngine.dartExecutor.binaryMessenger)
		}
		
}
