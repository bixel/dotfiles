#! /usr/bin/env python3
"""
Create symlinks to homebrewed python-installations that can be used alongside
pyenv.

After running this script, you can use e.g. homebrew's python@3.12 via
```
pyenv shell 3.12
```
- You can still install pyenv versions
- you can still create virtualenvironments based on the homebrew versions
"""

import subprocess
from pathlib import Path
from dataclasses import dataclass
import logging
import re

logging.basicConfig(level=logging.DEBUG)


@dataclass
class Binary:
    executable: str
    links: list[str]


BINARIES_TO_LINK = [
    Binary(executable="python{version}", links=["python3", "python"]),
    Binary(executable="pip{version}", links=["pip3", "pip"]),
    Binary(executable="idle{version}", links=["idle3", "idle"]),
    Binary(executable="pydoc{version}", links=["pydoc3", "pydoc"]),
    Binary(executable="wheel{version}", links=["wheel3", "wheel"]),
    Binary(
        executable="python{version}-config",
        links=["python3-config", "python-config"],
    ),
]
DIRS_TO_LINK = ["include", "lib", "share"]

logging.warning("Did not find homebrew, trying macports :P")
brew_prefix = Path(subprocess.check_output(["which", "port"]).decode()).parent.parent / "Library/Frameworks/Python.framework/Versions"
installed_brew_packages = ["".join(s.strip().split()[:2]) for s in subprocess.getoutput("port installed").split("\n")[1:]]
installed_versions = [re.match(r"python(\d+)@.*", p).group(1) for p in installed_brew_packages if re.match(r"python(\d+)@.*", p)]
installed_versions = [f"{v[0]}.{v[1:]}" for v in installed_versions]

logging.debug(f"{brew_prefix=}")
logging.debug(f"{installed_brew_packages=}")
logging.debug(f"{installed_versions=}")

logging.info(f"Will link following installed versions: {installed_versions}")

homedir = Path.home()
pyenv_dir = Path(subprocess.getoutput("pyenv root")) / "versions"
logging.info(f"Will add all necessary links to {pyenv_dir}")

for pyversion in installed_versions:
    logging.info(f"Check dir for {pyversion}")
    (pyenv_dir / pyversion).mkdir(exist_ok=True)
    for binary in BINARIES_TO_LINK:
        (pyenv_dir / pyversion / "bin").mkdir(exist_ok=True)
        target = (
            brew_prefix / pyversion / "bin" / binary.executable.format(version=pyversion)
        )
        source = pyenv_dir / pyversion / "bin" / binary.executable.format(version=pyversion)
        logging.debug(f"linking {source=} to {target=}")

        if source.is_symlink():
            logging.info(f"Unlinking existing link {source=}")
            source.unlink()

        source.symlink_to(target)
        for link in binary.links:
            source = pyenv_dir / pyversion / "bin" / link
            target = brew_prefix / pyversion / "bin" / binary.executable.format(version=pyversion)
            if source.is_symlink():
                logging.info(f"Unlinking existing {source=} -> {target=}.")
                source.unlink()
            logging.debug(f"Linking {source=} -> {target=}.")
            source.symlink_to(target)

    for dir_ in DIRS_TO_LINK:
        target = brew_prefix / pyversion / dir_
        source = pyenv_dir / pyversion / dir_
        if source.is_dir():
            if source.resolve() != target.resolve():
                logging.warning(
                    f"{source} is a proper directory, skipping. "
                    f"Linking for {pyversion} might be broken now."
                )
            continue
        if not source.is_symlink():
            source.symlink_to(target, target_is_directory=True)

logging.info("Rehashing pyenv")
subprocess.call(["pyenv", "rehash"])
