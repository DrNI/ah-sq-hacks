#!/bin/bash
#
# The multitrack recorder in the Allen & Heath SQ series does not allow you to select which tracks
# to record. So you'll have plenty of empty files.
#
#  This script uses sox to analyze your files and delete those that supposedly only contain
#  preamp noise.
#
#  USE WITH CARE! NEVER USE WITHOUT BACKUP!
#
# sq-remove-if-silent.sh
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

# leiser als X: löschen
VOL_THRESHOLD=31000


# volume adjustment (= vorgeschlagener gain boost) rausholen
adjust=$(sox "$IN" -n stat 2>&1 | grep -i 'volume adjustment' | awk '{ print $3 }')

# wenn kein volume adjustment vorhanden, dann ist digitale Stille
if [ "$adjust" = "" ] ; then
    rm "$IN" && echo "$IN gelöscht, digitale Stille" || echo "Fehler: Konnte "$IN" nicht löschen."
    exit
fi    

#nachkommastellen killen
adjust=$(echo "$adjust" | sed -e 's/\.[0-9]*$//')

# vermutlich nur grundrauschen!
if [ $adjust -gt $VOL_THRESHOLD ] ; then
    rm "$IN" && echo "$IN gelöscht, vermutlich nur Grundrauschen" || echo "Fehler: Konnte "$IN" nicht löschen."
    exit
fi

echo "$IN bleibt."
