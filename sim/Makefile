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
	@echo "[BUILD] Compiling UVM Testbench: $(TESTNAME)"
	mkdir -p $(LOG_DIR)
	vlib work
	vmap work work
	vlog -mfcu \
		+incdir+$(UVM_HOME)/src \
		$(UVM_HOME)/src/uvm.sv \
		+define+UVM_NO_DPI \
		+define+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR \
		+cover=bcesft \
		-suppress 2181 \
		+acc -sv -f filelist.f | tee $(LOG_DIR)/compile.log

# ======================================================
# Run in batch mode
# ======================================================
run: build
	@echo "[SIM] Running UVM Test: $(TESTNAME)"
	mkdir -p $(LOG_DIR) $(WAVE_DIR)
	vsim -c -voptargs=+acc -assertdebug -debugDB \
	    -l $(LOG_DIR)/$(TESTNAME).log $(TOP) \
	    -wlf $(WAVE_DIR)/$(TESTNAME).wlf \
	    -do "log -r /*; run -all; quit" \
	    +UVM_TESTNAME=$(TESTNAME)

clean:
	@echo "[CLEAN] Cleaning all generated files..."
	rm -rf *.ini work transcript *.dbg *.wlf *.log \
	$(LOG_DIR) $(WAVE_DIR) $(DB_DIR) $(COV_DIR)

