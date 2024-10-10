package lines

import "core:encoding/ansi"
import "core:fmt"
import "core:mem"
import "core:os"
import "core:strings"


T_L :: "╭─"
T_R :: "─╮"
B_L :: "╰─"
B_R :: "─╯"
H_L :: "─"
V_L :: "│"

lines :: proc() {

	title := "re-up.ph"


	defer fmt.print("\n")

}

hls :: proc(n: int) -> string {
	result := strings.repeat(H_L, n / 3)
	return result
}

t_border :: proc(n: int) {
	t: []string = {T_L, hls(n), T_R}
	fmt.println(strings.concatenate(t))
}

c_content :: proc(title: string) {
	p := " "
	c: []string = {V_L, p, title, p, V_L, H_L, " Create Go Project"}
	fmt.println(strings.concatenate(c))
}

b_border :: proc(n: int) {
	b: []string = {B_L, hls(n), B_R}
	fmt.print(strings.concatenate(b))
}

Capsule :: proc(title: string) {
	lines := len(title)
	t_border(lines)
	c_content(title)
	b_border(lines)
	fmt.println("")
}
