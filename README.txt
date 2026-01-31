Build and run:

docker compose up --build spacemacs-gui

Just run:

docker compose up spacemacs-gui

Notes:

docker-compose.yml contains references to a directory 'orgme'. This directory is mapped to /home/dev/workspace in the docker image, so this way you can access the files in this directory from within emacs.

docker-compose.yml maps the .spacemacs file in this repo to /home/dev/.spacemacs, so this way when you edit the customizations, the changes are persisted. If new modules are introduced, rebuild the docker image so they will be preloaded for the next startup.

On my setup, 'orgme' is a github repository where my org files are version controlled. It is assumed to be a sibling of the docker-spacemacs directory.

If your org files file are elsewhere on your PC, just edit the location in docker-compose.yml accordingly.