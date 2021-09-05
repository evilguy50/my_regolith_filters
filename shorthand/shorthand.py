import configparser
from os import remove
import glob

config = configparser.ConfigParser()
config.read('BP/filters/shorthand/config.ini')
shorts = config["define"]["shorts"]
pshort = shorts.split()
for filename in glob.iglob("./BP/functions/" + '**/*.mcfunction', recursive=True):
    print(filename)
    ropen = open(filename, "r")
    rFile = ropen.read()
    ropen.close()
    for i in pshort:
        short = i
        long = config["as"]["{}_long".format(i)]
        print("short = {arg1}, long = {arg2}".format(arg1 = short, arg2 = long))
        rFile = rFile.replace(short, long)
    remove(filename)
    newopen = open(filename, "x")
    newopen.write(rFile)
    newopen.close()
