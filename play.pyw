#!/usr/bin/python
# This script runs love
import shlex, subprocess
cmd = "love --console ."
subprocess.Popen(shlex.split(cmd))