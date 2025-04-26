# Vagrant Stack mit Docker Provider

Dieses Setup ersetzt die RockyLinux Box und den VirtualBox Provider
durch Docker mit einem Ubuntu-basierten SSHD fähigem Image.

Die id_ecdsa wurde mit der folgenden Befehlszeile ohne Passwort (`-N ""`) erzeugt:

```shell
ssh-keygen -N "" -f ./id_ecdsa -t ecdsa -b 521 -C vagrant@localhost
```

Starte den Stack:

```shell
vagrant up
```

Die Fehlermeldungen bzgl. fstab können ignoriert werden.

Beende den Stack:

```shell
vagrant halt
```

Lösche den Stack:

```shell
vagrant destroy -f
```

Durch `-f` wird die Rückfrage vor dem Löschen übersprungen.
