# Makefile for visual studio using nmake

CPPFLAGS = -I include /Wall
LDFLAGS = 
LDLIBS = -lm

# Turn on optimisations
CPPFLAGS = $(CPPFLAGS) /O2

# TODO : Indicate where you have put the TBB installer
TBB_DIR = <where-is-it?>

TBB_INC_DIR = $(TBB_DIR)/include

# TODO: Choose the correct library for your build
TBB_LIB_DIR = $(TBB_DIR)/lib/intel64

CPPFLAGS += -I $(TBB_INC_DIR)
LDFLAGS += -L $(TBB_LIB_DIR)

# The very basic parts
FOURIER_CORE_OBJS = src/fourier_transform.o src/fourier_transform_register_factories.o

# implementations
FOURIER_IMPLEMENTATION_OBJS =  src/fast_fourier_transform.o	src/direct_fourier_transform.o 

FOURIER_OBJS = $(FOURIER_CORE_OBJS) $(FOURIER_IMPLEMENTATION_OBJS)

bin/test_fourier_transform : src/test_fourier_transform.cpp $(FOURIER_OBJS)
	$(CPP) $(CPPFLAGS) $^ -o $@ $(LDFLAGS) $(LDLIBS)

bin/time_fourier_transform : src/time_fourier_transform.cpp $(FOURIER_OBJS)
	$(CPP) $(CPPFLAGS) $^ -o $@ $(LDFLAGS) $(LDLIBS)

all : bin/test_fourier_transform bin/time_fourier_transform
