#!/bin/bash
# Bashing Boxes Part 3 - No while loop
# by Fareed Bello

box=()  # our list of items
data_folder="data"

# Make sure data folder exists
[ ! -d "$data_folder" ] && mkdir "$data_folder"

# --- Functions ---
print_list() {
  echo "Items in your box:"
  for item in "${box[@]}"; do
    echo "- $item"
  done
}

add_item() {
  read -p "Enter item to add: " item
  box+=("$item")
  echo "$item added."
}

save_box() {
  read -p "Enter name to save box: " name
  printf "%s\n" "${box[@]}" > "$data_folder/$name.txt"
  echo "Box saved as $name.txt"
}

load_box() {
  echo "Available boxes:"
  ls "$data_folder"
  read -p "Enter box name to load: " name
  if [ -f "$data_folder/$name.txt" ]; then
    mapfile -t box < "$data_folder/$name.txt"
    echo "Box $name loaded."
  else
    echo "Box not found!"
  fi
}

list_boxes() {
  echo "Saved boxes:"
  ls "$data_folder"
}

exit_script() {
  read -p "Save before exit? (y/n): " ans
  [ "$ans" = "y" ] && save_box
  echo "Goodbye!"
}

# --- Menu ---
echo ""
echo "1) Show items"
echo "2) Add item"
echo "3) Save box"
echo "4) Load box"
echo "5) List saved boxes"
echo "6) Exit"
read -p "Pick an option: " choice

case $choice in
  1) print_list ;;
  2) add_item ;;
  3) save_box ;;
  4) load_box ;;
  5) list_boxes ;;
  6) exit_script ;;
  *) echo "Invalid option, try again." ;;
esac