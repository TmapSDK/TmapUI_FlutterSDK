package android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.model

import com.google.gson.Gson
import com.google.gson.annotations.SerializedName
import com.skt.tmap.engine.navigation.network.ndds.CarOilType
import com.skt.tmap.engine.navigation.network.ndds.TollCarType
import com.tmapmobility.tmap.tmapsdk.ui.data.CarOption
import com.tmapmobility.tmap.tmapsdk.ui.data.TruckInfoKey

data class CarOptionModel(
    @SerializedName("car_type") var car_type: String? = null,
    @SerializedName("truck_option") var truck_option: TruckOption? = null,
    @SerializedName("fuel_type") var fuel_type: String? = null,
    @SerializedName("show_traffic_accident") var show_traffic_accident: Boolean = false,
    @SerializedName("map_text_size") var map_text_size: String? = null,
    @SerializedName("night_mode") var night_mode: String? = null,
    @SerializedName("is_use_speed_react_map_scale") var is_use_speed_react_map_scale: Boolean = false,
    @SerializedName("is_show_traffic_in_route") var is_show_traffic_in_route: Boolean = false,
) {
    companion object {
        fun create(jsonString: String): CarOption {
            val gson = Gson()
            val data = gson.fromJson(jsonString, CarOptionModel::class.java)
            return CarOption().apply {
                carType = getCarType(data.car_type ?: "")
                oilType = getOilType(data.fuel_type ?: "")
                isHipassOn = data.show_traffic_accident
                truckInfo = data.truck_option?.let { getTruckInfo(it) }
            }
        }
    }
}

fun getCarType(type: String): TollCarType {
    return when (type) {
        "CT_NORMAL" -> TollCarType.Car
        "CT_MIDDLE" -> TollCarType.MediumVan
        "CT_LARGE" -> TollCarType.LargeVan
        "CT_TRUCK" -> TollCarType.LargeTruck
        "CT_SPECIAL" -> TollCarType.SpecialTruck
        "CT_COMPACT" -> TollCarType.SmallCar
        "CT_SMALL_TRUCK" -> TollCarType.SmallCar
        else -> TollCarType.TwoWheeledVehicle
    }
}

fun getOilType(type: String): CarOilType {
    return when (type) {
        "FT_GAS" -> CarOilType.Gasoline
        "FT_DIESEL" -> CarOilType.Diesel
        "FT_LPG" -> CarOilType.Lpg
        "FT_GASPM" -> CarOilType.PremiumGasoline
        "FT_EV" -> CarOilType.Electric
        else -> CarOilType.None
    }
}

fun getTruckInfo(option: TruckOption): HashMap<String, String> {
    val truckDetailInfo: HashMap<String, String> = HashMap()
    truckDetailInfo[TruckInfoKey.TruckType.value] = option.truck_type ?: ""
    truckDetailInfo[TruckInfoKey.TruckWeight.value] = "${option.truck_load_weight}"
    truckDetailInfo[TruckInfoKey.TruckHeight.value] = "${option.truck_height}"

    return truckDetailInfo
}

data class TruckOption(
    @SerializedName("truck_height") var truck_height: Int? = null,
    @SerializedName("truck_load_weight") var truck_load_weight: Int? = null,
    @SerializedName("truck_type") var truck_type: String? = null,
    @SerializedName("truck_width") var truck_width: Int? = null,
    @SerializedName("truck_length") var truck_length: Int? = null,
)
