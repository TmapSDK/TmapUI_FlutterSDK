package android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.utils

import android.app.Activity
import android.content.Context
import android.content.SharedPreferences
import androidx.core.content.edit
import com.google.gson.Gson
import com.tmapmobility.tmap.tmapsdk.ui.data.CarOption
import com.tmapmobility.tmap.tmapsdk.ui.data.MapSetting

object PreferenceUtils {
    private const val CAR_OPTION = "CAR_OPTION"
    private const val MAP_SETTING = "MAP_SETTING"
    private lateinit var preferences: SharedPreferences

    fun init(context: Context) {
        preferences = context.getSharedPreferences(context.packageName, Activity.MODE_PRIVATE)
    }

    var carOption: CarOption?
        get() = preferences.getString(CAR_OPTION, "")?.let {
            val gson = Gson()
            return gson.fromJson(it, CarOption::class.java)
        }
        set(value) = preferences.edit {
            val gson = Gson()
            putString(CAR_OPTION, gson.toJson(value))
        }

    var mapSetting: MapSetting?
        get() = preferences.getString(MAP_SETTING, "")?.let {
            val gson = Gson()
            return gson.fromJson(it, MapSetting::class.java)
        }
        set(value) = preferences.edit {
            val gson = Gson()
            putString(MAP_SETTING, gson.toJson(value))
        }
}
