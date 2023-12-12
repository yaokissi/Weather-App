<script>
import axios from 'axios';
import moment from 'moment';

export default (await import('vue')).defineComponent({
props:{
    cityName: String,
},
data() {
    return {
        forecast:[],
        loading: true,
        iconUrl: null,
    };
},
 mounted(){
   this.fetchWeatherData();
},
methods: {
    async fetchWeatherData(){
        // const apiKey = '65bc175c5da73f7fb225524b81744f56';
        const city = this.cityName; 
        const apiUrl =`https://pro.openweathermap.org/data/2.5/forecast?q=${city}&units=metric&appid=65bc175c5da73f7fb225524b81744f56`;

        await axios.get(apiUrl).then(Response => {
            const forecastData = Response.data.list;
            const filteredData = forecastData.map(item => {
                return {
                    date: moment(item.dt_txt.split('')[0]),
                    temperature: Math.round(item.main.temp),
                    description: item.weather[0].description,
                    iconUrl: `https://api.openweathermap.org/img/w/${item.weather[0].icon}.png`,
                };
            }).reduce((acc, item) => {
                if(!acc.some(day => day.date.isSame(item.date,'day'))) {
                    acc.push(item);
                }
                return acc;
            }, []).slice(1, 5);

            console.log(filteredData,"working");
            this.forecast = filteredData;
            this.loading = false;
        }).catch (error => {
            console.error('Error fetching weather data:', error);
            this.loading = false;
        });

    
    }
}

})
</script>


<template>
 <div class="days-tab text-center">
    <div v-if="loading" class="loading">Loading...</div>
    <ul v-else class="p-0">
        <li v-for="day in forecast" :key="day.date" class="li_active">
            <div class="py-3"><img :src="day.iconUrl" alt=""></div>
            <div class="py-3">{{ day.date }}</div>
            <div class="py-3">{{day.temperature}}&deg; C </div>
        </li>
        <!-- <li class="li_active">
            <div class="py-3">icon</div>
            <div class="py-3">day</div>
            <div class="py-3">12oc</div>
        </li>
        <li class="li_active">
            <div class="py-3">icon</div>
            <div class="py-3">day</div>
            <div class="py-3">12oc</div>
        </li>
        <li class="li_active">
            <div class="py-3">icon</div>
            <div class="py-3">day</div>
            <div class="py-3">12oc</div>
        </li> -->
    </ul>
 </div>
</template>

<style>
.loading {
    color:#fff;
}
ul {
    margin: 0;
}
li {
    display: inline-block;
    list-style: none;
    height: 100%;
    width: 21%;
    max-width: 21%;
    font-size: 1vw;
    line-height: 1.2;
}
span {
    display: block;
    margin-bottom: 5px;
    font: 100% sans-serif;
    height: 35px;
}
.li_active {
    background: #253d5c;
    color: #222831;
    border-radius: 10px;
    margin: 0.5rem ;
    color: #fff;
    font-weight: 600;
}
.li_active:hover {
transform: scale(1.2);
transition: transform 0.1s ease;
}
.li_active_temp {
    display: inline-block;
    background-color: #222831;
    color: #ffffff;
    transition: background-color 0.5s;
    border-radius:10px;

}
</style>
