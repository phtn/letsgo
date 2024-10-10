package main

import "core:fmt"
import "core:os"
import "core:time"

DEFAULT_ENTRY_CONTENT := "package main\n\nimport (\n\t\"fmt\"\n)\n\nfunc main() {\n\tfmt.PrintLn(\"Let's fucking go!\")\n}"
main :: proc() {
	cwd := os.get_current_directory()
	fmt.printfln("\n cwd: %s", cwd)

	os.set_current_directory(cwd)
	main_path := fmt.tprintf("%s/main.go", cwd)
	os.write_entire_file(main_path, transmute([]byte)DEFAULT_ENTRY_CONTENT)


	// pkg_dir := fmt.tprintf("%s/gopro/pkg", cwd)
	// os.set_current_directory(pkg_dir)
	// os.make_directory("utils")
	// n_cwd := os.get_current_directory()
	// fmt.printfln("\n new cwd: %s", n_cwd)


}
