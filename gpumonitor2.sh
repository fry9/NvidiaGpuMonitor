     

#!/bin/bash
# usage: gpumonitor2.sh


while :;
        do
        clear

        smiAll="$(nvidia-smi --format=csv --query-gpu=name,power.draw,fan.speed,temperature.gpu,clocks.video,clocks.mem)"
        IFS=',' read -r -a arrayAll <<< "$smiAll"

         for elemnt in "${arrayAll[@]}"
        do
                echo "$(tput setaf 1)$elemnt"
        done

         # GPU name
        smiName="$(nvidia-smi --format=csv --query-gpu=name)"
        outputName=${smiName##*.}
        outputName="$(echo $outputName | sed "s/[^[:digit:]. -]//g")"
        IFS=' ' read -r -a arrayName <<< "$outputName"

        # Power draw
        smiPower="$(nvidia-smi --format=csv --query-gpu=power.draw)"
        outputPower=${smiPower#*.}
        outputPower="$(echo $outputPower | sed "s/[^[:digit:]. -]//g")"
        IFS=' ' read -r -a arrayPower <<< "$outputPower"

        # Fan speed
        smiFan="$(nvidia-smi --format=csv --query-gpu=fan.speed)"
        outputFan=${smiFan#*.}
        outputFan="$(echo $outputFan | sed "s/[^[:digit:]. -]//g")"
        IFS=' ' read -r -a arrayFan <<< "$outputFan"

        # Temp
        smiTemp="$(nvidia-smi --format=csv --query-gpu=temperature.gpu)"
        outputTemp=${smiTemp#*.}
        outputTemp="$(echo $outputTemp | sed "s/[^[:digit:]. -]//g")"
        IFS=' ' read -r -a arrayTemp <<< "$outputTemp"

        # GPU clock
        smiVideoClock="$(nvidia-smi --format=csv --query-gpu=clocks.video)"
        outputVideoClock=${smiVideoClock##*.}
        outputVideoClock="$(echo $outputVideoClock | sed "s/[^[:digit:]. -]//g")"
        IFS=' ' read -r -a arrayVideoClock <<< "$outputVideoClock"

        # MEM clock
        smiMemClock="$(nvidia-smi --format=csv --query-gpu=clocks.mem)"
        outputMemClock=${smiMemClock##*.}
        outputMemClock="$(echo $outputMemClock | sed "s/[^[:digit:]. -]//g")"
        IFS=' ' read -r -a arrayMemClock <<< "$outputMemClock"


        tput cup 100 50

        for nameE in "${arrayName[@]}"
        do
                echo "$(tput setaf 1)$nameE"
        done

        for powerE in "${arrayPower[@]}"
        do
                echo "$(tput setaf 1)$powerE W"
        done

        for fanE in "${arrayFan[@]}"
        do
                echo "$(tput setaf 4)$fanE %"
        done

        for tempE in "${arrayTemp[@]}"
        do
                echo "$(tput setaf 3)$tempE C"
        done

        for videoClockE in "${arrayVideoClock[@]}"
        do
                echo "$(tput setaf 2)$videoClockE MHz"
        done

        for memClockE in "${arrayMemClock[@]}"
        do
                echo "$(tput setaf 2)$memClockE MHz"
        done

        echo "$(nvidia-smi --format=csv --query-gpu=name,power.draw,fan.speed,temperature.gpu,clocks.video,clocks.mem)"

        sleep 5

done




