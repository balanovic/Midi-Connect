#!/bin/bash

# Enumerate MIDI devices
midi_ports=$(aconnect -l | grep client | awk -F' ' '{print $2}' | tr -d ':')

# Connect all MIDI devices to each other
for port in $midi_ports; do
    for other_port in $midi_ports; do
        if [ "$port" != "$other_port" ]; then
            aconnect $port $other_port
        fi
    done
done
