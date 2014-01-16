CC := gcc
CFLAGS := -O1 -g -Wall

UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S), Linux)
	CFLAGS += -D USE_EPOLL
endif

BASE_OBJ = src/base/hashmap.o src/base/sha2.o src/base/ini.o \
           src/base/fevent.o src/base/aes.o
ALL_OBJ = src/fconfig.o src/fnet.o src/fcrypt.o src/fcontext.o \
          src/fhandler.o src/fuser.o $(BASE_OBJ)

all: fakio-server fakio-client

fakio-server: $(ALL_OBJ)
	$(CC) $(CFLAGS) -o $@  $(ALL_OBJ) src/fserver.c

fakio-client: $(ALL_OBJ)
	$(CC) $(CFLAGS) -I ./src -o $@ $(ALL_OBJ) clients/fclient.c


.PHONY: clean
clean:
	-rm fakio-server fakio-client src/*.o src/base/*.o