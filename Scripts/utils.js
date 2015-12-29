function toFloat(value) {
    if (value == "")
        return 0;
    var n = parseFloat(stripNumber(value));
    return isNaN(n) ? 0 : n;
}

function stripNumber(valor) {
    valor = "" + valor;
    valor = valor.replace(/m/g, "000");
    return valor.replace(/[^0123456789.]/g, "");
}

function formatNumber(valor) {
    var positive = valor >= 0;
    if (!positive)
        valor = stripNumber(valor);

    var re = new RegExp("([0-9]*)([^0-9]?)([0-9]*)");
    var arr = re.exec(valor);
    var pos = RegExp.$1.length;
    valor = "";
    var count = 0;

    for (; pos; ) {
        if (count++ % 3 == 0 && count > 1)
            valor = "," + valor;

        valor = RegExp.$1.charAt(--pos) + valor;
    }

    if (valor == "")
        valor = "0";

    return positive ? valor : "(" + valor + ")";
}