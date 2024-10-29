package main

import "core:fmt"
import "core:os"
import "core:time"

main :: proc() {
	using time, os
	sw: Stopwatch
	stopwatch_start(&sw)

	cwd := get_current_directory()
	fmt.printfln("\n cwd: %s", cwd)

	sum: i64 = 0
	for i in 1 ..= 100_000_000 {
		sum += i64(i * i * 3)
	}
	fmt.println(sum)


	stopwatch_stop(&sw)

	fmt.printf("%s\n", stopwatch_duration(sw))

}
