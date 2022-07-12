#!/bin/bash
set -m
./riemann_0.3.8
riemann &
riemann-dash
