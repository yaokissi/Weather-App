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
    searchQuery: '',
    suggestions: [],
    showSuggestions: false
  }
},
methods:{
  async searchWeather() {
    this.showWeather = false;
    await this.$nextTick();
    this.showWeather = true;
    this.showSuggestions = false;
  },
  async searchCities() {
    if (this.searchQuery.length < 2) {
      this.suggestions = [];
      return;
    }
    try {
      const response = await fetch(`https://api.openweathermap.org/geo/1.0/direct?q=${this.searchQuery}&limit=5&appid=65bc175c5da73f7fb225524b81744f56`);
      const data = await response.json();
      this.suggestions = data;
      this.showSuggestions = true;
    } catch (error) {
      console.error('Error fetching city suggestions:', error);
    }
  },
  selectCity(city) {
    this.city = city.name;
    this.searchQuery = city.name;
    this.showSuggestions = false;
    this.searchWeather();
  },
  focusSearch() {
    this.searchQuery = '';
    this.$refs.searchInput.focus();
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
      <div class="searchbar w-50 mx-2 position-relative">
          <input 
            ref="searchInput"
            type="text" 
            class="input form-control" 
            v-model="searchQuery" 
            @input="searchCities"
            placeholder="Enter a City"
          >
          <div v-if="showSuggestions && suggestions.length > 0" class="suggestions-list">
            <div 
              v-for="city in suggestions" 
              :key="city.name"
              @click="selectCity(city)"
              class="suggestion-item"
            >
              {{ city.name }}, {{ city.country }}
            </div>
          </div>
      </div>
      <!-- 
      <button class="btn-search btn btn-dark pr-10" @click="searchWeather">Search<i class="fi fi-br-search"></i> </button>
      -->
    </div>
    </div>
    <weather :city="city" v-if="showWeather" @change-location="focusSearch"></weather>
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
  position: relative;
  z-index: 1000;
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

.suggestions-list {
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  background: rgba(255, 255, 255, 0.95);
  border-radius: 10px;
  margin-top: 5px;
  z-index: 1001;
  max-height: 200px;
  overflow-y: auto;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.suggestion-item {
  padding: 10px 15px;
  color: #333;
  cursor: pointer;
  transition: all 0.2s;
  border-bottom: 1px solid rgba(0, 0, 0, 0.1);
}

.suggestion-item:last-child {
  border-bottom: none;
}

.suggestion-item:hover {
  background: rgba(0, 0, 0, 0.05);
  transform: translateX(5px);
}

.searchbar {
  position: relative;
}
</style>
