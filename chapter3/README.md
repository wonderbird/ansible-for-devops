# Vagrant Stack mit Docker Provider

Dieses Setup ersetzt die Vagrant Box geerlingguy/rockylinux8 und den
VirtualBox Provider durch Docker mit einem Ubuntu-basierten SSHD fähigem
Image (siehe [Dockerfile](./Dockerfile)).

Das Schlüsselpaar `id_ecdsa*` wurde mit der folgenden Befehlszeile ohne
Passwort (`-N ""`) erzeugt:

```shell
ssh-keygen -N "" -f ./id_ecdsa -t ecdsa -b 521 -C vagrant@localhost
```

Es wird automatisch im Docker Container als SSH Key für den `vagrant` User
registriert und von Ansible benutzt.

Starte den Stack:

```shell
vagrant up
```

Die Fehlermeldungen bzgl. fstab können ignoriert werden.

Stelle sicher, dass der Stack richtig läuft:

```shell
vagrant status
...
docker ps
...
```

Beide Befehle sollten die drei container `app1, app2, db1` zeigen.

Als nächstes müssen die SSH Host Keys für die weitergeleiteten Ports in die
eigene `~/.ssh/known_hosts` Datei eingetragen werden:

```shell
ssh -i id_ecdsa vagrant@localhost -p 2223 # app1
ssh -i id_ecdsa vagrant@localhost -p 2224 # app2
ssh -i id_ecdsa vagrant@localhost -p 2225 # db1
```

Anschließend kann die Host-Zuordnung in Ansible überprüft werden:

```shell
ansible multi -a "hostname"
```

Erwartete Ausgabe:

```text
app2 | CHANGED | rc=0 >>
app2
app1 | CHANGED | rc=0 >>
app1
db1 | CHANGED | rc=0 >>
db1
```

Beende den Stack:

```shell
vagrant halt
```

Lösche den Stack:

```shell
vagrant destroy -f
```

Durch `-f` wird die Rückfrage vor dem Löschen übersprungen.
