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
	result := strings.repeat(H_L, n)
	return result
}

t_border :: proc(n: int) {
	t: []string = {T_L, hls(n), T_R}
	fmt.println(strings.concatenate(t))
}

c_content :: proc(title: string, total_width: int) {
	p := " "
	title_with_spaces := strings.concatenate({p, title, p})
	title_len := len(title_with_spaces)
	// Calculate left and right padding for centering
	pad_total := total_width - title_len
	pad_left := pad_total / 2
	pad_right := pad_total - pad_left
	left_pad := strings.repeat(" ", pad_left)
	right_pad := strings.repeat(" ", pad_right)
	c: []string = {V_L, left_pad, title_with_spaces, right_pad, V_L}
	fmt.println(strings.concatenate(c))
}

b_border :: proc(n: int) {
	b: []string = {B_L, hls(n), B_R}
	fmt.print(strings.concatenate(b))
}

Capsule :: proc(title: string) {
	min_side_pad := 2 // Minimum spaces on each side of the title
	title_len := len(title)
	total_width := title_len + min_side_pad

	t_border(title_len / 4)

	// Center the title
	pad_total := total_width - title_len
	pad_left := pad_total
	pad_right := pad_left - 1
	left_pad := strings.repeat(" ", pad_left)
	right_pad := strings.repeat(" ", pad_right)
	c: []string = {V_L, left_pad, title, right_pad, V_L}
	fmt.println(strings.concatenate(c))

	b_border(title_len / 4)
	fmt.println("")
}
