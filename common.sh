#!/usr/bin/env bash

status_check(){
  if [ $! -eq 0 ]; then
    echo "Done"
  else
    echo "Error"
  fi
}