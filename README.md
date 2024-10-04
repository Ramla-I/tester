# tester

Files to be run on machine that runs the packet generator MoonGen.
Most of the code is adapted from the TinyNF benchmarking suite. (icse23 branch)

## steps
1. update config file with your device information
2. Run ./bench.sh bench-type layer



## How to Run

Typically we run `sudo ./bench.sh standard 2` to run the whole benchmark where we find the max throughput, and then find the latency at intervals up to the max throughput

If we only want to measure latency at one throughput then we use the latencyload flag. For example we'd run `sudo ./bench.sh standard 2 -l 20000` if we wanted to measure latency at 20 Gbps.