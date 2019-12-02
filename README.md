# Fleet-Floorplanning

Clone the following 4 repos:

https://github.com/jjthomas/Fleet

https://github.com/jjthomas/Fleet-Floorplanning

https://github.com/jjthomas/Fleet-Floorplanning-RapidWright

https://github.com/jjthomas/aws-fpga (checkout branch `minimal_single_ddr`)

Update your `~/.bashrc` or `~/.bash_profile` with the following (make sure not to include trailing slashes in directory paths):

```
FLEET_RW_HOME=/path/to/Fleet-Floorplanning-RapidWright
CLASSPATH=$CLASSPATH:$FLEET_RW_HOME/rapidwright.jar:$FLEET_RW_HOME/target/fleet-rw-1.0-SNAPSHOT.jar
AWS_FPGA=/path/to/aws-fpga
```

Install Maven and make sure it is pointing to Java 1.8+. 
Get the latest RapidWright standalone jar for your platform from https://github.com/Xilinx/RapidWright/releases
and put it at `$FLEET_RW_HOME/rapidwright.jar` (we've tested on RapidWright 2019.1).

Run `mvn package` in the Fleet-Floorplanning-RapidWright directory.

Go to the Fleet repository. Install sbt. Edit `StreamingWrapperDriver` to generate a shell for the desired number of cores (90 default) and core IO interface. You can also insert a core other than the default `Summer` (e.g. `Counter`). The inserted core determines the core IO interface of the shell.
Then run `sbt "runMain edu.stanford.fleet.StreamingWrapperDriver"`. A file called `StreamingWrapper.v` should be produced that has both the shell RTL and core RTL.

Go to Fleet-Floorplanning. Make sure Vivado 2018.2 is in your `PATH`. Run the following commands to generate a shell with sockets for the specified number of cores and core IO interface. The socket floorplan (default for 90 cores) can be found in `floorplan.txt`. The `aws_build_dcp_from_cl_main.sh` command will take a while and should be sent to a job submission system if available. Watch for any errors in these or the below commands.

```
./shell_flow.sh /path/to/Fleet/StreamingWrapper.v StreamingMemoryController /path/to/Fleet/StreamingWrapper.v Summer
cd $AWS_FPGA
source hdk_setup.sh
cd $AWS_FPGA/hdk/cl/examples/cl_dram_dma/build/scripts
./aws_build_dcp_from_cl_main.sh -strategy TIMING -io_dir /path/to/Fleet-Floorplanning
```

Now run the following command to generate core implementations for each socket column.

```
./kernel_flow.sh /path/to/Fleet/StreamingWrapper.v Summer
```

Finally, run the following command to insert cores into the sockets and generate a final dcp (`Summer_combined.dcp`).

```
./merge_flow.sh Summer
```

The `kernel_flow` and `merge_flow` steps can be run again with new cores without updating the shell, as long as the core IO interface and desired number of cores remains the same.
