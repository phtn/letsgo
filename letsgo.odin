package main

// Directory and file lists as constants
MAIN_DIRS: []string = {
	"api",
	"build",
	"config",
	"cmd",
	"docs",
	"internal",
	"pkg",
	"scripts",
	"tests",
	"vendor",
	"web",
}
INTERNAL_DIRS: []string = {"models", "repo", "service", "middleware", "shield"}
PKG_DIRS: []string = {"utils"}

import "core:encoding/ansi"
import "core:fmt"
import "core:os"
import capsule "external/capsule"
import colors "external/odin-colors"

DEFAULT_MAIN := "package main\n\nimport (\n\t\"fmt\"\n)\n\nfunc main() {\n\tfmt.Println(\"Lfg!\")\n}"
DEFAULT_CONFIG := "package config\n\n type Config struct {\n\n ServerAddress string\n}\n\nfunc LoadConfig() Config {\n\treturn Config{ServerAddress: \":8080\"}\n}"
DEFAULT_API := "package api"

letgo :: proc(project: string) -> (ok: bool) {
	using os

	// start_time := time.Millisecond
	rootDir := os.get_current_directory()

	if project == "" {
		fmt.println("letgo <project_name>")
		return false
	}

	if is_dir(project) {
		fmt.printf("directory with %s already exists.\n", project)
		return false
	}

	fmt.printf("\ncreate project %s\n", project)

	// Create main project directory
	make_directory(project)
	set_current_directory(project)

	fmt.println("building folder structures...")

	// Create subdirectories
	mkdirs(MAIN_DIRS)

	fmt.println("adding init files...")

	go_mod_content := fmt.tprintf("module %s\n", project)
	touch("go.mod", go_mod_content)

	makefile := fmt.tprintf(
		"run:\n\tgo run cmd/%s/main.go\nb:\n\tgo build ./build\ntidy:\n\tgo mod tidy\nfiber:\n\tgo get github.com/gofiber/fiber/v2",
		project,
	)
	touch("Makefile", makefile)

	readme := fmt.tprintf("###%s\n", project)
	touch("README.md", readme)

	touch("config/config.go", DEFAULT_CONFIG)
	touch("api/handler.go", DEFAULT_API)

	set_current_directory("cmd")
	make_directory(project)

	entry_path := fmt.tprintf("%s/%s/cmd/%s", rootDir, project, project)
	set_current_directory(entry_path)
	touch("main.go", DEFAULT_MAIN)

	internal_dir := fmt.tprintf("%s/%s/internal", rootDir, project)
	set_current_directory(internal_dir)
	mkdirs(INTERNAL_DIRS)

	pkg_dir := fmt.tprintf("%s/%s/pkg", rootDir, project)
	set_current_directory(pkg_dir)
	mkdirs(PKG_DIRS)

	fmt.print("done.")
	fmt.println("")

	return true
}

mkdirs :: proc(dirs: []string) {
	for d in dirs {
		os.make_directory(d)
	}
}
touch :: proc(filename: string, content: string) {
	os.write_entire_file(filename, transmute([]byte)content)
}

main :: proc() {
	title := colors.BRIGHT_GREEN + colors.BOLD + "LFG!" + colors.BOLD_RESET + colors.RESET
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
