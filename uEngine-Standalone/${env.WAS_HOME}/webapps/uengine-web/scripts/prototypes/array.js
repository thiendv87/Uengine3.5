Array.prototype.add = function(element) {
	var len = this.length;
	this[len] = element;
}
Array.prototype.remove = function(idx) {
	var temp = new Array();
	var j = 0;

	for(i=0; i<idx; i++) {
		temp[j++] = this[i];
	}

	for(i=idx+1; i<this.length; i++) {
		temp[j++] = this[i];
	}
	this.length=0;
	for(i=0; i<temp.length; i++) {
		this[i] = temp[i];
	}
}
