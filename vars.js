.pragma library

var settings;
var sessions;
var currentSession;
var currentSerie;
var run;
var rid;

function toMinuts(value, locale) {
    var m = Math.floor(value/60)
    if (m===0)
        return Number(value).toLocaleString(locale, 'f', 0)+"s"
    else if (value === m*60)
        return Number(m).toLocaleString(locale, 'f', 0)+"mn"
    return Number(m).toLocaleString(locale, 'f', 0)+"mn "+Number(value-60*m).toLocaleString(locale, 'f', 0)+"s"
}
