#!/bin/bash

mkdir -p data

# your items
items=("apple" "book" "car" "hat" "phone")

echo "1) Show items"
echo "2) Add item"
echo "3) Save box"
echo "4) Load box"
echo "5) List saved boxes"
echo "6) Exit"

read -p "Pick: " pick

if [ "$pick" == "1" ]; then
  echo "${items[*]}"

elif [ "$pick" == "2" ]; then
  read -p "Item: " new
  items+=("$new")
  echo "$new added"

elif [ "$pick" == "3" ]; then
  read -p "Save file name: " name
  echo "${items[*]}" > data/$name.txt
  echo "saved"

elif [ "$pick" == "4" ]; then
  read -p "File name to load: " name
  if [ -f data/$name.txt ]; then
    items=($(cat data/$name.txt))
    echo "loaded: ${items[*]}"
  else
    echo "file not found"
  fi

elif [ "$pick" == "5" ]; then
  echo "Saved files:"
  ls data

elif [ "$pick" == "6" ]; then
  read -p "save before exit? (y/n): " s
  if [ "$s" == "y" ]; then
    read -p "file name: " name
    echo "${items[*]}" > data/$name.txt
    echo "saved"
  fi
  echo "bye"

else
  echo "invalid"
fi
