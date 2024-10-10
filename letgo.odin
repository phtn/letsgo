package main

import "core:encoding/ansi"
import "core:fmt"
import "core:mem"
import "core:os"
import "core:strings"
import "core:time"
import capsule "external/capsule"
import colors "external/odin-colors"


DEFAULT_MAIN := "package main\n\nimport (\n\t\"fmt\"\n)\n\nfunc main() {\n\tfmt.PrintLn(\"Let's fucking go!\")\n}"
DEFAULT_CONFIG := "package config\n\n import (\n\t\"fmt\"\n)\n\ntype Config struct {\n\n ServerAddress string\n}\n\nfunc LoadConfig() Config {\n\treturn Config{ServerAddress: \":8080\"}\n}"
DEFAULT_API := "package api"

letgo :: proc(project: string) -> (ok: bool) {

	// start_time := time.Millisecond
	rootDir := os.get_current_directory()

	if project == "" {
		fmt.println("letgo <project_name>")
		return false
	}

	if os.is_dir(project) {
		fmt.printf("directory with %s already exists.\n", project)
		return false
	}

	fmt.printf("\ncreate project %s\n", project)

	// Create main project directory
	os.make_directory(project)
	os.set_current_directory(project)

	fmt.println("building folder structures...")

	// Create subdirectories
	main_dirs := []string{"cmd", "internal", "api", "build", "config", "docs", "pkg", "scripts"}

	for dir in main_dirs {
		os.make_directory(dir)
	}

	fmt.println("adding init files...")

	// Create go.mod
	go_mod_content := fmt.tprintf("module %s\n", project)
	os.write_entire_file("go.mod", transmute([]byte)go_mod_content)

	// Create empty config.go
	os.write_entire_file("config/config.go", transmute([]byte)DEFAULT_CONFIG)
	os.write_entire_file("api/handler.go", transmute([]byte)DEFAULT_API)


	os.set_current_directory("cmd")
	os.make_directory(project)

	// Create main.go
	entry_path := fmt.tprintf("%s/%s/cmd/%s", rootDir, project, project)
	os.set_current_directory(entry_path)
	os.write_entire_file("main.go", transmute([]byte)DEFAULT_MAIN)


	// Adding Internal Subfolders
	internal_dir := fmt.tprintf("%s/%s/internal", rootDir, project)
	os.set_current_directory(internal_dir)

	internals := []string{"models", "repos", "service"}
	for i in internals {
		os.make_directory(i)
	}

	// Adding Pkg Subfolders
	pkg_dir := fmt.tprintf("%s/%s/pkg", rootDir, project)
	os.set_current_directory(pkg_dir)
	pkgs := []string{"utils"}
	for pkg in pkgs {
		os.make_directory(pkg)
	}

	// buf: []u8
	// elapsed := time.duration_to_string_hms(start_time, buf)
	fmt.print("done.")
	// fmt.printf(elapsed)
	fmt.println("")


	return true
}

main :: proc() {
	title := colors.BRIGHT_GREEN + colors.BOLD + "re-up.ph" + colors.BOLD_RESET + colors.RESET
	capsule.Capsule(title)

	help :=
		colors.DIM +
		"\n hint: " +
		colors.DIM_RESET +
		"\tletgo <" +
		colors.BRIGHT_CYAN +
		colors.BOLD +
		"project name" +
		colors.BOLD_RESET +
		colors.RESET +
		">\n"

	if len(os.args) < 2 {
		fmt.print()
		fmt.println(help)
		os.exit(1)
	}


	project_name := os.args[1]
	if !letgo(project_name) {
		os.exit(1)
	}
}
