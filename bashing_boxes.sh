#!/bin/bash
# Array holding 10 random items
items=("hammer" "mirror" "key" "book" "pencil" "phone" "hat" "bottle" "coin" "map")
print_list() {
    echo "---- Full List ----"
    for item in "${items[@]}"; do
        echo "$item"
         done
         echo "-------------------"
         }
         while true; do
    echo ""
    echo "===== Bashing Boxes Menu ====="
    echo "1) Print list"
    echo "2) Print item at X position"
    echo "3) Add item to list"
    echo "4) Remove last item from list"
    echo "5) Remove item from X position"
    echo "6) Exit"
    echo "=============================="
    read -p "Choose an option: " choice

    case $choice in
        1) print_list ;;
        2) print_item_at_position ;;
        3) add_item ;;
        4) remove_last_item ;;
        5) remove_item_at_position ;;
        6) echo "Goodbye!"; break ;;
        *) echo "Invalid option. Try again." ;;
    esac
done