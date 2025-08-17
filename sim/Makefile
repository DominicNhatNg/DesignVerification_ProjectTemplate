#/////////////////////////////////////////////////////////////////////////////////////////////////////////////
#//                                                                                                         //
#//                                                                                                         //
#//    -+++==-          -*****+                                                                             //
#//     *%###-          .@@@@@-                                                                             //
#//      +*++=.         *@@@@-                                                                              //
#//       ====-        +%%%%=                                                                               //
#//       .====-      -####=  :++++++++++++   -++++++++=-.         :=+****+-.      .+++:       =++=         //
#//        .=+++=    :+++*-   -%%%%%%%%%%%#   +%%%%%%%%%%%#-     =#%%%%##%%%%*:    :%%%%=      #%%#         //
#//         :***#=  .====-                    =%%%:   .:*%%%-  .#%%%+:   .-*%%%+   :%%%%%*:    *%%#         //
#//          -%###=.===-:                     =%%%.     .%%%*  *%%%:        +%%%-  :%%%%%%%=   *%%#         //
#//           =%%%#**++-      -%%%%%%%%%%%#   =%%%.     =%%%= .%%%+          #%%*  :%%%==%%%*. *%%#         //
#//            =@%%###+       :++++++++++++   =%%%*****#%%%+  .%%%+         .%%%*  :%%%- :#%%%=#%%#         //
#//             +@%%%#.                       =%%%####%%%*.    *%%%-        *%%%:  :%%%=   =%%%%%%#         //
#//              *@@%:         ............   =%%%:   =%%%=     *%%%*-:..:=#%%%-   :%%%=    :#%%%%#         //
#//               #@:         =@%%%%%%%%%%%   +%%%.    :#%@*.    -*%%%%%%%%%#+.    :%%@=      +%%%#         //
#//               .:          .------------   :---      .--=:      .:-=+==-:        ---.       :---         //
#//                                                                                                         //
#//     :- :: -: : :: -.. :- ::   : -... - .-...     .. -. - ::.. -: :.  . -: -: :: : :- : : :: -:          //
#/////////////////////////////////////////////////////////////////////////////////////////////////////////////
#// Company: Veron Group                                                                                    //
#// Author: Nguyen Tien Nhat                                                                                //
#//                                                                                                         //
#// Create Date:    ../../2025                                                                              //
#// Module Name:    Run tool                                                                                //
#// Revision History:                                                                                       //    
#// Revision 0.01 - File Created (Nguyen Tien Nhat)                                                         //
#// Property of Veron Group                                                                                 //
#/////////////////////////////////////////////////////////////////////////////////////////////////////////////

TESTNAME ?= base_test
TOP 	 ?= testbench

#---------------------
# Directories
#---------------------
LOG_DIR 	= logs
WAVE_DIR 	= waveform
DB_DIR  	= db
COV_DIR 	= coverage

#-----------------------------
# Default target
#-----------------------------

all: clean build

#-----------------------------
# Compile design and Testbench
#-----------------------------

build:
	@echo "[BUILD] Running UVM Test: $(TESTNAME)"
	mkdir -p $(LOG_DIR)
	vlib work
	vmap work work
	vlog -mfcu \
		+define+UVM_NO_DPI +cover=bcesft \
		-suppress 2181 \
		+acc -sv -f filelist.f \
		+define+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR | tee compile.log

run:
	@echo "[SIM] Running UVM test: $(TESTNAME)"
	mkdir -p $(LOG_DIR) $(WAVE_DIR)
	vsim -c -voptargs=+acc -assertdebug -debugDB -l $(LOG_DIR)/$(TESTNAME).log $(TOP) \
	     -wlf $(WAVE_DIR)/$(TESTNAME).wlf \
	     -do "log -r /*; run -all; quit" \
	     +UVM_TESTNAME=$(TESTNAME)


clean:
	@echo "[CLEAN] Cleaning all generated files..."
	rm -rf *.ini work transcript *.dbg *.wlf *.log \
	$(LOG_DIR) $(WAVE_DIR) $(DB_DIR) $(COV_DIR)

