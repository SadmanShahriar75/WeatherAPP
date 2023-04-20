import 'package:flutter/material.dart';
import 'package:weather_apps/model/weather_model.dart';
import 'package:weather_apps/services/api_services.dart';
import 'package:weather_apps/ui/components/future_forcast_listitem.dart';
import 'package:weather_apps/ui/components/hourly_weather_listitem.dart';
import 'package:weather_apps/ui/components/todays_weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiServices apiServices = ApiServices();
  final _textFieldController = TextEditingController();
  String searchText= "auto:ip";
  
  _showTextInputDialog(BuildContext context)async{
    return showDialog(context: context, builder: (context){
     return AlertDialog(
      title: Text("Search Location"),
      content: TextField(
        controller: _textFieldController,
        decoration: InputDecoration(hintText: "search by city, aip, lat, lang"),
      ),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("Cancel")),


          ElevatedButton(onPressed: (){
            if (_textFieldController.text.isEmpty){
              return;
            }
          Navigator.pop(context, _textFieldController.text);
        }, 
        child: Text("Ok")),

      ],
     );
    });
  } 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Center(
              child: Text(
            'Weather App',
          ),
          ),
          actions: [
            IconButton(onPressed: ()async{
              _textFieldController.clear();
              String text = await _showTextInputDialog(context);
              setState(() {
                searchText =text;
              });
            }, icon: Icon(Icons.search)),
            IconButton(onPressed: (){
             searchText= "auto:ip";
             setState(() {
               
             });

            }, icon: Icon(Icons.my_location)),
          ],

      
          ),


      body: SafeArea(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              WeatherModel? weatherModel = snapshot.data;

              return SizedBox(
                child: Column(
                  children: [
                    TodaysWeather(
                      weatherModel: weatherModel,
                    ),





                  const  SizedBox(
                      height: 10,
                    ),
                   const Text(
                      "Weather by Hours",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                   const SizedBox(
                      height: 10,
                    ),

                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        itemBuilder: (context, index){


                          Hour?  hour = weatherModel?.forecast?.forecastday?[0].hour?[index];
                          return HourlyWeatherListItem(
                            hour: hour,
                          );
                        },
                        itemCount: weatherModel?.forecast?.forecastday?[0].hour?.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),




                      const  SizedBox(
                      height: 10,
                    ),
                   const Text(
                      "Next 7 days weather",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                   const SizedBox(
                      height: 10,
                    ),

                    Expanded(
                      child: ListView.builder(itemBuilder: (context, index){
                        Forecastday? forcastday = weatherModel?.forecast?.forecastday?[index];
                                return FutureForcastListItem(
                                forcastday: forcastday,
                                );
                      },
                      itemCount: weatherModel?.forecast?.forecastday?.length,
                      
                      ),
                    ),
                    







                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Error has occured"),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
          future: apiServices.getWeatherData(searchText),
        ),
      ),
    );
  }
}
