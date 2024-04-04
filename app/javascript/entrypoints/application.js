import {createApp} from "vue";
import lux from "lux-design-system";
import "lux-design-system/dist/style.css";

const app = createApp({});
const createMyApp = () => createApp(app);

// create the LUX app and mount it to wrappers with class="lux"
document.addEventListener ('DOMContentLoaded', () => {
  const elements = document.getElementsByClassName('lux')
  for(let i = 0; i < elements.length; i++){
    createMyApp().use(lux).mount(elements[i]);
  }
}, { once: true })
