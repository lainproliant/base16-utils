#!/usr/bin/env python3
import os
import pathlib
import shlex
import subprocess
import textwrap


# -------------------------------------------------------------------
THEME_FILE = pathlib.Path("./theme")


# -------------------------------------------------------------------
def list_themes():
    return subprocess.check_output("./list-themes.sh").decode("utf-8").split("\n")


# -------------------------------------------------------------------
def load_theme():
    with open(THEME_FILE.name, "r") as infile:
        return infile.read().strip()


# -------------------------------------------------------------------
def save_theme(theme):
    subprocess.call(["./apply.sh", theme])


# -------------------------------------------------------------------
def main():
    themes = list_themes()
    theme = themes[0]

    try:
        theme = load_theme()
    except FileNotFoundError:
        theme = themes[0]

    try:
        index = themes.index(theme)
    except ValueError:
        index = 0

    while True:
        theme = themes[index]
        inp = input(f"{theme} > ")
        if not inp:
            continue

        cmd, *args = shlex.split(inp)

        if "exit".startswith(cmd) or "quit".startswith(cmd):
            break

        if "next".startswith(cmd):
            index += 1
            if index >= len(themes):
                index = 0
            save_theme(themes[index])

        elif "prev".startswith(cmd):
            index -= 1
            if index < 0:
                index = 0
            save_theme(themes[index])

        elif "list".startswith(cmd):
            os.system('./list-themes.sh | less')

        elif "clear".startswith(cmd):
            os.system('clear')

        elif "set".startswith(cmd):
            if not args:
                print('Missing theme argument.')
                continue
            try:
                index = themes.index(args[0])
            except ValueError:
                print(f"Scheme '{args[0]}' doesn't exist.")
            save_theme(themes[index])


# -------------------------------------------------------------------
if __name__ == "__main__":
    main()
