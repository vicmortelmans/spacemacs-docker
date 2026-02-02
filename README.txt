Launch the X-server first! (otherwise emacs won't display and you get a tty error)

Launch spacemacs:

	spacemacs.bat

Just run docker:

	docker compose up spacemacs-gui

Build and run:

	docker compose up --build spacemacs-gui

Notes:

- spacemacs.bat, apart from launching docker, starts a service that monitors the Windows clipboard. If an image is copies, it is saved to orgme/clipboard.png, so a customization script in .spacemacs can retrieve it for pasting in a document, because copying images through the X11 clipboard is not working.

- docker-compose.yml contains references to a directory 'orgme'. This directory is mapped to /root/workspace in the docker image, so this way you can access the files in this directory from within emacs.

On my setup, 'orgme' is a github repository where my org files are version controlled. It is assumed to be a sibling of the docker-spacemacs directory.

If your org files file are elsewhere on your PC, just edit the location in docker-compose.yml accordingly.

- docker-compose.yml maps the .spacemacs file in this repo to /root/.spacemacs, so this way when you edit the customizations, the changes are persisted. If new modules are introduced, rebuild the docker image so they will be preloaded for the next startup.

- docker-compose.yml maps the gitconfig file in your home dir to /root/.gitconfig. If it doesn't exist, do:

	git config --global --edit

- docker-compose.yml maps the .ssh directory in your home dir to /root/.ssh-volume and entrypoint.sh copies the files with proper access rights to /root/.ssh (because on a Windows host PC, access rights are wrong!). Make sure you have a key setup and GitHub knows the key.

Correct line endings are mandatory for entrypoint.sh, to correct on windows (powershell):

	(Get-Content -Raw entrypoint.sh) -replace "`r`n", "`n" | Set-Content -NoNewline -Path entrypoint.sh

- Dockerfile sets the locale and timezone!

Conclusion: to change the location of the orgme directory, adapt:
- image-clipboard.ps1
- docker-compose.yml