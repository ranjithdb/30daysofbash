#!/bin/bash

NOTES_DIR="markdown_notes"

mkdir -p "$NOTES_DIR"

create_note() {
    echo "Enter the name of the new note (without extension):"
    read note_name
    note_file="$NOTES_DIR/$note_name.md"

    if [[ -f "$note_file" ]]; then
        echo "Note already exists. Use the edit option to modify it."
    else
        echo "# $note_name" > "$note_file"
        echo "New note created: $note_file"
        open_in_editor "$note_file"
    fi
}

list_notes() {
    echo "Listing all notes in $NOTES_DIR:"
    ls "$NOTES_DIR"/*.md | xargs -n 1 basename
}

edit_note() {
    echo "Enter the name of the note to edit (without extension):"
    read note_name
    note_file="$NOTES_DIR/$note_name.md"

    if [[ -f "$note_file" ]]; then
        open_in_editor "$note_file"
    else
        echo "Note does not exist."
    fi
}

delete_note() {
    echo "Enter the name of the note to delete (without extension):"
    read note_name
    note_file="$NOTES_DIR/$note_name.md"

    if [[ -f "$note_file" ]]; then
        rm "$note_file"
        echo "Note deleted: $note_file"
    else
        echo "Note does not exist."
    fi
}

view_note() {
    echo "Enter the name of the note to view (without extension):"
    read note_name
    note_file="$NOTES_DIR/$note_name.md"

    if [[ -f "$note_file" ]]; then
        cat "$note_file"
    else
        echo "Note does not exist."
    fi
}

open_in_editor() {
    local file="$1"
    ${EDITOR:-nano} "$file"  # Use $EDITOR if set, otherwise nano
}

while true; do
    echo "Markdown Note-Taking System"
    echo "1. Create a new note"
    echo "2. List all notes"
    echo "3. Edit a note"
    echo "4. Delete a note"
    echo "5. View a note"
    echo "6. Exit"
    echo "Enter your choice:"
    read choice

    case $choice in
        1) create_note ;;
        2) list_notes ;;
        3) edit_note ;;
        4) delete_note ;;
        5) view_note ;;
        6) echo "Exiting..."; break ;;
        *) echo "Invalid choice. Please enter a number between 1 and 6." ;;
    esac
done

