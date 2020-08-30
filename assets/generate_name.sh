#!/bin/sh

fc-query --format='%{charset}\n' ./NotoColorEmoji.ttf | ./name_generator.py
