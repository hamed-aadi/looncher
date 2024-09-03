package com.example.looncher

import android.net.Uri

import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import java.io.ByteArrayOutputStream

import android.content.Context
import android.content.Intent
import android.content.pm.ApplicationInfo
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.content.Intent.FLAG_ACTIVITY_NEW_TASK
import android.provider.Settings.ACTION_APPLICATION_DETAILS_SETTINGS
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

fun mapApp(app: ApplicationInfo, packageManager: PackageManager): HashMap<String, Any?> {
		val map = HashMap<String, Any?>()
		map["name"] = packageManager.getApplicationLabel(app)
    map["package_name"] = app.packageName
		map["version"] = packageManager.getPackageInfo(app.packageName, 0).versionName
		map["category"] = app.category
		map["icon"] = drawableToByteArray(app.loadIcon(packageManager))
		return map
}


fun drawableToByteArray(drawable: Drawable): ByteArray {
    val bitmap = if (drawable is BitmapDrawable && drawable.bitmap != null) {
        drawable.bitmap
    } else {
        Bitmap.createBitmap(
            drawable.intrinsicWidth.takeIf { it > 0 } ?: 1,
            drawable.intrinsicHeight.takeIf { it > 0 } ?: 1,
            Bitmap.Config.ARGB_8888
        ).apply {
            val canvas = Canvas(this)
            drawable.setBounds(0, 0, canvas.width, canvas.height)
            drawable.draw(canvas)
        }
    }

    return ByteArrayOutputStream().use { stream ->
        bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream)
        stream.toByteArray()
    }
}

class AppsChannel(context: Context, messenger: BinaryMessenger) {
    private val channel = MethodChannel(messenger, "com.hamedaadi.looncher/apps")

    init {
        channel.setMethodCallHandler { call, result ->
						when (call.method) {
                "getApps" -> {
										val apps: List<Map<String, Any?>> = getApps(context)
                    result.success(apps)
                }
								"appFromPackage" -> {
										val packageName: String? = call.argument("package_name")
										val packageManager = context.packageManager
										val appInfo = packageManager.getApplicationInfo("$packageName", 0)
										val app = mapApp(appInfo, packageManager)
										result.success(app)
								}
								"openApp" -> {
										val packageName: String? = call.argument("package_name")
										openApp(packageName, context)
								}
								"uninstallApp" -> {
										val packageName: String? = call.argument("package_name")
										uninstallApp(packageName, context)
								}
								"openAppSettings" -> {
										val packageName: String? = call.argument("package_name")
										openAppSettings(packageName, context)
								}
                else -> result.notImplemented()
            }
        }
    }

		fun getApps(context: Context): List<Map<String, Any?>> {
				val packageManager = context.packageManager
				var installedApps = packageManager.getInstalledApplications(0)
				
				return installedApps.mapNotNull {
						if (packageManager.getLaunchIntentForPackage(it.packageName) == null) null;
						else mapApp(it, packageManager)
				}
		}

		fun openApp(packageName: String?, context: Context) {
				val launchIntent =
						context.packageManager.getLaunchIntentForPackage(packageName!!)
				context.startActivity(launchIntent)
		}
		
		fun uninstallApp(packageName: String?, context: Context) {
        val intent = Intent(Intent.ACTION_DELETE)
        intent.data = Uri.parse("package:$packageName")
        context.startActivity(intent)
    }

		fun openAppSettings(packageName: String?, context: Context) {
				val intent = Intent().apply {
            flags = FLAG_ACTIVITY_NEW_TASK
            action = ACTION_APPLICATION_DETAILS_SETTINGS
            data = Uri.fromParts("package", packageName, null)
        }
				context.startActivity(intent)
		}

}
