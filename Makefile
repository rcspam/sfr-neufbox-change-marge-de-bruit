LIBS_FOLDER = "$HOME/bin/neufbox_change_bruit"
TMP_FOLDER="$LIBS_FOLDER/tmp"

install: clean
	cp ./neufbox_change_marge_bruit.sh $(LIBS_FOLDER)/
	chmod +x $(LIBS_FOLDER)/neufbox_change_marge_bruit.sh
	ln -s $HOME/bin/neufbox_change_bruit/neufbox_change_marge_bruit.sh $HOME/bin/neufbox_change_marge_bruit.sh
	cp ./templates $(LIBS_FOLDER)/
	wget -q -P $(LIBS_FOLDER)/ https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-x86_64.tar.bz2
	tar -C $(LIBS_FOLDER) -xjf $(LIBS_FOLDER)/*.tar.bz2


clean:
	rm -rf $(LIBS_FOLDER)
	rm -f $HOME/bin/neufbox_change_marge_bruit.sh
