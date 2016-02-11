LIBS_FOLDER = "$(HOME)/bin/neufbox_change_bruit"
TMP_FOLDER="$(LIBS_FOLDER)/tmp"

install: clean
	mkdir -p $(LIBS_FOLDER)
	cp neufbox_change_marge_bruit.sh $(LIBS_FOLDER)/
	chmod +x $(LIBS_FOLDER)/neufbox_change_marge_bruit.sh
	ln -s $(LIBS_FOLDER)/neufbox_change_marge_bruit.sh $(HOME)/bin/neufbox_change_marge_bruit.sh
	cp -r templates/ $(LIBS_FOLDER)
	wget -q -P $(LIBS_FOLDER)/ https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-x86_64.tar.bz2
	tar -C $(LIBS_FOLDER) -xjf $(LIBS_FOLDER)/*.tar.bz2


clean:
	for i in `ls -d $(LIBS_FOLDER)/*`;do rm -rf "$i";done
	rm -f "$(HOME)/bin/neufbox_change_marge_bruit.sh
