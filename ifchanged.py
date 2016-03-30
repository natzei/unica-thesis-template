#!/usr/bin/env python2

import sys, os, time

if len(sys.argv) < 2:
    print >> sys.stderr, "usage: ifchanged.py file1 .. filen command"
    sys.exit(1)

filenames = sys.argv[1:-1]
command   = sys.argv[-1]

def scan_files():
    t = 0
    for f in filenames:
        try: t = max(t, os.stat(f)[9])
        except OSError: pass
    return t

#print filenames
#print command

time_old = 0
while 1:
    time.sleep(1)
    time_new = scan_files()
    if time_new != time_old:
        # print "time = ", time_old, time_new
        os.system(command)
	print "@@@ done."
        time_old = time_new
