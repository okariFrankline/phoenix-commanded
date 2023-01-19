/**
 *  A controller is a javascript class that is used to control an dom element
 * in which the controller is attached to.
 * 
 * In order to attach a controller to an element, we use the data attaribute `data-controller` eg
 * <div data-controller="counter"></div>
 * 
 * A controller extends the Stimulus.Controller class
 */

import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
    // the connect function is very important in that when an
    // the controller is started, it gets connected to the element
    // marked with 'data-controller' and execute the code inside connect
    connect() {
        this.count = 0;
        this.element.innerHTML = 'Click me'

        // add an event listener for the click and increment the counter
        this.element.addEventListener('click', () => {
            this.count++;
            this.element.innerHTML = `You clicked ${this.count} times`;
        })
    }
}
