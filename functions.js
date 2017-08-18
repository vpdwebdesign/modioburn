var start = Date.now();

function elapsedTime () {
    var end = Date.now();
    var elapsed = end - start;
    return elapsed;
}

function getTime() {
    var date = new Date();
    var hours = date.getHours();
    var minutes = date.getMinutes();
    var seconds = date.getSeconds();
    var timeStr = "";
    if (hours < 10) {
        timeStr += "0";
    }
    timeStr += hours.toString() + ":";
    if (minutes < 10) {
        timeStr += "0";
    }
    timeStr += minutes.toString() + ":";
    if (seconds < 10) {
        timeStr += "0";
    }
    timeStr += seconds.toString();
    return timeStr;
}

function getCost() {
    var cost = Math.floor(elapsedTime() / (60000));
    return cost;
}
