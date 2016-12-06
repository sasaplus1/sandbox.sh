# sandbox.sh

manage sandbox directory

## Installation

add to your `.bashrc` or `.bash_profile` the following:

```sh
. /path/to/sandbox.sh
```

## Usage

### c | create

```sh
$ sandbox create [sandbox name]
```

create sandbox directory, and show created sandbox's path.

### cd

```sh
$ sandbox cd [sandbox name]
```

move to sandbox directory.

### ls | list

```sh
$ sandbox list [-p]
```

show sandboxes list.

### rm | remove

```sh
$ sandbox remove [sandbox name]
```

remove sandbox directory.

## License

The MIT license. Please see top of `sandbox.sh`.
