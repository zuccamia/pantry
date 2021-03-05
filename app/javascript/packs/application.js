import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

// Internal imports, e.g:
import { triggerTabList } from '../components/tabs';
import { pickUpBarcode } from '../components/barcode-picker';
// import { initSelect2 } from '../components/init_select2';

document.addEventListener('turbolinks:load', () => {
  // Call your JS functions here
  triggerTabList();
  pickUpBarcode();
  // initSelect2();
});

import { initSelect2 } from '../components/init_select2';

document.addEventListener("turbolinks:load", function() {
  initSelect2();
});

//mobile pointer
import { showCircle } from '../components/mobile-pointer.js';
document.addEventListener("touchmove", (event) => {
  showCircle(event.targetTouches[0], 0.1);
});
document.addEventListener("click", (event) => {
  showCircle(event, 1);
});
