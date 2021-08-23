# Anbox installation

## update, upgrade & clean

```bash
$ sudo apt update
$ sudo apt upgrade
$ sudo apt dist-upgrade
$ sudo apt autoremove
$ sudo apt autoclean
$ sudo apt clean
```

## Install Kernel Modules

```bash
$ sudo modprobe ashmem_linux
$ sudo modprobe binder_linux
$ ls -1 /dev/{ashmem,binder}
```

## Install the snap

```bash
$ sudo apt install snapd
```

## Install the Anbox snap

```bash
$ sudo snap install --devmode --beta anbox
```

## Update the Anbox snap

```bash
$ sudo snap refresh --beta --devmode anbox
```

## Get the Anbox snap versions

```bash
$ snap info anbox
```

## Get the Anbox snap versions

```bash
$ sudo snap remove anbox
```

## Install applications

```bash
$ sudo apt install adb
$ adb install my-app.apk
```

## Anbox

```bash
$ anbox.appmgr
```

##

```bash
$ snap restart anbox.container-manager
```

##

```bash
$ anbox launch --package=org.anbox.appmgr --component=org.anbox.appmgr.AppViewActivity
```
