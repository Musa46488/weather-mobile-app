class WeatherData {
  final Location location;
  final Current current;
  final Forecast forecast;

  WeatherData({
    required this.location,
    required this.current,
    required this.forecast,
  });

  factory WeatherData.fromJson(dynamic json) {
    if (json == null || json is! Map<String, dynamic>) {
      return WeatherData(
        location: Location.empty(),
        current: Current.empty(),
        forecast: Forecast(forecastday: []),
      );
    }
    return WeatherData(
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
      forecast: Forecast.fromJson(json['forecast']),
    );
  }
}

class Location {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String tzId;
  final int localtimeEpoch;
  final String localtime;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtimeEpoch,
    required this.localtime,
  });

  factory Location.fromJson(dynamic json) {
    if (json == null || json is! Map<String, dynamic>) {
      return Location.empty();
    }
    return Location(
      name: _toString(json['name']),
      region: _toString(json['region']),
      country: _toString(json['country']),
      lat: _toDouble(json['lat']),
      lon: _toDouble(json['lon']),
      tzId: _toString(json['tz_id']),
      localtimeEpoch: _toInt(json['localtime_epoch']),
      localtime: _toString(json['localtime']),
    );
  }

  factory Location.empty() => Location(
    name: '',
    region: '',
    country: '',
    lat: 0,
    lon: 0,
    tzId: '',
    localtimeEpoch: 0,
    localtime: '',
  );
}

class Current {
  final int lastUpdatedEpoch;
  final String lastUpdated;
  final double tempC;
  final bool isDay;
  final Condition condition;
  final double windKph;
  final String windDir;
  final double pressureMb;
  final double humidity;
  final double cloud;
  final double feelslikeC;
  final double uv;
  final AirQuality airQuality;

  Current({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.isDay,
    required this.condition,
    required this.windKph,
    required this.windDir,
    required this.pressureMb,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.uv,
    required this.airQuality,
  });

  factory Current.fromJson(dynamic json) {
    if (json == null || json is! Map<String, dynamic>) {
      return Current.empty();
    }
    return Current(
      lastUpdatedEpoch: _toInt(json['last_updated_epoch']),
      lastUpdated: _toString(json['last_updated']),
      tempC: _toDouble(json['temp_c']),
      isDay: _toInt(json['is_day']) == 1,
      condition: Condition.fromJson(json['condition']),
      windKph: _toDouble(json['wind_kph']),
      windDir: _toString(json['wind_dir']),
      pressureMb: _toDouble(json['pressure_mb']),
      humidity: _toDouble(json['humidity']),
      cloud: _toDouble(json['cloud']),
      feelslikeC: _toDouble(json['feelslike_c']),
      uv: _toDouble(json['uv']),
      airQuality: AirQuality.fromJson(json['air_quality']),
    );
  }

  factory Current.empty() => Current(
    lastUpdatedEpoch: 0,
    lastUpdated: '',
    tempC: 0,
    isDay: false,
    condition: Condition.empty(),
    windKph: 0,
    windDir: '',
    pressureMb: 0,
    humidity: 0,
    cloud: 0,
    feelslikeC: 0,
    uv: 0,
    airQuality: AirQuality.empty(),
  );
}

class Forecast {
  final List<ForecastDay> forecastday;

  Forecast({required this.forecastday});

  factory Forecast.fromJson(dynamic json) {
    if (json == null || json is! Map<String, dynamic>) {
      return Forecast(forecastday: []);
    }
    final list = json['forecastday'];
    if (list == null || list is! List) {
      return Forecast(forecastday: []);
    }
    return Forecast(
      forecastday: List<ForecastDay>.from(
        list.map((e) => ForecastDay.fromJson(e)),
      ),
    );
  }
}

class ForecastDay {
  final String date;
  final int dateEpoch;
  final Day day;
  final Astro astro;
  final List<Hour> hour;

  ForecastDay({
    required this.date,
    required this.dateEpoch,
    required this.day,
    required this.astro,
    required this.hour,
  });

