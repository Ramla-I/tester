# tester

Files to be run on tester machine that runs the packet generator MoonGen.
Most of the code is adapted from the TinyNF benchmarking suite. (icse23 branch)

## steps
1. update config file with your device information
2. Run `./bench.sh "bench-type" "layer"`

## How to Run

Typically we run `sudo ./bench.sh standard 2` to run the whole benchmark where we find the max throughput, and then find the latency at intervals up to the max throughput

If we only want to measure latency at one throughput then we use the latencyload flag. For example we'd run `sudo ./bench.sh standard 2 -l 20000` if we wanted to measure latency at 20 Gbps.

To run ixy-bench.lus, run the command
`sudo ./moongen/build/MoonGen ixy-bench.lua 0 1 -r 20000`

of course, huge pages should be set up and interfaces bound to a DPDK driver.
