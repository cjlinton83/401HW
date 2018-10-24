"""
Program-ID: P6.py
Author: Chris Linton
Team: Blue Group
Team Leader: Chris Linton
Team Members: Evan Cockerham, Subal Sapkota, Joseph Schenck
Due Date: 11-1-18
"""
from zipfile import ZipFile
import sys
import os
import shutil

outfile = open("output.txt", "w")
namelist = {}
filecount = 0

tempdir = "./temp/"

with ZipFile(sys.argv[1], "r") as zf:
    zf.extractall(tempdir)

for file in os.listdir(tempdir):
    filecount += 1
    with open(tempdir + file, "r") as infile:
        for name in infile.read().splitlines():
            if name in namelist:
                namelist[name] += 1
            else:
                namelist[name] = 1

for name, count in namelist.items():
    if count == filecount:
        print(name)
        outfile.write(name + "\n")

outfile.close()
shutil.rmtree(tempdir)