  factory ForecastDay.fromJson(dynamic json) {
    if (json == null || json is! Map<String, dynamic>) {
      return ForecastDay(
        date: '',
        dateEpoch: 0,
        day: Day.empty(),
        astro: Astro.empty(),
        hour: [],
      );
    }
    final hourList = json['hour'];
    return ForecastDay(
      date: _toString(json['date']),
      dateEpoch: _toInt(json['date_epoch']),
      day: Day.fromJson(json['day']),
      astro: Astro.fromJson(json['astro']),
      hour: (hourList is List)
          ? List<Hour>.from(hourList.map((e) => Hour.fromJson(e)))
          : <Hour>[],
    );
  }
}

class Day {
  final double maxtempC;
  final double mintempC;
  final double avgtempC;
  final double maxwindKph;
  final double totalprecipMm;
  final double avghumidity;
  final Condition condition;
  final double uv;
  final AirQuality airQuality;
  final int dailyWillItRain;
  final int dailyChanceOfRain;
  final int dailyWillItSnow;
  final int dailyChanceOfSnow;
  final double avgvisKm;

  Day({
    required this.maxtempC,
    required this.mintempC,
    required this.avgtempC,
    required this.maxwindKph,
    required this.totalprecipMm,
    required this.avghumidity,
    required this.condition,
    required this.uv,
    required this.airQuality,
    required this.dailyWillItRain,
    required this.dailyChanceOfRain,
    required this.dailyWillItSnow,
    required this.dailyChanceOfSnow,
    required this.avgvisKm,
  });

  factory Day.fromJson(dynamic json) {
    if (json == null || json is! Map<String, dynamic>) {
      return Day.empty();
    }
    return Day(
      maxtempC: _toDouble(json['maxtemp_c']),
      mintempC: _toDouble(json['mintemp_c']),
      avgtempC: _toDouble(json['avgtemp_c']),
      maxwindKph: _toDouble(json['maxwind_kph']),
      totalprecipMm: _toDouble(json['totalprecip_mm']),
      avghumidity: _toDouble(json['avghumidity']),
      condition: Condition.fromJson(json['condition']),
      uv: _toDouble(json['uv']),
      airQuality: AirQuality.fromJson(json['air_quality']),
      dailyWillItRain: _toInt(json['daily_will_it_rain']),
      dailyChanceOfRain: _toInt(json['daily_chance_of_rain']),
      dailyWillItSnow: _toInt(json['daily_will_it_snow']),
      dailyChanceOfSnow: _toInt(json['daily_chance_of_snow']),
      avgvisKm: _toDouble(
        json['avgvis_km'] ?? json['avgvis_km'] ?? json['avgvis_km'],
      ),
    );
  }

  factory Day.empty() => Day(
    maxtempC: 0,
    mintempC: 0,
    avgtempC: 0,
    maxwindKph: 0,
    totalprecipMm: 0,
    avghumidity: 0,
    condition: Condition.empty(),
    uv: 0,
    airQuality: AirQuality.empty(),
    dailyWillItRain: 0,
    dailyChanceOfRain: 0,
    dailyWillItSnow: 0,
    dailyChanceOfSnow: 0,
    avgvisKm: 0,
  );
}

class Hour {
  final String time;
  final double tempC;
  final bool isDay;
  final Condition condition;
  final double windKph;
  final double pressureMb;
  final double humidity;
  final double cloud;
  final double feelslikeC;
  final double uv;
  final AirQuality airQuality;
  final int chanceOfRain;
  final int willItRain;
  final int willItSnow;
  final int chanceOfSnow;
  final double visKm;

  Hour({
    required this.time,
    required this.tempC,
    required this.isDay,
    required this.condition,
    required this.windKph,
    required this.pressureMb,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.uv,
    required this.airQuality,
    required this.chanceOfRain,
    required this.willItRain,
    required this.willItSnow,
    required this.chanceOfSnow,
    required this.visKm,
  });

