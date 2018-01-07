# the compiler to use
CC = gcc

# compiler flags:
#  -g    adds debugging information to the executable file
#  -Wall turns on most, but not all, compiler warnings

SRC_DIR = Resources/src
OBJ_DIR = Resources/Library

CFLAGS  = -c -Wall -fPIC

SFLAGS  = -shared -fPIC

SRC_FILES = $(wildcard $(SRC_DIR)/*.c)
SRCS1 = $(filter-out $(SRC_DIR)/cmd_encoder_init.c $(SRC_DIR)/modbus.c $(SRC_DIR)/ieeesingle2num.c, $(SRC_FILES))
#OBJS = $(SRCS:.c=.o)
OBJS1 = $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRCS1))	

SRCS2 = $(SRC_DIR)/modbus.c $(SRC_DIR)/ieeesingle2num.c $(SRC_DIR)/serialComm.c $(SRC_DIR)/delay.c $(SRC_DIR)/mfloor.c
OBJS2 = $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRCS2))
# the name to use for both the target source file, and the output file:
TARGET1 = $(OBJ_DIR)/libSerialComm.so
TARGET2 = $(OBJ_DIR)/libModbus.so	
all: $(TARGET1) $(TARGET2)
$(TARGET1): $(OBJS1) 
	$(CC) $(SFLAGS) -o $(TARGET1) $(OBJS1)
$(TARGET2): $(OBJS2) 
	$(CC) $(SFLAGS) -o $(TARGET2) $(OBJS2)
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@	
clean:
	$(RM) $(OBJ_DIR)/*.o *~ $(TARGET1) $(TARGET2)