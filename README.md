# Mimyal's memorizer: Ruby

The purpose of this program is to store the herbs associated to fumeology points for a player in [A Tale In The Desert](https://wiki.desert-nomad.com/index.php?title=Main_Page).

The future seemed promising as it would reduce the number of scrap papers on my desk in Tale 8.

As I  have decided to hold off on work on this ruby implementation, the interested public is welcome to fork and improve on it.  

- Improve safety in loading and saving files  
- Add suggested combinations, depending on what is already in the record, based off a player suggested herb, if required.  
- Weight herbs according to rare status/tuition use  

## What works?

Running in the terminal it is possible to load a csv file of fume points (combinations listed in rows, herbs comma-separated).

It is also possible to add new fume points, to display them, and to add them to the record.

This record can be saved to a new file, or added (warning, this is where this implementation stopped) to an existing file.

## Implementation comments
This was developed using TDD and all tests passed, except the skipped ones!

### Refactoring
I would like to force appending to files unless specified.
I would like to remove class Player, FumeologyPoint, and Herb to be replaced by FileHandler class, and deal with herb names only. These would be verified by the Herbs class.
