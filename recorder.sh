#!/bin/bash

current_date=$(date +"%Y-%m-%d-%H-%M-%S")
audio_device="alsa_output.usb-Focusrite_Scarlett_Solo_USB_Y7B9HUW0596E51-00.HiFi__Line1__sink.monitor"

#wf-recorder --audio=alsa_output.usb-Schiit_Audio_I_m_Fulla_Schiit-00.iec958-stereo.monitor -c h264_vaapi -p crf=30 -f $HOME/Videos/Recordings/Recording-$current_date.mp4
#wf-recorder --audio=alsa_output.usb-Schiit_Audio_I_m_Fulla_Schiit-00.iec958-stereo.monitor -p r=60 -p crf=27 -f $HOME/Videos/Recordings/Recording-$current_date.mp4
wf-recorder --audio="$audio_device" -c h264_vaapi -p r=60 -p crf=20 -f $HOME/Videos/Recordings/Recording-$current_date.mp4
