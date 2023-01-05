
# <img src="./resources/fotosync.png" width="50"> foto-sync-external-storage
Repo enables you to create a small executable, that mirrors photos on external storages (like SD-card) to specific directories

### How to create executable
The executable is created by calling ```fotosync_build.cmd```. So far only Windows is supported. Apart from the cmd-file, everyting else is OS-independent. I.e. by creating the proper shell file invocation of pyinstaller should be possible on most OS.


### How to use executable
1. Copy the executable to the external storage where fotos are stored (SD-card, ..). 
2. Call the executable for the first time. A ini-file is created. Inside the ini-file you must specific the target directory, to which the fotos are mirrored.
3. If the ini-file is set up, you can call the executable whenever there are new fotos on your the external storage
