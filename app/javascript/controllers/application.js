import { Application } from "@hotwired/stimulus"
import 'flowbite';
import 'flowbite-datepicker';
import 'flowbite/dist/datepicker.turbo.js';


const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
