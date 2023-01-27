# Author: IA
# ---


function weather
  set -f apikey 77f7080151722ca9e3852f7a65b08563
  # Bashundhara R/A, Dhaka
  set -f lat 23.820651
  set -f lon 90.437630

  http "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$apikey"
  http "https://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&units=metric&appid=$apikey"

end
