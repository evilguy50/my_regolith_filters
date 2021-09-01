import nimpy
import os
import strformat, strutils
import configparser

proc short() {.exportpy.} =
    var cfg = parseIni(readFile("BP/filters/shorthand/config.ini"))
    var shorts = cfg.getProperty("define", "shorts")
    var pshort = shorts.split(" ")
    for file in os.walkFiles(fmt"BP/functions/*.mcfunction"):
        var rFile = readFile(file)
        var rNum = -1
        for i in pshort:
            rNum.inc(1)
            var short = pshort[rNum]
            var long = cfg.getProperty("as", fmt"{pshort[rNum]}_long")
            echo fmt"short = {short} long = {long}"
            rFile = rFile.replace(short, long)
        os.removeFile(file)
        writeFile(file, rFile)