# ah-sq-hacks
Some hacky wacky scripts for things having to do with the Allen&amp;Heath SQ series of digital mixing consoles


## Usage

You can put the scripts to your $HOME/bin.

Usually you'd open up a console and then go to the directory in which your multitrack recording sits and do something like: find * -iname "*.wav" -exec sq-wav2flac.sh "{}" \;

## Recommended Workflow

1. Use wav-rename-to-trackname.sh - if you were recording from the Direct Outs, your file names will now be extended with the channel name.
2. Carefully use sq-remove-if-silent.sh to get rid of tracks that were not used - or skip this vulnerable step.
3. If you want to archive your files, you can use sq-wav2flac.sh to create losless FLAC audio files. (Which a decent DAW such as MixBus can even decode on the fly while mixing/editing).


## Obacht!

These scripts may damage your recorded data. Use at own risk. Backup is what you wish you hade made once anything went wrong. So do it now.

No warranties. I'm just sharing these scripts as they are.

## Author

Niels Ott, https://www.niels-ott.de is a fanboy for Allen&Heath products and works as an audio engineer for live and livestreaming and as a video guy for livestreaming and hybrid events.
