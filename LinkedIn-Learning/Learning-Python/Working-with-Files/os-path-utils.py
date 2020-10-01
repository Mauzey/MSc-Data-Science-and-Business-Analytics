# import
from datetime import date, time, timedelta
from os import path

import datetime
import time
import os


def main():
    # print the name of the operating system
    print(os.name)
    
    # check for item existence and type
    print("\nItem exists: " + str(path.exists("textfile.txt")))
    print("Item is a file: " + str(path.isfile("textfile.txt")))
    print("Item is a directory: " + str(path.isdir("textfile.txt")))
    
    # work with file paths
    print("\nItem path: " + str(path.realpath("textfile.txt")))
    print("\nItem path and name: " + str(path.split(path.realpath("textfile.txt"))))
    
    # get the modification time
    t = time.ctime(path.getmtime("textfile.txt"))
    print("\n" + t)
    print(datetime.datetime.fromtimestamp(path.getmtime("textfile.txt")))
    
    # calculate how long ago the item was modified
    td = datetime.datetime.now() - datetime.datetime.fromtimestamp(
        path.getmtime("textfile.txt"))
    
    print("It has been " + str(td) + " since the file was last modified...")
    print("...or, " + str(td.total_seconds()) + " seconds")


if __name__ == '__main__':
    main()
