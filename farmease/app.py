from flask import Flask, render_template
import requests
import geocoder
from datetime import datetime, timedelta

app = Flask(__name__)

API_KEY = "1b8c69e86e960c186cb3a038e93a31d5"  # Replace with your OpenWeatherMap API Key

# Function to get user's location
def get_location():
    g = geocoder.ip("me")
    return g.latlng if g.ok else None

# Function to get current weather
def get_weather(lat, lon):
    url = f"https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API_KEY}&units=metric"
    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        return {
            "condition": data["weather"][0]["main"],
            "temperature": data["main"]["temp"]
        }
    return None

# Function to get 7-day forecast (excluding today)
def get_forecast(lat, lon):
    url = f"https://api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}&appid={API_KEY}&units=metric"
    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        forecast_list = data["list"]

        # Extract next 7 days' weather (skip today)
        daily_forecast = {}
        for entry in forecast_list:
            date = entry["dt_txt"].split(" ")[0]  # Extract date
            if date not in daily_forecast:  # Get only one entry per day
                daily_forecast[date] = {
                    "temperature": entry["main"]["temp"],
                    "condition": entry["weather"][0]["main"]
                }

        # Convert to list and remove today's weather
        today = datetime.now().strftime("%Y-%m-%d")
        next_7_days = [
            {"date": (datetime.strptime(day, "%Y-%m-%d")).strftime("%A, %d %b"), **info}
            for day, info in daily_forecast.items() if day > today
        ][:7]  # Get only next 7 days

        return next_7_days
    return None

# Function to map weather conditions to emojis
def get_weather_emoji(condition):
    emojis = {
        "Thunderstorm": "⛈️",
        "Drizzle": "🌦️",
        "Rain": "🌧️",
        "Snow": "❄️",
        "Clear": "☀️",
        "Clouds": "☁️",
        "Mist": "🌫️",
        "Fog": "🌫️",
        "Haze": "🌁",
        "Smoke": "💨",
        "Dust": "🌪️",
        "Sand": "🌪️",
        "Ash": "🌋",
        "Squall": "💨",
        "Tornado": "🌪️"
    }
    return emojis.get(condition, "❓")

# Home Route (Current Weather)
@app.route("/")
def home():
    location = get_location()
    if location:
        weather_data = get_weather(location[0], location[1])
        if weather_data:
            condition = weather_data["condition"]
            temp = weather_data["temperature"]
            emoji = get_weather_emoji(condition)
            return render_template("weather_index.html", condition=condition, temp=temp, emoji=emoji)
    return "Could not fetch weather data."

# Forecast Route (Next 7 Days)
@app.route("/forecast")
def forecast():
    location = get_location()
    if location:
        forecast_data = get_forecast(location[0], location[1])
        if forecast_data:
            for day in forecast_data:
                day["emoji"] = get_weather_emoji(day["condition"])  # Add emoji to each day
            return render_template("forecast.html", forecast=forecast_data)
    return "Could not fetch weather forecast."

if __name__ == "__main__":
    app.run(debug=True)