  factory Hour.fromJson(dynamic json) {
    if (json == null || json is! Map<String, dynamic>) {
      return Hour.empty();
    }
    return Hour(
      time: _toString(json['time']),
      tempC: _toDouble(json['temp_c']),
      isDay: _toInt(json['is_day']) == 1,
      condition: Condition.fromJson(json['condition']),
      windKph: _toDouble(json['wind_kph']),
      pressureMb: _toDouble(json['pressure_mb']),
      humidity: _toDouble(json['humidity']),
      cloud: _toDouble(json['cloud']),
      feelslikeC: _toDouble(json['feelslike_c']),
      uv: _toDouble(json['uv']),
      airQuality: AirQuality.fromJson(json['air_quality']),
      chanceOfRain: _toInt(
        json['chance_of_rain'] ?? json['chance_of_rain_pct'],
      ),
      willItRain: _toInt(json['will_it_rain']),
      willItSnow: _toInt(json['will_it_snow']),
      chanceOfSnow: _toInt(json['chance_of_snow']),
      visKm: _toDouble(json['vis_km']),
    );
  }

  factory Hour.empty() => Hour(
    time: '',
    tempC: 0,
    isDay: false,
    condition: Condition.empty(),
    windKph: 0,
    pressureMb: 0,
    humidity: 0,
    cloud: 0,
    feelslikeC: 0,
    uv: 0,
    airQuality: AirQuality.empty(),
    chanceOfRain: 0,
    willItRain: 0,
    willItSnow: 0,
    chanceOfSnow: 0,
    visKm: 0,
  );
}

class Condition {
  final String text;
  final String icon;
  final int code;

  Condition({required this.text, required this.icon, required this.code});

  factory Condition.fromJson(dynamic json) {
    if (json == null || json is! Map<String, dynamic>) {
      return Condition.empty();
    }
    return Condition(
      text: _toString(json['text']),
      icon: _toString(json['icon']),
      code: _toInt(json['code']),
    );
  }

  factory Condition.empty() => Condition(text: '', icon: '', code: 0);
}

class AirQuality {
  final double co;
  final double no2;
  final double o3;
  final double so2;
  final double pm2_5;
  final double pm10;
  final int usEpaIndex;
  final int gbDefraIndex;

  AirQuality({
    required this.co,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm2_5,
    required this.pm10,
    required this.usEpaIndex,
    required this.gbDefraIndex,
  });

  factory AirQuality.fromJson(dynamic json) {
    if (json == null || json is! Map<String, dynamic>) {
      return AirQuality.empty();
    }
    return AirQuality(
      co: _toDouble(json['co']),
      no2: _toDouble(json['no2']),
      o3: _toDouble(json['o3']),
      so2: _toDouble(json['so2']),
      pm2_5: _toDouble(json['pm2_5']),
      pm10: _toDouble(json['pm10']),
      usEpaIndex: _toInt(json['us-epa-index']),
      gbDefraIndex: _toInt(json['gb-defra-index']),
    );
  }

  factory AirQuality.empty() => AirQuality(
    co: 0,
    no2: 0,
    o3: 0,
    so2: 0,
    pm2_5: 0,
    pm10: 0,
    usEpaIndex: 0,
    gbDefraIndex: 0,
  );
}

class Astro {
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final String moonPhase;
  final int moonIllumination;
  final int isMoonUp;
  final int isSunUp;

  Astro({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.moonIllumination,
    required this.isMoonUp,
    required this.isSunUp,
  });

  factory Astro.fromJson(dynamic json) {
    if (json == null || json is! Map<String, dynamic>) {
      return Astro.empty();
    }
    return Astro(
      sunrise: _toString(json['sunrise']),
      sunset: _toString(json['sunset']),
      moonrise: _toString(json['moonrise']),
      moonset: _toString(json['moonset']),
      moonPhase: _toString(json['moon_phase']),
      moonIllumination: _toInt(json['moon_illumination']),
      isMoonUp: _toInt(json['is_moon_up']),
      isSunUp: _toInt(json['is_sun_up']),
    );
  }

  factory Astro.empty() => Astro(
    sunrise: '',
    sunset: '',
    moonrise: '',
    moonset: '',
    moonPhase: '',
    moonIllumination: 0,
    isMoonUp: 0,
    isSunUp: 0,
  );
}

// helpers
double _toDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  final parsed = double.tryParse(value.toString());
  return parsed ?? 0.0;
}

int _toInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is double) return value.toInt();
  return int.tryParse(value.toString()) ?? 0;
}

String _toString(dynamic value) {
  if (value == null) return '';
  return value.toString();
}
