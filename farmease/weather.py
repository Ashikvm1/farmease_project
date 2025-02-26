from flask import Flask, request, jsonify
import requests

app = Flask(__name__)
API_KEY = "1b8c69e86e960c186cb3a038e93a31d5"

def get_live_weather(lat, lon):
    url = f"http://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API_KEY}&units=metric"
    response = requests.get(url).json()

    if response.get("cod") != 200:
        return {"weather": "Error fetching weather data."}

    weather_description = response["weather"][0]["description"]
    temperature = response["main"]["temp"]
    humidity = response["main"]["humidity"]
    emoji = "🌤️" if "clear" in weather_description else "☁️" if "cloud" in weather_description else "🌧️" if "rain" in weather_description else "⛈️"

    return {"weather": f"{emoji} {weather_description.capitalize()}, {temperature}°C, Humidity: {humidity}%"}

@app.route("/weather", methods=["GET"])
def weather():
    lat = request.args.get("lat")
    lon = request.args.get("lon")
    if not lat or not lon:
        return jsonify({"weather": "Location not provided."})

    weather_data = get_live_weather(lat, lon)
    return jsonify(weather_data)

if __name__ == "__main__":
    app.run(debug=True)