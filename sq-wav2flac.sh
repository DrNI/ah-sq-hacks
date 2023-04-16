#!/bin/bash
#
# The Allen&Heath SQ series USB recorder has or had a bug that wrote WAV files wich
# are technically incomplete and thus flac refuses to operate on them.
#
# If you want to archive your recordings as FLAC files, this script will work around
# the bug.
#
# Needs mediainfo, ffmpeg, flac, tempfile
#
#
# sq-wav2flac.sh
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
newFileName="$BASE.flac"
tmpWav=$(tempfile -s '.wav')


trackname=$(mediainfo "$IN" |grep -i 'Track name' | sed -e 's/^.*: //')

# WAV-datei "reparieren" via ffmpeg (bis Bug in SQ Firmware behoben)
ffmpeg -y -i "$IN" -c:a pcm_s24le "$tmpWav"

flac --best -T TITLE="$trackname" --delete-input-file --best -o "$newFileName" "$tmpWav"


