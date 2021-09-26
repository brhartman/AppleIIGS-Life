NAME=LIFE
MAIN=life
MEMADDR=2000

#S5D1=bin/$(NAME)DISK.po
#S7D1=/opt/appleiigs/disks/GSOS.2mg
S5D1=
S7D1=bin/$(NAME)DISK.po
SPEED=2


DEV=/opt/appleiigs/dev

MAINBIN=obj/$(NAME).SYSTEM\#FF$(MEMADDR)
DISKNAME=$(NAME)DISK
DISKPATH=bin/$(DISKNAME).po
CONFIGPATH=config.kegs

all: disk

bin: $(MAINBIN)
$(MAINBIN): $(shell find src -type f | grep '\.s$$')
	make indent
	Merlin32 -V $(DEV)/macros src/$(MAIN).s
	mkdir `dirname $(MAINBIN)`
	mv src/$(MAIN) $(MAINBIN)
	rm src/_FileInformation.txt

disk: $(DISKPATH)
$(DISKPATH): $(MAINBIN)
	mkdir `dirname $(DISKPATH)`
	cadius CREATEVOLUME $(DISKPATH) $(DISKNAME) 800KB
	cadius ADDFILE $(DISKPATH) $(DISKNAME) $(DEV)/lib/PRODOS\#FF0000
	cadius ADDFILE $(DISKPATH) $(DISKNAME) $(MAINBIN)
	cadius CATALOG $(DISKPATH)

config: $(CONFIGPATH)
$(CONFIGPATH): $(DISKPATH)
	cat /dev/null > $(CONFIGPATH)
	echo 's5d1 = $(S5D1)' >> $(CONFIGPATH)
	echo 's7d1 = $(S7D1)' >> $(CONFIGPATH)
	echo 'g_limit_speed = $(SPEED)' >> $(CONFIGPATH)

run: disk config
	xkegs

indent:
	ls src/*.s | xargs -n 1 cadius INDENTFILE
	ls src/*.s | xargs -n 1 sed --in-place -e :a -e '/^\n*$$/{$$d;N;};/\n$$/ba'

clean:
	rm -f config.kegs
	rm -f src/_FileInformation.txt src/*_Output.txt
	rm -rf bin obj
