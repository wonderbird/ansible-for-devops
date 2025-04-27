# Vagrant Stack mit Docker Provider

Dieses Setup ersetzt die Vagrant Box geerlingguy/rockylinux8 und den
VirtualBox Provider durch Docker SSH-fähigen Images.

Das Schlüsselpaar `id_ecdsa*` wurde mit der folgenden Befehlszeile ohne
Passwort (`-N ""`) erzeugt:

```shell
ssh-keygen -N "" -f ./id_ecdsa -t ecdsa -b 521 -C vagrant@localhost
```

Es wird automatisch im Docker Container als SSH Key für den `vagrant` User
registriert und von Ansible benutzt.

Der Host Key ist ebenfalls vordefiniert, sodass er auch nach Änderungen am
Dockerfile gleich bleibt.

Konfiguriere das Dockerfile im [Vagrantfile](./Vagrantfile).

Vor dem ersten Start empfehle ich, das Docker Image zu bauen. Dadurch startet
Vagrant schneller.

```shell
docker build -t ansible-target -f Dockerfile.Fedora .
```

Starte anschließend den Stack:

```shell
vagrant up
```

Stelle sicher, dass der Stack richtig läuft:

```shell
vagrant status
```

Die drei Container `app1`, `app2` und `db1` sollten mit dem Status
`running (docker)` angezeigt werden.

```shell
docker ps
```

Die Container sollten mit dem Status `Up` angezeigt werden. Das ausgeführte
"Command" entspricht dem systemd init Prozess. Unter Fedora wird
`/usr/sbin/init` angezeigt, unter Ubuntu `/lib/systemd/systemd`.

Als nächstes müssen die SSH Host Keys für die weitergeleiteten Ports in die
eigene `~/.ssh/known_hosts` Datei eingetragen werden:

```shell
ssh -i ./ssh_user_key/id_ecdsa vagrant@localhost -p 2223 # app1
ssh -i ./ssh_user_key/id_ecdsa vagrant@localhost -p 2224 # app2
ssh -i ./ssh_user_key/id_ecdsa vagrant@localhost -p 2225 # db1
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
