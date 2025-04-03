<script>
import weather from './components/weather.vue'
import { defineComponent } from 'vue'

export default defineComponent({
name: 'App',
components:{
  weather
},
data (){
  return {
    city:'',
    showWeather: false,
  }
},
methods:{
  async searchWeather() {
    this.showWeather = false;
    await this.$nextTick();
    this.showWeather = true;
  }
}
})
</script>


<template>
  <div class="app">
    <video class="video-background" autoplay loop muted>
      <source src="../src/assets/Neutral Color Minimal Animated Search Bar Reminder Quotes Video.mp4" type="video/mp4">
      Votre navigateur ne prend pas en charge notre contenu  vidéo.
    </video>
    <div class="header container h-100 p-5">
    <h1 class="mb-5"><img src="../src/assets/morecast-logo.svg" width="200" alt=""></h1>
    <div class="d-flex justify-content-center h-100">
      <div class="searchbar w-50 mx-2">
          <input type="text" class="input form-control" v-model="city" name="" id="" placeholder="Enter a City">
      </div>
      <button class="btn-search btn btn-dark pr-10" @click="searchWeather">Search<i class="fi fi-br-search"></i> </button>
    </div>
    </div>
    <weather :city="city" v-if="showWeather"></weather>
  </div> 
</template>

<style scoped>
body {
  text-transform: uppercase;
  background-color: blueviolet;
}

.header {
  background: rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(10px);
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  border-radius: 10px;
  color: #fff;
  text-align: center;
  font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
  margin-top: 5em;
  padding: 1rem !important;
}

.video-background {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  object-fit: cover;
  z-index: -1;
} 

.btn-search {
  background-image: linear-gradient(to right, cyan, magenta);
  margin-left: 0.5rem;
}

i {
  margin-left: 10px;
}

@media (max-width: 768px) {
  .header {
    margin-top: 2em;
  }
  
  .searchbar {
    width: 100% !important;
    margin: 0 0 1rem 0 !important;
  }
  
  .d-flex {
    flex-direction: column !important;
  }
  
  .btn-search {
    width: 100%;
    margin: 0;
  }
  
  img[width="200"] {
    width: 150px;
  }
}
</style>
