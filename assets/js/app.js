import EventBus from './event-bus';

window.addEventListener('load', loadApp);

function loadApp() {
    let app = new App();
    app.init();
}

var App = function () {
    var self = this;

    self.init = function () {
        console.log('Hello world');
    }
};
