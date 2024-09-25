#!/bin/bash

exists() {
        if [ -z "`command -v $1`" ]; then
                return 1
        fi
        return 0
}
require() {
        local program=$1

        if ! exists $program; then
                echo -e "\e[31merror: $program is required but doesn't exist\e[0m"
                exit
        fi
}
