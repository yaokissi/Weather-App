<script>
import axios from 'axios';
import DaysWeather from './DaysWeather.vue';
import { defineComponent } from 'vue';

export default defineComponent({
name:'myWeather',
components:{
    DaysWeather,
},
props: {
    city: String,
},
data() {
    return {   
        cityName: this.cityName,
        temperature: null,
        description:null,
        iconUrl: null,
        date: null,
        time: null,
        day: null,
        name: null,
        sea_level: null,
        wind: null,
        humidity:null,
        country: null,
        monthNames: ["January","February","March","April","May",
        "June","July","August","September","October","November","Decembre"],
    }
    
},
async created() {
        const response = await axios.get(`https://api.openweathermap.org/data/2.5/weather?q=${this.city}&units=metric&appid=65bc175c5da73f7fb225524b81744f56`);
        const weatherData = response.data;
        this.temperature = Math.round(weatherData.main.temp);
        this.description = weatherData.weather[0].description;
        this.name = weatherData.name;
        this.wind = weatherData.wind.speed;
        this.sea_level = weatherData.main.sea_level;
        this.humidity = weatherData.main.humidity;
        this.country = weatherData.sys.country;
        this.iconUrl = `https://api.openweathermap.org/img/w/${weatherData.weather[0].icon}.png`;
        const d = new Date();
        this.day = d.getDay();
        this.date = d.getDate() + '-' + this.monthNames[d.getMonth()] + '-' + d.getFullYear();
        this.time = d.getHours() + ':' + d.getMinutes() + ':' + d.getSeconds();
        console.log(weatherData);
    },
    methods: {
  getDayName(dayNumber) {
    const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    const d = new Date();
    d.setDate(d.getDate() + dayNumber - d.getDay());
    return days[d.getDay()];
  },
},

})


</script>


<template>
  <div class="container p-0">
    <div class="d-flex">
    <div class="card main-div w-100">
        <div class="p-3">
            <h2 class="mb-1 day">{{getDayName(day)}}</h2>
            <p class="text-light date mb-0">{{date}}</p>
            <small>{{time}}</small>
            <h2 class="place"><i class="fi fi-rr-location-crosshairs"></i> {{name}}, <small>{{country}}</small></h2>
            <div class="temp">
                <h1 class="weather-temp">{{temperature}}&deg;</h1>
                <h2 class="text-light">{{description}} <img :src="iconUrl" alt=""> </h2>
            </div>
        </div>
        
    </div>
    <div class="card card-2 w-100">
        <table class="m-4">
            <tbody>
                <tr>
                    <th>Country</th>
                    <td>{{ country }}</td>
                </tr>
                <tr>
                    <th>Wind</th>
                    <td>{{ wind }}</td>
                </tr>
                <tr>
                    <th>Humidity</th>
                    <td>{{ humidity }}</td>
                </tr>
                <tr>
                    <th>Sea Level</th>
                    <td>{{sea_level}}</td>
                </tr>
                
            </tbody>
        </table>
        <DaysWeather :cityName="city"></DaysWeather>
        <div id="div_Form" class="d-flex m-3 justify-content-center">
            <form action="">
                <input type="button" value="Change Location" class="btn change-btn btn-primary" @click="$emit('change-location')">
            </form>
        </div>
    </div>
</div>
  </div>
</template>

<style>
@import url('https://cdn-uicons.flaticon.com/2.0.0/uicons-bold-rounded/css/uicons-bold-rounded.css');

body {
    color:#343d4b;
}
.container {
    z-index: 1;
}
.weather-temp {
    margin:0;
    font-weight: 700;
    font-size:4em;
}

h2.mb-1.day {
    font-size: 3em;
    font-weight: 400;
}

.main-div {
    border-radius: 20px;
    color: aliceblue;
    background-image: url("../assets/noaa-kcvlb727mn8-unsplash.jpg");
    background-size: cover;
    background-position: center;
    background-blend-mode: overlay;
    background-color: rgba(0, 0, 0, 0.5);
    background-repeat: no-repeat;
    min-height: 400px;
    position: relative;
}

.temp {
    position: absolute;
    bottom: 0;
    width: 100%;
    padding: 1rem;
}

.main-div:hover {
    
    z-index: 1;
}

.card-2{
    background-color: #212730;
    border-radius: 20px;
    padding: 1rem;
}

.card-details {
    margin-left: 19px;
}

.h1_left {
    position: absolute;
    bottom: 25px;
    left: 16px;
    font-size: 3vw;
    line-height: 1.2;
}

.h3_left {
    position: absolute;
    left: 16px;
    font-size:2vw;
    line-height: 0.5;
}

.h3_left small {
    font-size: 1rem;
}

table {
    position: relative;
    left: 15px;
    border-collapse:separate;
    border-spacing: 15px;
    width: 85%;
    text-align: left;
    max-width: 600px;
    margin:0 auto;
}

th,td {
    font-size: 18px;
    color: #fff;
}

td {
    text-align: right;
}

table,
tr:hover {
    color:red;
}

.change-btn {
    background-image: linear-gradient(to right, cyan, magenta);
    width: 100%;
    max-width: 200px;
}

.change-btn:hover {
    transform: scale(0.9);
    transition: transform 0.1s ease;
}

@media (max-width: 768px) {
    .d-flex {
        flex-direction: column !important;
    }
    
    .card {
        width: 100% !important;
        margin-bottom: 1rem;
    }
    
    .weather-temp {
        font-size: 3em;
    }
    
    h2.mb-1.day {
        font-size: 2em;
    }
    
    table {
        width: 100%;
        left: 0;
    }
    
    th, td {
        font-size: 16px;
    }
    
    .place {
        font-size: 1.5em;
    }
}
</style>
