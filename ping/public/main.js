let pingService = null;

function sendPing() {
    _send_ping();
}

function startPing() {
    if (!pingService) {
        pingService = setInterval(() => {
            _send_ping();
        }, 100);
        $('#service-button').text('Stop ping');
        $('#service-button').addClass('btn-danger');
    } else {
        clearInterval(pingService);
        pingService = null;
        $('#service-button').removeClass('btn-danger');
        $('#service-button').text('Start ping');
    }
}

function _send_ping() {
    console.log('ping...');
    increment($('#ping-number'));
    $.get("/ping", data => {
        if (data == 'pong')
            console.log('pong!')
            increment($('#pong-number'));
    });
}

function increment(el){
    el.text(parseInt(el.text()) + 1);
}
