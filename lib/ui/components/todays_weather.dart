import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:intl/intl.dart';
import 'package:weather_apps/model/weather_model.dart';

class TodaysWeather extends StatelessWidget {
  final WeatherModel? weatherModel;

  const TodaysWeather({super.key, this.weatherModel});

  WeatherType getWeatherType(Current? current){
   
 if (current?.isDay == 1) {
      if (current?.condition?.text == "Sunny") {
        return WeatherType.sunny;
      } else if (current?.condition?.text == "Overcast") {
        return WeatherType.overcast;
      } else if (current?.condition?.text == "Partly cloudy") {
        return WeatherType.cloudy;
      } else if (current?.condition?.text == "Cloudy") {
        return WeatherType.cloudy;
      } else if (current?.condition?.text == "Clear") {
        return WeatherType.sunny;
      } else if (current?.condition?.text == "Mist") {
        return WeatherType.lightSnow;
      } else if (current!.condition!.text!.contains("thunder")) {
        return WeatherType.thunder;
      } else if (current!.condition!.text!.contains("showers")) {
        return WeatherType.middleSnow;
      } else if (current!.condition!.text!.contains("rain")) {
        return WeatherType.heavyRainy;
      }
    } else {
      if (current?.condition?.text == "Sunny") {
        return WeatherType.sunny;
      } else if (current?.condition?.text == "Overcast") {
        return WeatherType.overcast;
      } else if (current?.condition?.text == "Partly cloudy") {
        return WeatherType.cloudyNight;
      } else if (current?.condition?.text == "Cloudy") {
        return WeatherType.cloudyNight;
      } else if (current?.condition?.text == "Clear") {
        return WeatherType.sunnyNight;
      } else if (current?.condition?.text == "Mist") {
        return WeatherType.lightSnow;
      } else if (current!.condition!.text!.contains("thunder")) {
        return WeatherType.thunder;
      } else if (current!.condition!.text!.contains("showers")) {
        return WeatherType.middleSnow;
      } else if (current!.condition!.text!.contains("rain")) {
        return WeatherType.heavyRainy;
      }
    }
    return WeatherType.middleRainy;
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WeatherBg(
          weatherType: getWeatherType(weatherModel?.current),

          width: MediaQuery.of(context).size.width,
          height: 300,
        ),
        SizedBox(
          width: double.infinity,
          height: 300,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      weatherModel?.location?.name ?? "",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      DateFormat.yMMMMEEEEd().format(DateTime.parse(
                          weatherModel?.current?.lastUpdated.toString() ?? "")),
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white10,
                    ),
                    child: Image.network(
                        "https:${weatherModel?.current?.condition?.icon ?? ""}"),
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              weatherModel?.current?.tempC
                                      ?.round()
                                      .toString() ??
                                  "",
                              style: TextStyle(
                                fontSize: 80,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink,
                              ),
                            ),
                          ),
                          Text(
                            "0",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink),
                          ),
                        ],
                      ),
                      Text(
                        weatherModel?.current?.condition?.text ?? "",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text(
                              "Feels like",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              weatherModel?.current?.feelslikeC
                                      ?.round()
                                      .toString() ??
                                  "",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              "Wind",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "${weatherModel?.current?.windKph?.round()} km/h",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),


                    SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text(
                              "Humidity",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "${weatherModel?.current?.humidity}%",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              "Visibility",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "${weatherModel?.current?.visKm?.round()} km",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
