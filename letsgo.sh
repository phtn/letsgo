#!/bin/zsh
echo "\nre-up.ph cli\n"
DEFAULT_ENTRY_CONTENT="package main\n\nimport (\n\t\"fmt\"\n)\n\nfunc main() {\n\tfmt.PrintLn(\"Let's fucking go!\")\n}"


    if [ $# -ne 1 ]; then
        echo "letgo <project_name>"
        return 1
    fi

    local project=$1

    if [ -d "$project" ]; then
        echo "directory with $project already exist."
        return 1
    fi

    echo "\ncreate project $1"
    mkdir -p -- "$project"

    cd -P -- "$project" &&
    echo "building folder structures..."
    mkdir -p -- cmd/"$project" &&
    mkdir -p -- internal/service internal/models internal/repo &&
    mkdir -p -- api build config docs pkg/utils scripts

    local default_content=$DEFAULT_ENTRY_CONTENT
    echo "adding init files..."
    echo "$default_content" >> "cmd/$project/main.go"
    touch config/config.go
    echo "module $project" >> "go.mod"
    echo "done.\n"
}
letgo
