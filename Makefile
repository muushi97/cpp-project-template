# ---------------------------------------------------------------------- #
#                                                                        #
#             __  __       _        _____ _ _                            #
#            |  \/  | __ _| | _____|  ___(_) | ___                       #
#            | |\/| |/ _` | |/ / _ \ |_  | | |/ _ \                      #
#            | |  | | (_| |   <  __/  _| | | |  __/                      #
#            |_|  |_|\__,_|_|\_\___|_|   |_|_|\___|                      #
#                                                                        #
# ---------------------------------------------------------------------- #

# compiler
#CXX        = g++
CXX        = clang++
# compiler option
#CXXFLAGS   = -std=c++17 -static -g -O0
CXXFLAGS   = -std=c++17 -static -g -O3 -mtune=native -march=native
# output
TARGETS    = $(shell basename $(shell pwd)).out
# output directory
TARGETDIR  = .
# header directory
HDRROOT    = ./inc
# include directory
INCLUDE    = -I$(HDRROOT)
# source directory
SRCROOT    = ./src
# object files
OBJROOT    = ./obj
# all directoryes that have some .cpp files
SRCDIRS    = $(shell find $(SRCROOT) -type d)
# all source files
SOURCES    = $(foreach dir, $(SRCDIRS), $(wildcard $(dir)/*.cpp))
# all object files
OBJECTS    = $(subst $(SRCROOT), $(OBJROOT), $(SOURCES:.cpp=.o))
# all directoryes that have some object files
OBJDIRS    = $(subst $(SRCROOT), $(OBJROOT), $(SRCDIRS))
# all dependent diles
DEPENDS    = $(OBJECTS:.o=.d)


# link
$(TARGETS): $(OBJECTS)
	$(CXX) $(CXXFLAGS) -o $(TARGETDIR)/$@ $^

# build from dependency
-include $(DEPENDS)

# for object files
$(OBJROOT)/%.o: $(SRCROOT)/%.cpp
	@if [ ! -e $(dir $@) ]; then mkdir -p $(dir $@); fi
	$(CXX) $(CXXFLAGS) -MMD -MP $(INCLUDE) -o $@ -c $<

# rebuild
all: clean $(TARGETS)

%.cpp:
	touch $(SRCROOT)/$@

%.hpp:
	$(eval F := $(addprefix IG_,$(addsuffix _HPP,$*)))
	@if [ ! -f $(HDRROOT)/$@ ]; then\
		echo \#ifndef `echo $F | tr ‘[a-z]’ ‘[A-Z]’` > $(HDRROOT)/$@;\
		echo \#define `echo $F | tr ‘[a-z]’ ‘[A-Z]’` >> $(HDRROOT)/$@;\
		echo '' >> $(HDRROOT)/$@;\
		echo \#endif >> $(HDRROOT)/$@;\
		echo '' >> $(HDRROOT)/$@;\
	fi

# clean build
clean:
	- rm $(addsuffix /*.o, $(OBJDIRS))
	- rm $(addsuffix /*.d, $(OBJDIRS))
	- rm $(TARGETDIR)/$(TARGETS)

# build and run
run: $(TARGETS)
	- ./$(TARGETS)

# not files
.PHONY: all clean

