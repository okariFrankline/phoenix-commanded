// We import the CSS which is extracted to its own file by esbuild.
// Remove this line if you add a your own CSS build pipeline (e.g postcss).

// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"

// this line ensures that we have turbo installed
import "@hotwired/turbo"
import { Application } from '@hotwired/stimulus'
// import { definitionsFromContext} from '@hotwired/stimulus-webpack-helpers'
import CounterController from './controllers/counter_controller';


window.Stimulus = Application.start()
// const context = require.context("./controllers", true, /\.js$/);
// window.Stimulus.load(definitionsFromContext(context))
window.Stimulus.register("counter", CounterController)


// // ensure that dom is mounted
// document.addEventListener('DOMContentLoaded', function () {
//     console.log('Dom ready')
// })

// // confirm that turbo was installed correctly
// document.addEventListener('turbo:load', function () {
//     // An important thing to keep in mind is that this event `turbo:load`
//     // can be used for more complex setups like behaviour installs

//     // However, its important to know that turbo:load runs everytime a new 
//     // page is loaded (navigation and initial loads as well). This means that
//     // a lot of care has to be taken to ensure that behaviours are installed 
//     // only for the required pages
//     console.log('Turbo has been setup correctly')
// })

// // To confirm the caching of pages, lets log that cache is happening
// document.addEventListener('turbo:before-cache', function () {
//     console.group("Turbo before cache called")

//     // We are also going to reset the form, so that when the preview is 
//     // shown, the form is empty
//     let form = document.querySelector("form")

//     if (form) {
//         form.reset()
//     }
// })
























// Establish Phoenix Socket and LiveView configuration.
// import {Socket} from "phoenix"
// import {LiveSocket} from "phoenix_live_view"
// import topbar from "../vendor/topbar"

// let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
// let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})

// Show progress bar on live navigation and form submits
// topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
// window.addEventListener("phx:page-loading-start", info => topbar.show())
// window.addEventListener("phx:page-loading-stop", info => topbar.hide())

// connect if there are any LiveViews on the page
// liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
// window.liveSocket = liveSocket

