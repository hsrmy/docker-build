# -*- coding: utf-8 -*-

import json
from datetime import datetime, timedelta

def output_agqr(data, dow):
    url = "https://fms2.uniqueradio.jp/agqr10/aandg1.m3u8"
    ffmpeg = "/usr/bin/ffmpeg -y -i {} -t {} -loglevel warning \"/output/{}-$(date +'%Y%m%d').mp4\"".format(url, data["second"], data["name"])
    name = data["name"]
    start = datetime.strptime(data["start"], "%H:%M")
    output_str = "{} {} * * {} {} > /dev/null 2>&1".format(start.minute, start.hour, dow, ffmpeg)
    print(output_str)

def output_radiko(data, dow):
    radigo = "/usr/bin/radigo rec"
    start = datetime.strptime(data["start"], "%H:%M")
    time = start + timedelta(seconds=data["second"])
    if start.day == time.day:
        output_str = "{} {} * * {} {} -id={} -s=$(date +'%Y%m%d'){} -o=mp3".format(time.minute, time.hour, dow, radigo, data["station"], start.strftime("%H%M%S"))
    else:
        output_str = "{} {} * * {} {} -id={} -s=$(date +'%Y%m%d' -d '-1 day'){} -o=mp3".format(time.minute, time.hour, dow+1, radigo, data["station"], start.strftime("%H%M%S"))

    print(output_str)

if __name__ == '__main__':
    with open("/usr/local/share/program.json") as file:
        programs = json.load(file)
    for i in range(0,7):
        if len(programs[str(i)]) != 0:
            for prog in programs[str(i)]:
                if prog['station'] == "agqr":
                    output_agqr(prog, i)
                else:
                    output_radiko(prog, i)