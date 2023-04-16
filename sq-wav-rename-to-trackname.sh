#!/bin/bash
#
# When Direct Outs are routed into the USB multitrac recorder of a Allen&Heath SQ console, 
# the track name actually gets stored into a metadata field.
#
# This script renames the .wav file to something like "TRK01 KickDr.wav"
#
# Needs mediainfo
#
# sq-rename-to-trackname.sh
# Copyright 2023 Niels Ott https://www.niels-ott.de
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

IN="$1"

# damit greppen nicht floppt
export LANG="en"


BASE=$(echo "$IN" | sed -e 's/\.wav$//i')

trackname=$(mediainfo "$IN" |grep -i 'Track name' | sed -e 's/^.*: //')

if [ "$trackname" = "" ] ; then
    echo "$IN bleibt unverändert, kann keinen Track-Name-Eintrag finden."
    exit
fi    

newFileName="$BASE $trackname.wav"

mv -v "$IN" "$newFileName"
