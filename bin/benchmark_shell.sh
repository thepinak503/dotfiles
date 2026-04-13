#!/usr/bin/env bash
# =============================================================================
# Shell Startup Benchmarker
# Measures how fast your "Supreme" shell loads.
# =============================================================================

shell_to_test="${1:-$SHELL}"
iterations=5

echo "Benchmarking startup time for $shell_to_test ($iterations iterations)..."

total=0
for i in $(seq 1 $iterations); do
    # Time the shell startup
    # -i: interactive, -c exit: immediately exit
    # We use 'time' and parse real time
    t=$( (time -p $shell_to_test -i -c exit) 2>&1 | grep real | awk '{print $2}')
    echo "  Iteration $i: ${t}s"
    total=$(echo "$total + $t" | bc)
done

avg=$(echo "scale=3; $total / $iterations" | bc)
echo -e "\n-----------------------------------"
echo -e "AVERAGE STARTUP TIME: ${avg}s"
echo -e "-----------------------------------"

if (( $(echo "$avg < 0.15" | bc -l) )); then
    echo "Result: WORLD CLASS (Instant)"
elif (( $(echo "$avg < 0.30" | bc -l) )); then
    echo "Result: EXCELLENT (Snappy)"
else
    echo "Result: NEEDS OPTIMIZATION (Bloated)"
fi
