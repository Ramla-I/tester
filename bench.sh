#!/bin/sh
# See ReadMe.md in this directory for documentation.

THIS_DIR="$(dirname "$(readlink -f "$0")")"

if [ ! -f "$THIS_DIR/config" ]; then
  echo "[ERROR] Please create a 'config' file from the 'config.template' file in the same directory as $0"
  exit 1
fi

if [ $# -lt 2 ]; then
  echo "[ERROR] Please provide at least the type of benchmark and layer as arguments to $0"
  exit 1
fi

echo '[bench] Setting up the benchmark...'

# Ensure there are no outdated (and thus misleading) results/logs
rm -rf results *.log

# Convenience function
cleanup()
{
  "sudo pkill -9 MoonGen"
}

# Clean up already, in case some old stuff is still running
cleanup

# Delete any hugepages in case some program left them around
sudo rm -f "$(grep hugetlbfs /proc/mounts  | awk '{print $2}')"/*

if [ ! -d 'moongen' ]; then
  git clone --recurse-submodules 'https://github.com/emmericp/MoonGen' 'moongen'
  if [ $? -ne 0 ]; then
    echo '[FATAL] Could not clone MoonGen'
    exit 1
  fi

  git -C 'moongen' checkout '525d9917c98a4760db72bb733cf6ad30550d6669'
  if [ $? -ne 0 ]; then
    echo '[FATAL] Could not check out the MoonGen commit'
    exit 1
  fi
fi


"pwd"
./bench-tester.sh $@
if [ $? -eq 0 ]; then
  echo "[bench] Done! Results are in the results/ folder, and the log in $LOG_FILE, in the same directory as $0"
  RESULT=0
else
  echo '[FATAL] Run failed'
  RESULT=1
fi

# Ensure we always kill the NF at the end, even in cases of failure
cleanup

exit $RESULT