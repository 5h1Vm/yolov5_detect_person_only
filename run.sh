#!/usr/bin/bash


if [ $(adb devices | wc -l) -eq 3 ]; then
	echo "OK"
else
	echo "ADB Error!"
	exit 1
fi

while :
do
	adb shell screencap -p > tmp.png
	python3 yolov5_detect_person_only/detect.py --source tmp.png --nosave 2> err.txt
	echo $(cat err.txt | grep image | cut -d: -f2 | head -n 1)
	rm -rf tmp.png err.txt
	echo " "
done
