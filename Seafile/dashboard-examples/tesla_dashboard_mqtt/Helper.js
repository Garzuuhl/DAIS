.pragma library

function secondsToMinutesString(seconds) {
    var min = seconds/60;
    var restSec = seconds%60;
    return addLeadingZero(Math.floor(min)) + ":" + addLeadingZero(Math.floor(restSec));
}

function secondsToHoursString(seconds) {
    var min = seconds/60;
    var h = min/60;
    var restSec = seconds%60;
    var restMin = min%60;
    return addLeadingZero(Math.floor(h)) + ":" + addLeadingZero(Math.floor(restMin)) + ":" + addLeadingZero(Math.floor(restSec));
}

function addLeadingZero(value) {
    if(value<10) {
        return "0" + value;
    }
    return value;
}
