# RISC-V-Pipeline

This project implements a RISC-V processor with pipelining features. The design includes various modules such as ALU, control units, memory units, and hazard detection mechanisms. It aims to provide a comprehensive understanding of how a RISC-V processor works.

## Project Structure

The project consists of the following files:

### Main Files from [merldsu/RISCV_Single_Cycle_Core](https://github.com/merldsu/RISCV_Single_Cycle_Core)

- `ALU.v`: Arithmetic Logic Unit implementation.
- `ALU_Decoder.v`: Decodes ALU operations.
- `Control_Unit_Top.v`: Main control unit for the processor.
- `Data_Memory.v`: Implements data memory functionality.
- `Instruction_Memory.v`: Implements instruction memory functionality.
- `Main_Decoder.v`: Decodes instructions for the control unit.
- `Mux.v`: Multiplexer for selecting inputs.
- `PC.v`: Program counter implementation.
- `PC_Adder.v`: Adds to the program counter.
- `Register_File.v`: Register file for storing data.
- `Sign_Extend.v`: Sign extension for immediate values.

### Additional Files Created for Pipelining

- `Decode_Cyle.v`: Implements the decode cycle for pipelining.
- `Execute_Cycle.v`: Implements the execute cycle for pipelining.
- `Fetch_Cycle.v`: Implements the fetch cycle for pipelining.
- `Hazard_unit.v`: Handles hazard detection and forwarding.
- `Memory_Cycle.v`: Implements the memory access cycle for pipelining.
- `Pipeline_Top.v`: Top-level module for the pipelined implementation.
- `Writeback_Cycle.v`: Implements the writeback cycle for pipelining.
- `pipeline_tb.v`: Testbench for the pipelined implementation.

### Testbenches Created

- `tb_decode_cycle.v`: Testbench for the decode cycle module.
- `tb_execute_cycle.v`: Testbench for the execute cycle module.
- `tb_fetch_cycle.v`: Testbench for the fetch cycle module.
- `tb_memory_cycle.v`: Testbench for the memory cycle module.
- `tb_writeback_cycle.v`: Testbench for the writeback cycle module.

## Running the Simulation

To run the test benches, follow these steps:

1. **Compile the Design**: Open a terminal and navigate to the project directory. Use the following command to compile the design files and test benches:

```bash
   iverilog -o out.vvp File_Name.v tb_file_name.v  
```
Replace `File_Name.v` with the main design file you want to simulate and `tb_file_name.v` with the corresponding testbench file for that design.

2. **Run the Simulation**: Execute the simulation with the command:
```bash
   vvp out.vvp  
```
Rectify the errors if found any.

3. **View the Results**: To visualize the simulation results, you can use GTKWave:
```bash
   gtkwave filename_dump.vcd  
```
Replace filename with the name of the generated VCD file from the simulation.


## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.
