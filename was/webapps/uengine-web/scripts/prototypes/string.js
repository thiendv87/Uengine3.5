String.prototype.replaceAll = function(str1, str2) {
	var temp_str = this.trim();
	temp_str = temp_str.replace(new RegExp(str1, "gi"), str2);

	return temp_str;
}

String.prototype.trim = function() {
	 return this.replace(/(^\s*)|(\s*$)/gi, "");
}

String.prototype.encodeHtml = function() {
    if (str) {
		str = str.replace(/&/gim, "&amp;");
        str = str.replace(/</gim, "&lt;");
        str = str.replace(/>/gim, "&gt;");
		str = str.replace(/\"/gim, "&quot;");
    }
    return str;
}

String.prototype.decodeHtml = function() {
	if (str) {
		str = str.replace(/&quot;/gim, "\"");
        str = str.replace(/&gt;/gim, ">");
        str = str.replace(/&lt;/gim, "<");
		str = str.replace(/&amp;/gim, "&");
	}
	return str;
}