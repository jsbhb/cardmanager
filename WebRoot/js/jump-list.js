function jump(id){
	var p = window;
	while(p != p.parent){
		p = p.parent;
	    self.$ = parent.$;
	}
	$(p.document.getElementById(id)).find('a').click();
}