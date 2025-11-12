#!/bin/bash

mkdir -p data

items=("apple" "book" "car" "hat" "phone")

show_items() {
  echo "${items[*]}"
}

add_item() {
  read -p "Enter item: " new
  items+=("$new")
  echo "$new added"
}

save_box() {
  read -p "File to save as: " name
  echo "${items[*]}" > data/$name.txt
  echo "saved"
}

load_box() {
  read -p "File to load: " name
  if [ -f data/$name.txt ]; then
    items=($(cat data/$name.txt))
    echo "loaded"
  else
    echo "file not found"
  fi
}

list_saves() {
  echo "Saved files:"
  ls data
}

echo "1) Show items"
echo "2) Add item"
echo "3) Save box"
echo "4) Load box"
echo "5) List saved boxes"
echo "6) Exit"

read -p "Choose: " choice

case "$choice" in
  1) show_items ;;
  2) add_item ;;
  3) save_box ;;
  4) load_box ;;
  5) list_saves ;;
  6) echo "bye" ;;
  *) echo "invalid option" ;;
esac