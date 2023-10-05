all:
	stow --verbose --no-folding --target=$$HOME --restow */
delete:
	stow --verbose --target=$$HOME --delete */

