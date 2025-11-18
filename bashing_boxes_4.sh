#!/bin/bash

# -----------------------------
# Bashing Boxes – Part 4
# Random box generator using objects.txt
# -----------------------------

# current box stored in this array
box_items=()

# load objects from objects.txt into object_pool array
load_object_pool() {
    object_pool=()
    while IFS= read -r line; do
        if [[ -n "$line" ]]; then
            object_pool+=("$line")
        fi
    done < objects.txt
}

# print current box
print_box() {
    echo "----- Current Box -----"
    for item in "${box_items[@]}"; do
        echo "$item"
    done
}

# add item
add_item() {
    echo "Enter item to add:"
    read new_item
    box_items+=("$new_item")
}

# remove last item
remove_last() {
    unset box_items[-1]
}

# save box to a file in data/
save_box() {
    mkdir -p data
    echo "Enter save file name:"
    read save_name
    > data/$save_name
    for item in "${box_items[@]}"; do
        echo "$item" >> data/$save_name
    done
}

# load a saved box
load_box() {
    echo "Enter file name to load:"
    read load_name

    if [[ ! -f "data/$load_name" ]]; then
        echo "File does not exist."
        return
    fi

    box_items=()
    while IFS= read -r line; do
        box_items+=("$line")
    done < data/$load_name
}

# list all saved boxes
list_saved_boxes() {
    echo "Saved boxes in data/:"
    ls data/
}

# generate a random box from objects.txt
generate_random_box() {
    load_object_pool

    echo "How many items do you want in your new box?"
    read size

    if ! [[ "$size" =~ ^[0-9]+$ ]]; then
        echo "Not a number."
        return
    fi

    if (( size > ${#object_pool[@]} )); then
        echo "Not enough objects in the file."
        return
    fi

    box_items=()
    used=()

    while (( ${#box_items[@]} < size )); do
        rand=$(( RANDOM % ${#object_pool[@]} ))
        item="${object_pool[$rand]}"

        skip=0
        for u in "${used[@]}"; do
            if [[ "$u" == "$item" ]]; then
                skip=1
            fi
        done

        if (( skip == 0 )); then
            box_items+=("$item")
            used+=("$item")
        fi
    done

    echo "Random box generated!"
}

# menu
display_menu() {
    echo ""
    echo "----- MAIN MENU -----"
    echo "1) Print box"
    echo "2) Add item"
    echo "3) Remove last item"
    echo "4) Save box"
    echo "5) Load box"
    echo "6) List saved boxes"
    echo "7) Generate random box from file"
    echo "8) Exit"
    echo "Choose:"
    read choice
}

# main logic (no while loop, just recall menu)
main() {
    display_menu

    case $choice in
        1) print_box ;;
        2) add_item ;;
        3) remove_last ;;
        4) save_box ;;
        5) load_box ;;
        6) list_saved_boxes ;;
        7) generate_random_box ;;
        8) echo "Goodbye!"; exit 0 ;;
        *) echo "Invalid option." ;;
    esac

    main
}

main