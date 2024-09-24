CC = cc
CFLAGS = -I./libpg_query -I./
LDFLAGS = -L./libpg_query -lpg_query -lpthread
BIN_DIR  = bin

TARGET = syntax_valid
SRC = syntax_valid.c cJSON.c

TEST_TARGET = test
TEST_SRC = syntax_test.c

$(TARGET): $(SRC)
	mkdir -p bin
	$(CC) $(CFLAGS)  $(SRC) -o bin/$(TARGET) $(LDFLAGS) 

$(TEST_TARGET): 
	mkdir -p bin
	$(CC) $(CFLAGS)  $(TEST_SRC) -o bin/$(TEST_TARGET) $(LDFLAGS)

all: ${BIN_DIR}/$(TARGET) ${BIN_DIR}/$(TEST_TARGET)

clean:
	rm -rf ${BIN_DIR}
